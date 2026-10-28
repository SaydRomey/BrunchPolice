# player/states/hub_inspecting.gd
extends PlayerState

@export var inspect_hold_seconds := 0.25
var timer := 0.0


func enter(_previous_state_path: String, _data := {}) -> void:
	timer = inspect_hold_seconds
	player.stop_all_movement()
	player.play_directional_animation("idle")
	print("Inspecting nearby brunch clue / NPC placeholder.")


func physics_update(delta: float) -> void:
	timer -= delta
	player.stop_all_movement()
	player.move_and_slide()
	player.play_directional_animation("idle")

	if timer <= 0.0 and not Input.is_action_pressed("interact"):
		finished.emit(HUB_IDLE)
		return
