extends PlayerState


func enter(_previous_state_path: String, _data := {}) -> void:
	#if previous_state_path == GLIDING:
		#player.velocity.y = -player.glide_jump_impulse
	#else:
		#player.velocity.y = -player.jump_impulse
	player.velocity.y = -player.jump_impulse
	player.play_directional_animation("jumping")


func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")

	player.set_facing_from_input(input_direction_x)
	player.play_directional_animation("jumping")

	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * delta
	player.move_and_slide()

	#if Input.is_action_just_pressed("glide"):
		#finished.emit(GLIDING)
	#elif player.velocity.y >= 0:
		#finished.emit(FALLING)
	if player.velocity.y >= 0:
		finished.emit(FALLING)
