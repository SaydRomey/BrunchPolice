extends Node2D
class_name LevelEditor

signal tool_changed(tool: String)
signal level_saved(path: String)
signal level_loaded(path: String)

@export var tilemap_path: NodePath
@export var object_parent_path: NodePath
@export var tile_layer: int = 0
@export var current_source_id: int = 0
@export var current_atlas_coords: Vector2i = Vector2i.ZERO
@export var current_alternative_tile: int = 0

var current_tool: String = "tile"
var object_templates: Dictionary = {}
var current_object_key: String = ""
var placed_objects: Array[Node2D] = []

func set_tool(tool: String) -> void:
	current_tool = tool
	tool_changed.emit(tool)

func select_tile(source_id: int, atlas_coords: Vector2i = Vector2i.ZERO, alternative_tile: int = 0) -> void:
	current_source_id = source_id
	current_atlas_coords = atlas_coords
	current_alternative_tile = alternative_tile
	set_tool("tile")

func place_tile(world_position: Vector2) -> void:
	var tilemap := _get_tilemap()
	if tilemap == null:
		push_warning("LevelEditor: TileMap not set.")
		return
	var coords := tilemap.local_to_map(tilemap.to_local(world_position))
	tilemap.set_cell(tile_layer, coords, current_source_id, current_atlas_coords, current_alternative_tile)

func remove_tile(world_position: Vector2) -> void:
	var tilemap := _get_tilemap()
	if tilemap == null:
		return
	var coords := tilemap.local_to_map(tilemap.to_local(world_position))
	tilemap.erase_cell(tile_layer, coords)

func preload_object(key: String, path: String) -> void:
	var scene := load(path) as PackedScene
	if scene:
		object_templates[key] = scene
	else:
		push_warning("LevelEditor: failed to load object scene %s" % path)

func select_object(key: String) -> void:
	if not object_templates.has(key):
		push_warning("LevelEditor: object not found: %s" % key)
		return
	current_object_key = key
	set_tool("object")

func place_object(world_position: Vector2) -> Node2D:
	if not object_templates.has(current_object_key):
		push_warning("LevelEditor: no object selected.")
		return null
	var instance := (object_templates[current_object_key] as PackedScene).instantiate() as Node2D
	if instance == null:
		return null
	instance.global_position = world_position
	instance.set_meta("editor_object_key", current_object_key)
	_get_object_parent().add_child(instance)
	placed_objects.append(instance)
	return instance

func remove_object(world_position: Vector2, max_distance: float = 16.0) -> bool:
	var closest: Node2D
	var closest_distance := max_distance
	for obj in placed_objects:
		if not is_instance_valid(obj):
			continue
		var distance := obj.global_position.distance_to(world_position)
		if distance <= closest_distance:
			closest = obj
			closest_distance = distance
	if closest:
		placed_objects.erase(closest)
		closest.queue_free()
		return true
	return false

func save_level(file_path: String) -> void:
	var tilemap := _get_tilemap()
	if tilemap == null:
		return
	var data := {
		"tiles": [],
		"objects": []
	}
	for coords in tilemap.get_used_cells(tile_layer):
		data["tiles"].append({
			"x": coords.x,
			"y": coords.y,
			"source_id": tilemap.get_cell_source_id(tile_layer, coords),
			"atlas_x": tilemap.get_cell_atlas_coords(tile_layer, coords).x,
			"atlas_y": tilemap.get_cell_atlas_coords(tile_layer, coords).y,
			"alternative": tilemap.get_cell_alternative_tile(tile_layer, coords)
		})
	for obj in placed_objects:
		if is_instance_valid(obj):
			data["objects"].append({
				"key": String(obj.get_meta("editor_object_key", obj.name)),
				"x": obj.global_position.x,
				"y": obj.global_position.y
			})
	var file := FileAccess.open(file_path, FileAccess.WRITE)
	if file == null:
		push_warning("LevelEditor: failed to save %s" % file_path)
		return
	file.store_string(JSON.stringify(data, "\t"))
	level_saved.emit(file_path)

func load_level(file_path: String) -> void:
	var tilemap := _get_tilemap()
	if tilemap == null:
		return
	if not FileAccess.file_exists(file_path):
		push_warning("LevelEditor: file not found %s" % file_path)
		return
	var file := FileAccess.open(file_path, FileAccess.READ)
	var parsed = JSON.parse_string(file.get_as_text())
	if typeof(parsed) != TYPE_DICTIONARY:
		push_warning("LevelEditor: invalid level data.")
		return
	tilemap.clear_layer(tile_layer)
	for obj in placed_objects:
		if is_instance_valid(obj):
			obj.queue_free()
	placed_objects.clear()
	for tile in parsed.get("tiles", []):
		var coords := Vector2i(int(tile["x"]), int(tile["y"]))
		var atlas := Vector2i(int(tile.get("atlas_x", 0)), int(tile.get("atlas_y", 0)))
		tilemap.set_cell(tile_layer, coords, int(tile["source_id"]), atlas, int(tile.get("alternative", 0)))
	for obj_data in parsed.get("objects", []):
		var key := String(obj_data.get("key", ""))
		if object_templates.has(key):
			current_object_key = key
			place_object(Vector2(float(obj_data["x"]), float(obj_data["y"])))
	level_loaded.emit(file_path)

func _get_tilemap() -> TileMap:
	return get_node_or_null(tilemap_path) as TileMap

func _get_object_parent() -> Node:
	var parent := get_node_or_null(object_parent_path)
	return parent if parent else self
