# player/states/idle.gd
extends PlayerState


func enter(_previous_state_path: String, _data := {}) -> void:
	#player.velocity.x = 0.0
	player.stop_horizontal_movement()
	player.set_facing_from_input(0.0)
	player.play_directional_animation("idle")


func physics_update(delta: float) -> void:
	var input_x := get_input_x()

	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		finished.emit(JUMPING)
		return

	if player.has_move_input(input_x):
		player.set_facing_from_input(input_x)
		finished.emit(RUNNING)
		return

	player.apply_gravity(delta)
	player.move_and_slide()
	player.play_directional_animation("idle")

	if not player.is_on_floor():
		finished.emit(FALLING)
		return
