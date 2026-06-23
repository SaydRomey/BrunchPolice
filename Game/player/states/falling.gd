extends PlayerState


func enter(_previous_state_path: String, _data := {}) -> void:
	player.play_directional_animation("falling")


func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")

	player.set_facing_from_input(input_direction_x)
	player.play_directional_animation("falling")

	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * delta
	player.move_and_slide()

	#if Input.is_action_just_pressed("glide"):
		#finished.emit(GLIDING)
	#elif player.is_on_floor():
	if player.is_on_floor():
		if is_equal_approx(player.velocity.x, 0.0):
			finished.emit(IDLE)
		else:
			finished.emit(RUNNING)
