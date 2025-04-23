extends CharacterBody2D

# Constants & Exports
@export var gravity = 20
@export var jump_force = -500
@export var walk_speed = 150
@export var run_speed = 200
@export var crouch_walk_speed = 100
@export var crouch_run_speed = 125
@export var roll_speed_multiplier = 1.3
@export var walk_roll_speed = 200
@export var run_roll_speed = 350
@export var dash_speed_multiplier = 3.5
@export var dash_distance_multiplier = 1.2
@export var dash_cooldown = 1.0
@export var double_tap_time = 0.3

@export_range(0.0, 1.0) var acceleration = 0.1
@export_range(0.0, 1.0) var friction = 0.1
@export_range(0.0, 1.0) var decelerate_on_jump_release = 0.5

@export var dash_curve : Curve

# Node References
@onready var debug_label: Label = $"../CanvasLayer/DebugLabel"
@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var cshape = $CollisionShape2D
@onready var coyote_timer = $CoyoteTimer
@onready var jump_buffer_timer = $JumpBufferTimer
@onready var jump_height_timer = $JumpHeightTimer
@onready var roll_timer = $RollTimer
@onready var attack_timer = $AttackTimer
@onready var crouch_raycast1 = $CrouchRaycast_1
@onready var crouch_raycast2 = $CrouchRaycast_2

# Ressources - Collision shapes
var standing_cshape = preload("res://ressources/knight_standing_cshape.tres")
var crouching_cshape = preload("res://ressources/knight_crouching_cshape.tres")

# State variables
var roll_direction = 0
var current_roll_speed = 0.0
var last_tap_left_time = 0.1
var last_tap_right_time = 0.1
var dash_start_position = 0
var dash_direction = 0
var dash_timer = 0

# Flags
var print_output = true # <- Set this variable to true/false to toggle detailed output
var is_crouching = false
var stuck_under_object = false
var can_coyote_jump = false
var jump_buffered = false
var is_rolling = false
var is_dashing = false
var can_attack = true
var is_attacking = false
var is_running = false

func _physics_process(delta: float) -> void:
	is_running = Input.is_action_pressed("run")
	
	handle_gravity()
	handle_horizontal_movement(delta)
	handle_jump()
	handle_crouch()
	handle_dash(delta)
	handle_attack()
	handle_ground_state()
	update_animations(Input.get_axis("move_left", "move_right"))
	update_debug_label()
	if Input.is_action_just_pressed("toggle_debug"):
		toggle_debug_output()

# Core Mechanics
func handle_gravity():
	if !is_on_floor() && !can_coyote_jump:
		velocity.y += gravity
		velocity.y = min(velocity.y, 1000)

func handle_horizontal_movement(delta):
	var direction = Input.get_axis("move_left", "move_right")
	var speed = get_current_speed()
	
	check_double_tap_roll() # <- Comment/uncomment this line to disable/enable it
	
	if Input.is_action_pressed("roll") && is_on_floor() && !is_rolling:
		if direction != 0:
			start_roll(sign(direction))
		
	if is_rolling:
		velocity.x = current_roll_speed * roll_direction
	else:
		if direction != 0:
			velocity.x = move_toward(velocity.x, direction * speed, speed * acceleration)
		else:
			velocity.x = move_toward(velocity.x, direction * speed, walk_speed * friction)
	
	if direction != 0 && !is_rolling:
		switch_direction(direction)

func handle_jump():
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() || is_on_wall():
			velocity.y = jump_force
		else:
			buffer_jump()
	
	if Input.is_action_just_released("jump") && velocity.y < 0:
		velocity.y *= decelerate_on_jump_release

func handle_dash(delta):
	var direction = Input.get_axis("move_left", "move_right")
	var base_speed = get_current_speed()
	var speed = base_speed * dash_speed_multiplier
	var max_distance = base_speed * dash_distance_multiplier
	
	if Input.is_action_just_pressed("dash") && direction && !is_dashing && dash_timer <= 0:
		is_dashing = true
		dash_start_position = position.x
		dash_direction = direction
		dash_timer = dash_cooldown
	
	if is_dashing:
		var distance = abs(position.x - dash_start_position)
		if distance >= max_distance || is_on_wall():
			is_dashing = false
		else:
			velocity.x = dash_direction * speed * dash_curve.sample(distance / max_distance)
			velocity.y = 0
	
	dash_timer = max(0, dash_timer - delta)

func handle_attack():
	if Input.is_action_pressed("attack") && can_attack:
		is_attacking = true
		can_attack = false
		attack_timer.start()

func handle_crouch():
	if Input.is_action_just_pressed("crouch"):
		crouch()
	elif Input.is_action_just_released("crouch"):
		if above_head_is_empty():
			stand()
		elif !stuck_under_object:
			stuck_under_object = true
	
	if stuck_under_object && above_head_is_empty() && !Input.is_action_pressed("crouch"):
		stand()
		stuck_under_object = false

