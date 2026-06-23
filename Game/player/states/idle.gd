extends PlayerState


func enter(_previous_state_path: String, _data := {}) -> void:
	player.velocity.x = 0.0
	player.play_directional_animation("idle")


func physics_update(_delta: float) -> void:
	player.velocity.y += player.gravity * _delta
	player.move_and_slide()

	var input_direction_x := Input.get_axis("move_left", "move_right")

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	elif not is_equal_approx(input_direction_x, 0.0):
	#elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		finished.emit(RUNNING)
