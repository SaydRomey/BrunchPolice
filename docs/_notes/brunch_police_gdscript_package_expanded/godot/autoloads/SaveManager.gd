extends Node
class_name SaveManager

signal game_saved(slot_name: String)
signal game_loaded(slot_name: String)
signal save_failed(slot_name: String, reason: String)

var current_save: Dictionary = _default_save()

func _default_save() -> Dictionary:
	return {
		"version": 1,
		"resources": {},
		"resource_limits": {},
		"inventory": {},
		"equipped": {"main_hand": "Fork", "off_hand": "", "two_hand": ""},
		"unlocked_levels": ["Pastry Palace"],
		"settings": {
			"music_volume": 1.0,
			"sfx_volume": 1.0,
			"difficulty": "normal"
		}
	}

func reset_save() -> void:
	current_save = _default_save()

func save_game(slot_name: String = "slot_1") -> bool:
	var path := _slot_path(slot_name)
	var file := FileAccess.open(path, FileAccess.WRITE)
	if file == null:
		save_failed.emit(slot_name, str(FileAccess.get_open_error()))
		return false
	file.store_string(JSON.stringify(current_save, "\t"))
	file.close()
	game_saved.emit(slot_name)
	return true

func load_game(slot_name: String = "slot_1") -> bool:
	var path := _slot_path(slot_name)
	if not FileAccess.file_exists(path):
		save_failed.emit(slot_name, "Save file does not exist.")
		return false

	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		save_failed.emit(slot_name, str(FileAccess.get_open_error()))
		return false

	var parsed: Variant = JSON.parse_string(file.get_as_text())
	file.close()
	if typeof(parsed) != TYPE_DICTIONARY:
		save_failed.emit(slot_name, "Save file is not valid JSON.")
		return false

	current_save = parsed
	game_loaded.emit(slot_name)
	return true

func capture_from_autoloads() -> void:
	var resource_manager := get_node_or_null("/root/GameResourceManager")
	if resource_manager != null and resource_manager.has_method("get_state"):
		var resource_state: Dictionary = resource_manager.get_state()
		current_save["resources"] = resource_state.get("resources", {})
		current_save["resource_limits"] = resource_state.get("limits", {})

	var inventory := get_node_or_null("/root/Inventory")
	if inventory != null:
		if inventory.has_method("get_all_items"):
			current_save["inventory"] = inventory.get_all_items()
		if inventory.has_method("get_equipped"):
			current_save["equipped"] = inventory.get_equipped()

func apply_to_autoloads() -> void:
	var resource_manager := get_node_or_null("/root/GameResourceManager")
	if resource_manager != null and resource_manager.has_method("set_state"):
		resource_manager.set_state({
			"resources": current_save.get("resources", {}),
			"limits": current_save.get("resource_limits", {})
		})

	var inventory := get_node_or_null("/root/Inventory")
	if inventory != null and inventory.has_method("set_state"):
		inventory.set_state(current_save.get("inventory", {}), current_save.get("equipped", {}))

func unlock_level(level_name: String) -> void:
	var levels: Array = current_save.get("unlocked_levels", [])
	if not levels.has(level_name):
		levels.append(level_name)
	current_save["unlocked_levels"] = levels

func is_level_unlocked(level_name: String) -> bool:
	return current_save.get("unlocked_levels", []).has(level_name)

func _slot_path(slot_name: String) -> String:
	var safe_name := slot_name.strip_edges().replace(" ", "_").to_lower()
	return "user://%s.json" % safe_name
