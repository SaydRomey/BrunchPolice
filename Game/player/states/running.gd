# player/states/running.gd
extends PlayerState


func enter(_previous_state_path: String, _data := {}) -> void:
	player.play_directional_animation("running")


func physics_update(delta: float) -> void:
	var input_x := get_input_x()

	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		finished.emit(JUMPING)
		return

	if not player.has_move_input(input_x):
		finished.emit(IDLE)
		return

	move_player(delta, "running")

	if not player.is_on_floor():
		finished.emit(FALLING)
		return
