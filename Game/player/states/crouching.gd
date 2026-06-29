# player/states/crouching.gd
extends PlayerState


func enter(_previous_state_path: String, _data := {}) -> void:
	player.stop_horizontal_movement()
	player.play_directional_animation("crouching")


func physics_update(delta: float) -> void:
	var input_x := get_input_x()

	player.set_facing_from_input(input_x)

	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		finished.emit(JUMPING)
		return

	if not Input.is_action_pressed("crouch"):
		go_to_grounded_state(input_x)
		return

	if player.has_move_input(input_x):
		finished.emit(CROUCH_WALKING)
		return

	player.apply_gravity(delta)
	player.move_and_slide()
	player.play_directional_animation("crouching")

	if not player.is_on_floor():
		finished.emit(FALLING)
		return
