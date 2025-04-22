extends CharacterBody2D

# Constants & Exports
@export var walk_speed = 150
@export var run_speed = 250
@export var gravity = 20
@export var jump_force = -500
@export var roll_speed = 200
@export var dash_speed = 1000.0
@export var dash_max_distance = 300.0
@export var dash_cooldown = 1.0
@export var double_tap_time = 0.3

@export_range(0.0, 1.0) var acceleration = 0.1
@export_range(0.0, 1.0) var friction = 0.1
@export_range(0.0, 1.0) var decelerate_on_jump_release = 0.5

@export var dash_curve : Curve

# Node References
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
var last_tap_left_time = 0.1
var last_tap_right_time = 0.1
var dash_start_position = 0
var dash_direction = 0
var dash_timer = 0

# Flags
var is_crouching = false
var stuck_under_object = false
var can_coyote_jump = false
var jump_buffered = false
var is_rolling = false
var is_dashing = false
var can_attack = true
var is_attacking = false

func _physics_process(delta: float) -> void:
	handle_gravity()
	handle_horizontal_movement(delta)
	handle_jump()
	handle_crouch()
	handle_dash(delta)
	handle_attack()
	handle_ground_state()
	update_animations(Input.get_axis("move_left", "move_right"))

# Core Mechanics
func handle_gravity():
	if !is_on_floor() && !can_coyote_jump:
		velocity.y += gravity
		velocity.y = min(velocity.y, 1000)

func handle_horizontal_movement(delta):
	var direction = Input.get_axis("move_left", "move_right")
	var speed
	if Input.is_action_pressed("run"):
		speed = run_speed
	else:
		speed = walk_speed
	
	#if Input.is_action_just_pressed("roll") && is_on_floor() && !is_rolling:
		#if direction != 0:
			#start_roll(sign(direction))
	
	var roll_pressed = Input.is_action_just_pressed("roll")
	if roll_pressed && is_on_floor() && !is_rolling:
		if direction != 0:
			start_roll(sign(direction))
	
	if is_rolling:
		velocity.x = roll_speed * roll_direction
	else:
		velocity.x = move_toward(velocity.x, direction * speed, speed * acceleration if direction else walk_speed * friction)
	
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
	
	if Input.is_action_just_pressed("dash") && direction && !is_dashing && dash_timer <= 0:
		is_dashing = true
		dash_start_position = position.x
		dash_direction = direction
		dash_timer = dash_cooldown
	
	if is_dashing:
		var distance = abs(position.x - dash_start_position)
		if distance >= dash_max_distance || is_on_wall():
			is_dashing = false
		else:
			velocity.x = dash_direction * dash_speed * dash_curve.sample(distance / dash_max_distance)
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
		can_coyote_jump = true
		coyote_timer.start()
	
	if !was_on_floor && is_on_floor() && jump_buffered:
		jump()
		jump_buffered = false

# Movement Actions
func start_roll(direction: int):
	if is_rolling || !is_on_floor(): return
	is_rolling = true
	roll_direction = direction
	ap.play("roll")
	roll_timer.start()
	crouch()

func crouch():
	if is_crouching: return
	is_crouching = true
	cshape.shape = crouching_cshape
	cshape.position.y = 0

func stand():
	if !is_crouching: return
	if !above_head_is_empty():
		stuck_under_object = true
		return
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
	if is_rolling:
		ap.play("roll")
	elif is_dashing:
		ap.play("dash")
	elif is_attacking:
		ap.play("attack")
	elif is_on_floor():
		if direction == 0:
			ap.play("crouch" if is_crouching else "idle")
		else:
			ap.play("crouch_walk" if is_crouching else "run")
	else:
		ap.play("crouch" if is_crouching else ("jump" if velocity.y < 0 else "fall"))

