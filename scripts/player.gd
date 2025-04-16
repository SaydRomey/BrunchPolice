extends CharacterBody2D

#https://www.youtube.com/watch?v=93QBVvCzUGI&list=PLhXFaKLHQJdXpwaNt6gGwpHLTWL0m-TSL&index=11

@export var speed = 150
@export var gravity = 20
@export var jump_force = -500

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var cshape = $CollisionShape2D

var is_crouching = false
var stuck_under_object = false
@onready var crouch_raycast1 = $CrouchRaycast_1
@onready var crouch_raycast2 = $CrouchRaycast_2

var can_coyote_jump = false
@onready var coyote_timer = $CoyoteTimer

var jump_buffered = false
@onready var jump_buffer_timer = $JumpBufferTimer

@onready var jump_height_timer = $JumpHeightTimer

var is_rolling = false
var roll_direction = 0
@onready var roll_timer = $RollTimer
@export var roll_speed = 200
@export var double_tap_time = 0.3
var last_tap_left_time = 0.1
var last_tap_right_time = 0.1

var standing_cshape = preload("res://ressources/knight_standing_cshape.tres")
var crouching_cshape = preload("res://ressources/knight_crouching_cshape.tres")

#func _process(delta):
	#print()

func _physics_process(delta):
	
#	Gravity
	if !is_on_floor() && (can_coyote_jump == false):
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
		
#	Handle double tap for roll
	var current_time = Time.get_ticks_msec() / 1000.0
	
	if Input.is_action_just_pressed("move_left"):
		if current_time - last_tap_left_time <= double_tap_time:
			start_roll(-1)
		last_tap_left_time = current_time
	
	if Input.is_action_just_pressed("move_right"):
		if current_time - last_tap_right_time <= double_tap_time:
			start_roll(1)
		last_tap_right_time = current_time
	
#	Get movement direction
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	
#	Movement logic
	if is_rolling:
		velocity.x = roll_speed * roll_direction
	else:
		velocity.x = speed * horizontal_direction
	
		if horizontal_direction != 0:
			switch_direction(horizontal_direction)
	
		#	Handle jump
		if Input.is_action_just_pressed("jump"):
			jump_height_timer.start()
			jump()
	
#	Crouch logic
	if Input.is_action_just_pressed("crouch"):
		crouch()
	elif Input.is_action_just_released("crouch"):
		if above_head_is_empty():
			stand()
		else:
			if stuck_under_object != true:
				stuck_under_object = true
				#print("Player stuck, setting stuck_under_object to true")
	
	if stuck_under_object && above_head_is_empty():
		if !Input.is_action_pressed("crouch"):
			stand()
			stuck_under_object = false
			#print("Player was stuck, now standing straight")
	
#	Move and handle landing/fall
	var was_on_floor = is_on_floor()
	move_and_slide()
	
#	Started to fall
	if was_on_floor && !is_on_floor() && velocity.y >= 0:
		#print("Fall")
		can_coyote_jump = true
		coyote_timer.start()
	
#	Touched ground
	if !was_on_floor && is_on_floor():
		#print("Touched ground")
		if jump_buffered:
			jump_buffered = false
			print("Buffered jump")
			jump()
	
	update_animations(horizontal_direction)

func jump():
	if is_rolling:
		return
	if is_on_floor() || can_coyote_jump:
		velocity.y = jump_force
		if can_coyote_jump:
			can_coyote_jump = false
			print("Coyote jump")
	else:
		if !jump_buffered:
			jump_buffered = true
			jump_buffer_timer.start()

func start_roll(direction: int):
	if is_rolling || !is_on_floor():
		return
	is_rolling = true
	roll_direction = direction
	
	print("Rolling ", "left" if direction == -1 else "right")
	
	ap.play("roll")
	roll_timer.start()
	cshape.shape = crouching_cshape
	cshape.position.y = 0

func crouch():
	if is_rolling:
		return
	if is_crouching:
		return
	is_crouching = true
	cshape.shape = crouching_cshape
	cshape.position.y = 0
	
func stand():
	if is_rolling:
		return
	if is_crouching == false:
		return
	#print("Standing up")
	is_crouching = false
	cshape.shape = standing_cshape
	cshape.position.y = -5
	
func switch_direction(horizontal_direction):
	sprite.flip_h = (horizontal_direction == -1)
	sprite.position.x = horizontal_direction * 4

func _on_coyote_timer_timeout() -> void:
	can_coyote_jump = false

func _on_jump_buffer_timer_timeout() -> void:
	jump_buffered = false

func _on_jump_height_timer_timeout() -> void:
	if !Input.is_action_pressed("jump"):
		if velocity.y < -100:
			velocity.y = -10
			print("Low jump")
	else:
		print("High jump")

func _on_roll_timer_timeout() -> void:
	is_rolling = false
	if above_head_is_empty():
		if !is_crouching:
			cshape.shape = standing_cshape
			cshape.position.y = -5
	else:
#		Not enough space, stay crouched
		is_crouching = true
		stuck_under_object = true
		cshape.shape = crouching_cshape
		cshape.position.y = 0

func above_head_is_empty() -> bool:
	var result = !crouch_raycast1.is_colliding() && !crouch_raycast2.is_colliding()
	return result

func update_animations(horizontal_direction):
	if is_rolling:
		ap.play("roll")
		return
	if is_on_floor():
		if horizontal_direction == 0:
			if is_crouching:
				ap.play("crouch")
			else:
				ap.play("idle")
		else:
			if is_crouching:
				ap.play("crouch_walk")
			else:
				ap.play("run")
	else:
		if is_crouching == false:
			if velocity.y < 0:
				ap.play("jump")
			elif velocity.y > 0:
				ap.play("fall")
		else:
			ap.play("crouch")
