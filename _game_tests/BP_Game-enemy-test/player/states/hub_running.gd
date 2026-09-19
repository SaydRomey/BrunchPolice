# player/states/hub_running.gd
extends PlayerState


func enter(_previous_state_path: String, _data := {}) -> void:
	player.play_directional_animation("running")


func physics_update(_delta: float) -> void:
	var input_vector := get_top_down_input()

	if Input.is_action_just_pressed("interact"):
		finished.emit(HUB_INSPECTING)
		return

	if not player.has_top_down_move_input(input_vector):
		finished.emit(HUB_IDLE)
		return

	if not Input.is_action_pressed("run"):
		finished.emit(HUB_WALKING)
		return

	move_top_down_player("running", player.hub_run_speed)
