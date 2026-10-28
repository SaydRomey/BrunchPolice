# player/states/hub_walking.gd
extends PlayerState


func enter(_previous_state_path: String, _data := {}) -> void:
	player.play_directional_animation("walking")


func physics_update(_delta: float) -> void:
	var input_vector := get_top_down_input()

	if Input.is_action_just_pressed("interact"):
		finished.emit(HUB_INSPECTING)
		return

	if not player.has_top_down_move_input(input_vector):
		finished.emit(HUB_IDLE)
		return

	if Input.is_action_pressed("run"):
		finished.emit(HUB_RUNNING)
		return

	move_top_down_player("walking", player.hub_walk_speed)
