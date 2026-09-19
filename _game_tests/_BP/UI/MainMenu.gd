# UI/MainMenu.gd
extends Control

func _on_play_pressed() -> void:
	# Load the Hub scene (the brunch area)
	GameManager.goto_scene("res://Levels/Hub.tscn")

func _on_settings_pressed() -> void:
	pass # TODO


func _on_quit_pressed() -> void:
	get_tree().quit()
