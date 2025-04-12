extends CharacterBody2D

@export var speed = 150
@export var gravity = 20
@export var jump_force = -500

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D

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
		#sprite.flip_h = (horizontal_direction == -1)
	
	#if horizontal_direction:
		#velocity.x = horizontal_direction * speed
	#else:
		#velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	
	update_animations(horizontal_direction)
	
	#print(velocity)
	
func update_animations(horizontal_direction):
	if is_on_floor():
		if horizontal_direction == 0:
			ap.play("idle")
		else:
			ap.play("run")
	else:
		if velocity.y < 0:
			ap.play("jump")
		elif velocity.y > 0:
			ap.play("fall")
	
func switch_direction(horizontal_direction):
	sprite.flip_h = (horizontal_direction == -1)
	sprite.position.x = horizontal_direction * 4
