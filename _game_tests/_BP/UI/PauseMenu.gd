# UI/PauseMenu.gd
extends CanvasLayer

func _ready() -> void:
	# Menu is hidden by default
	visible = false

func _input(event) -> void:
	# Press the escape key (or start button on joypad "start")
	if event.is_action_pressed("pause"):
		toggle_pause()

func toggle_pause() -> void:
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state

func _on_resume_pressed() -> void:
	toggle_pause()

func _on_quit_to_title_pressed() -> void:
	toggle_pause() # Unpause before quitting
	GameManager.goto_scene("res://UI/MainMenu.tscn")
