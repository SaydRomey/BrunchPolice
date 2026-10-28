# player/states/hub_idle.gd
extends PlayerState


func enter(_previous_state_path: String, _data := {}) -> void:
	player.stop_all_movement()
	player.play_directional_animation("idle")


func physics_update(_delta: float) -> void:
	var input_vector := get_top_down_input()

	if Input.is_action_just_pressed("interact"):
		finished.emit(HUB_INSPECTING)
		return

	if player.has_top_down_move_input(input_vector):
		player.set_top_down_facing_from_input(input_vector)

		if Input.is_action_pressed("run"):
			finished.emit(HUB_RUNNING)
		else:
			finished.emit(HUB_WALKING)
		return

	player.stop_all_movement()
	player.move_and_slide()
	player.play_directional_animation("idle")
