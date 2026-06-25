# player/states/falling.gd
extends PlayerState


func enter(_previous_state_path: String, _data := {}) -> void:
	player.play_directional_animation("falling")


func physics_update(delta: float) -> void:
	var input_x := move_player(delta, "falling")

	if player.is_on_floor():
		go_to_grounded_state(input_x)
		return
