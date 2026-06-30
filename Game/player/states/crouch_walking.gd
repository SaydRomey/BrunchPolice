# player/states/crouch_walking.gd
extends PlayerState


func enter(_previous_state_path: String, _data := {}) -> void:
	player.play_directional_animation("crouch_walk")


func physics_update(delta: float) -> void:
	var input_x := get_input_x()

	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		finished.emit(JUMPING)
		return

	if not Input.is_action_pressed("crouch"):
		go_to_grounded_state(input_x)
		return

	if not player.has_move_input(input_x):
		player.set_facing_from_input(0.0)
		finished.emit(CROUCHING)
		return

	move_player(delta, "crouch_walking", player.crouch_walk_speed)

	if not player.is_on_floor():
		finished.emit(FALLING)
		return
