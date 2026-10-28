# player/states/running.gd
extends PlayerState


func enter(_previous_state_path: String, _data := {}) -> void:
	player.play_directional_animation("running")


func physics_update(delta: float) -> void:
	var input_x := get_input_x()

	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		finished.emit(JUMPING)
		return

	if Input.is_action_pressed("crouch"):
		finished.emit(CROUCH_WALKING)
		return

	if not player.has_platformer_move_input(input_x):
		player.set_platformer_facing_from_input(0.0)
		finished.emit(IDLE)
		return

	if not Input.is_action_pressed("run"):
		finished.emit(WALKING)
		return

	move_platformer_player(delta, "running", player.run_speed)

	if not player.is_on_floor():
		finished.emit(FALLING)
		return
