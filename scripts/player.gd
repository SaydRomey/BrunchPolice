extends CharacterBody2D

@export var speed = 300
@export var gravity = 30
@export var jump_force = -700

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
	
	#if horizontal_direction:
		#velocity.x = horizontal_direction * speed
	#else:
		#velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	
	print(velocity)
	
