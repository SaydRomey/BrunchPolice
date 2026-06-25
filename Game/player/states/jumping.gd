# player/states/jumping.gd
extends PlayerState


func enter(_previous_state_path: String, _data := {}) -> void:
	player.velocity.y = -player.jump_impulse
	player.play_directional_animation("jumping")


func physics_update(delta: float) -> void:
	move_player(delta, "jumping")

	if player.velocity.y >= 0.0:
		finished.emit(FALLING)
		return