# Timer Callbacks
func _on_coyote_timer_timeout(): can_coyote_jump = false
func _on_jump_buffer_timeout(): jump_buffered = false
func _on_jump_height_timer_timeout():
	if !Input.is_action_pressed("jump") && velocity.y < -100:
		velocity.y = -10

func _on_roll_timer_timeout():
	is_rolling = false
	if above_head_is_empty():
		stand()
	else:
		crouch()
		stuck_under_object = true # before crouch() ?

func _on_attack_timer_timeout():
	is_attacking = false
	can_attack = true

# Utility Functions
func above_head_is_empty() -> bool:
	return !crouch_raycast1.is_colliding() && !crouch_raycast2.is_colliding()




#func _physics_process(delta):
	#
##	Gravity
	#if !is_on_floor() && (can_coyote_jump == false):
		#velocity.y += gravity
		#if velocity.y > 1000:
			#velocity.y = 1000
		#
###	Double tap to roll
	##var current_time = Time.get_ticks_msec() / 1000.0
	##
	##if Input.is_action_just_pressed("move_left"):
		##if current_time - last_tap_left_time <= double_tap_time:
			##if last_tap_left_time > last_tap_right_time:
				##start_roll(-1)
		##last_tap_left_time = current_time
	##
	##if Input.is_action_just_pressed("move_right"):
		##if current_time - last_tap_right_time <= double_tap_time:
			##if last_tap_right_time > last_tap_left_time:
				##start_roll(1)
		##last_tap_right_time = current_time
	#
##	Horizontal movement
	#var horizontal_direction = Input.get_axis("move_left", "move_right")
	#
	#var speed
	#if Input.is_action_pressed("run"):
		#speed = run_speed
	#else:
		#speed = walk_speed
	#
	#if Input.is_action_just_pressed("roll") && is_on_floor() && !is_rolling:
		#if horizontal_direction != 0:
			#start_roll(sign(horizontal_direction))
	#
	#if is_rolling:
		#velocity.x = roll_speed * roll_direction
	#else:
		#if horizontal_direction:
			##velocity.x = speed * horizontal_direction
			#velocity.x = move_toward(velocity.x, horizontal_direction * speed, speed * acceleration)
		#else:
			#velocity.x = move_toward(velocity.x, 0, walk_speed * friction)
		##if horizontal_direction != 0:
			##switch_direction(horizontal_direction)
	#
	#if horizontal_direction != 0 && !is_rolling:
		#switch_direction(horizontal_direction)
	#
##	Dash activation
	#if Input.is_action_just_pressed("dash") && horizontal_direction && !is_dashing && dash_timer <= 0:
		#is_dashing = true
		#dash_start_position = position.x
		#dash_direction = horizontal_direction
		#dash_timer = dash_cooldown
	#
##	Actual dash
	#if is_dashing:
		#var current_distance = abs(position.x - dash_start_position)
		#if current_distance >= dash_max_distance || is_on_wall():
			#is_dashing = false
		#else:
			#velocity.x = dash_direction * dash_speed * dash_curve.sample(current_distance / dash_max_distance)
			#velocity.y = 0
	#
##	Reduces the dash timer
	#if dash_timer > 0:
		#dash_timer -= delta
	#
##	Jump
	##if Input.is_action_just_pressed("jump"):
		##jump_height_timer.start()
		##jump()
		#
	#if Input.is_action_just_pressed("jump") && (is_on_floor() || is_on_wall()):
		#velocity.y = jump_force
	#
	#if Input.is_action_just_released("jump") && velocity.y < 0:
		#velocity.y *= decelerate_on_jump_release
	#
##	Crouch
	#if Input.is_action_just_pressed("crouch"):
		#crouch()
	#elif Input.is_action_just_released("crouch"):
		#if above_head_is_empty():
			#stand()
		#elif !stuck_under_object:
			#stuck_under_object = true
			##print("Player stuck, setting stuck_under_object to true")
	#
	#if stuck_under_object && above_head_is_empty():
		#if !Input.is_action_pressed("crouch"):
			#stand()
			#stuck_under_object = false
			##print("Player was stuck, now standing straight")
	#
	#if Input.is_action_pressed("attack") && can_attack:
		#is_attacking = true
		#can_attack = false
		#attack_timer.start()
	#
