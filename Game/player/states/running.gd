extends PlayerState


func enter(_previous_state_path: String, data := {}) -> void:
	player.play_directional_animation("running")

func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")

	player.set_facing_from_input(input_direction_x)
	player.play_directional_animation("running")

	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * delta
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	elif is_equal_approx(input_direction_x, 0.0):
		finished.emit(IDLE)
