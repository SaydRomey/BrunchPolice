# autoloads/game_manager.gd
extends Node

var target_level_path: String = ""
var target_level_name: String = ""


func goto_scene(path: String) -> void:
	if path.is_empty():
		push_error("Cannot change scene: the path is empty.")
		return
	
	var result := get_tree().change_scene_to_file(path)
	if result != OK:
		push_error(
			"Could not change scene to '%s'. Error code: %s"
			% [path, result]
		)