##	Move
	#var was_on_floor = is_on_floor()
	#move_and_slide()
	#
##	Fall detection
	#if was_on_floor && !is_on_floor() && velocity.y >= 0:
		##print("Fall")
		#can_coyote_jump = true
		#coyote_timer.start()
	#
##	Landing detection
	#if !was_on_floor && is_on_floor():
		##print("Touched ground")
		#if jump_buffered:
			#jump_buffered = false
			##print("Buffered jump")
			#jump()
	#
	#update_animations(horizontal_direction)
#
#func jump():
	#if is_rolling:
		#return
	#if !above_head_is_empty():
		#return
	#if is_on_floor() || can_coyote_jump:
		#velocity.y = jump_force
		#if can_coyote_jump:
			#can_coyote_jump = false
			##print("Coyote jump")
	#else:
		#if !jump_buffered:
			#jump_buffered = true
			#jump_buffer_timer.start()
#
#func start_roll(direction: int):
	#if is_rolling || !is_on_floor():
		#return
	#is_rolling = true
	#roll_direction = direction
	##print("Rolling ", "left" if direction == -1 else "right")
	#ap.play("roll")
	#roll_timer.start()
	##cshape.shape = crouching_cshape
	##cshape.position.y = 0
	#crouch()
#
#func crouch():
	#if is_crouching:
		#return
	#is_crouching = true
	#cshape.shape = crouching_cshape
	#cshape.position.y = 0
#
#func stand():
	#if is_crouching == false:
		#return
	#if !above_head_is_empty():
		#stuck_under_object = true
		#print("Can't stand: object above")
		#return
	#else:
		##print("Standing up")
		#is_crouching = false
		#stuck_under_object = false
		#cshape.shape = standing_cshape
		#cshape.position.y = -5
#
#func switch_direction(horizontal_direction):
	#sprite.flip_h = (horizontal_direction == -1)
	#sprite.position.x = horizontal_direction * 4
#
#func _on_coyote_timer_timeout() -> void:
	#can_coyote_jump = false
#
#func _on_jump_buffer_timer_timeout() -> void:
	#jump_buffered = false
#
#func _on_jump_height_timer_timeout() -> void:
	#if !Input.is_action_pressed("jump"):
		#if velocity.y < -100:
			#velocity.y = -10
			##print("Low jump")
	##else:
		##print("High jump")
#
#func _on_roll_timer_timeout() -> void:
	#is_rolling = false
	#if above_head_is_empty():
		#stand()
		#stuck_under_object = false
	#else:
##		Not enough space, stay crouched
		#crouch()
		#stuck_under_object = true
#
#func _on_attack_timer_timeout() -> void:
	#is_attacking = false
	#can_attack = true
#
#func above_head_is_empty() -> bool:
	#var result = !crouch_raycast1.is_colliding() && !crouch_raycast2.is_colliding()
	#return result
#
#func update_animations(horizontal_direction):
	#if is_rolling:
		#ap.play("roll")
		#return
	#if is_dashing:
		#ap.play("dash")
		#return
	#if is_attacking:
		#ap.play("attack")
		#return
	#if is_on_floor():
		#if horizontal_direction == 0:
			#if is_crouching:
				#ap.play("crouch")
			#else:
				#ap.play("idle")
		#else:
			#if is_crouching:
				#ap.play("crouch_walk")
			#else:
				#ap.play("run")
	#else:
		#if is_crouching == false:
			#if velocity.y < 0:
				#ap.play("jump")
			#elif velocity.y > 0:
				#ap.play("fall")
		#else:
			#ap.play("crouch")