func handle_ground_state():
	var was_on_floor = is_on_floor()
	move_and_slide()
	
	if was_on_floor && !is_on_floor() && velocity.y >= 0:
		tell("Falling")
		can_coyote_jump = true
		coyote_timer.start()
	
	if !was_on_floor && is_on_floor():
		tell("Touched ground")
		if jump_buffered:
			tell("Buffered jump")
			jump()
			jump_buffered = false

# Movement Actions
func start_roll(direction: int):
	if is_rolling || !is_on_floor(): return
	
	is_rolling = true
	roll_direction = direction
	tell("Rolling left" if direction == -1 else "Rolling right")
	
	#current_roll_speed = run_roll_speed if is_running else walk_roll_speed
	current_roll_speed = get_current_speed() * roll_speed_multiplier
	
	switch_direction(roll_direction)
	ap.play("roll")
	roll_timer.start()
	crouch()

func crouch():
	if is_crouching: return
	tell("Crouching")
	is_crouching = true
	cshape.shape = crouching_cshape
	cshape.position.y = 0

func stand():
	if !is_crouching: return
	if !above_head_is_empty():
		tell("Can't stand: object above")
		stuck_under_object = true
		return
	tell("Standing up")
	is_crouching = false
	cshape.shape = standing_cshape
	cshape.position.y = -5

func jump():
	if is_rolling || !above_head_is_empty(): return
	if is_on_floor() || can_coyote_jump:
		velocity.y = jump_force
		can_coyote_jump = false
	else:
		buffer_jump()

func buffer_jump():
	if !jump_buffered:
		jump_buffered = true
		jump_buffer_timer.start()

# Animation & Direction
func switch_direction(direction: float):
	sprite.flip_h = direction < 0
	sprite.position.x = direction * 4

func update_animations(direction: float):
	ap.speed_scale = 1.0
	
	if is_rolling:
		ap.play("roll")
	elif is_dashing:
		if is_crouching && is_on_floor():
			ap.play("slide" if is_crouching else "dash")
	elif is_attacking:
		ap.play("crouch_attack" if is_crouching else "attack")
	elif is_on_floor():
		if direction == 0:
			ap.play("crouch" if is_crouching else "idle")
		else:
			ap.play("crouch_walk" if is_crouching else "run")
			
			if is_running:
				ap.speed_scale = 1.2
	else:
		ap.play("crouch" if is_crouching else ("jump" if velocity.y < 0 else "fall"))

# Timer Callbacks
func _on_coyote_timer_timeout(): can_coyote_jump = false
func _on_jump_buffer_timer_timeout(): jump_buffered = false

#func _on_jump_height_timer_timeout():
	#if !Input.is_action_pressed("jump") && velocity.y < -100:
		#velocity.y = -10

func _on_roll_timer_timeout():
	is_rolling = false
	if above_head_is_empty():
		stand()
	else:
		crouch()
		stuck_under_object = true

func _on_attack_timer_timeout():
	is_attacking = false
	can_attack = true

# Utility Functions
func get_current_speed() -> float:
	if is_crouching:
		return crouch_run_speed if is_running else crouch_walk_speed
	elif is_running:
		return run_speed
	else:
		return walk_speed

func above_head_is_empty() -> bool:
	return !crouch_raycast1.is_colliding() && !crouch_raycast2.is_colliding()

# Debug Output functions
func toggle_debug_output():
	print_output = !print_output
	debug_label.visible = print_output

func update_debug_label():
	var lines := []

	# Base info
	lines.append("Speed: %.2f" % get_current_speed())
	lines.append("Velocity: (%.2f, %.2f)" % [velocity.x, velocity.y])

	# Determine movement state
	var state := ""

	if is_rolling:
		state = "Rolling"
	elif is_dashing:
		state = "Dashing"
	elif !is_on_floor():
		state = "Jumping" if velocity.y < 0 else "Falling"
	elif is_crouching:
		if abs(velocity.x) > 0.1:
			state = "Crouch Running" if is_running else "Crouch Walking"
		else:
			state = "Crouching"
	else:
		if abs(velocity.x) > 0.1:
			state = "Running" if is_running else "Walking"
		else:
			state = "Idle"

	lines.append("State: %s" % state)

	debug_label.text = "\n".join(lines)

func tell(message: String) -> void:
	if print_output:
		print(message)

# Optionnal Functions
func check_double_tap_roll():
	var current_time = Time.get_ticks_msec() / 1000.0
	
	if Input.is_action_just_pressed("move_left"):
		if current_time - last_tap_left_time <= double_tap_time:
			if last_tap_left_time > last_tap_right_time:
				start_roll(-1)
		last_tap_left_time = current_time
	
	if Input.is_action_just_pressed("move_right"):
		if current_time - last_tap_right_time <= double_tap_time:
			if last_tap_right_time > last_tap_left_time:
				start_roll(1)
		last_tap_right_time = current_time
