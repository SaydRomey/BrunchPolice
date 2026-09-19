# Autoloads/GameManager.gd
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


## Keep trace of current scene
#var current_scene = null


#func _ready():
	#var root = get_tree().root
	#current_scene = root.get_child(root.get_child_count() - 1)


## Clean scene changing
#func goto_scene(path: String):
	## Using call_deferred to ensure the engine is done with the running code
	#call_deferred("_deferred_goto_scene", path)
#
#func _deferred_goto_scene(path):
	## Free previous scene
	#current_scene.free()
	## Load the new one
	#var s = ResourceLoader.load(path)
	#current_scene = s.instantiate()
	## Add it to the root
	#get_tree().root.add_child(current_scene)
	#get_tree().current_scene = current_scene
