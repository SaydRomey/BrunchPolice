# ui/level_transition.gd
extends Control

@onready var level_title: Label = %LevelTitle


func _ready():
	# Get level name stored in the GameManager
	level_title.text = GameManager.target_level_name


func _on_timer_timeout():
	if GameManager.target_level_path.is_empty():
		push_error("No platformer level was assigned.")
		GameManager.goto_scene("res://world/hub.tscn")
		return
	
	# Time has passed, we load the real level (Platformer)
	GameManager.goto_scene(GameManager.target_level_path)
