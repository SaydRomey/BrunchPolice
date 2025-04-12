extends CharacterBody2D

@export var speed = 150
@export var gravity = 20
@export var jump_force = -500

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var cshape = $CollisionShape2D
@onready var crouch_raycast1 = $CrouchRaycast_1
@onready var crouch_raycast2 = $CrouchRaycast_2

var is_crouching = false
var stuck_under_object = false

var standing_cshape = preload("res://ressources/knight_standing_cshape.tres")
var crouching_cshape = preload("res://ressources/knight_crouching_cshape.tres")

#func _process(delta):
	#print()

func _physics_process(delta):
#func _physics_process(delta: float) -> void:
	
#	Add the gravity
	#if not is_on_floor():
		#velocity += get_gravity() * delta
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
	
#	Handle jump
	if Input.is_action_just_pressed("jump"): #&& is_on_floor():
			velocity.y = jump_force
	
#	Handle movement/deceleration using input direction
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	velocity.x = speed * horizontal_direction
	
	if horizontal_direction != 0:
		switch_direction(horizontal_direction)
	
#	Handle crouching
	if Input.is_action_just_pressed("crouch"):
		crouch()
	elif Input.is_action_just_released("crouch"):
		if above_head_is_empty():
			stand()
		else:
			if stuck_under_object != true:
				stuck_under_object = true
				print("Player stuck, setting stuck_under_object to true")
	
	if stuck_under_object && above_head_is_empty():
		stand()
		stuck_under_object = false
		print("Player was stuck, now standing straight")
	
	move_and_slide()
	
	update_animations(horizontal_direction)
	
func above_head_is_empty() -> bool:
	var result = !crouch_raycast1.is_colliding() && !crouch_raycast2.is_colliding()
	return result
	
func update_animations(horizontal_direction):
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
	
func switch_direction(horizontal_direction):
	sprite.flip_h = (horizontal_direction == -1)
	sprite.position.x = horizontal_direction * 4
	
func crouch():
	if is_crouching:
		return
	is_crouching = true
	cshape.shape = crouching_cshape
	cshape.position.y = 0
	
func stand():
	if is_crouching == false:
		return
	is_crouching = false
	cshape.shape = standing_cshape
	cshape.position.y = -4
	
	
	
