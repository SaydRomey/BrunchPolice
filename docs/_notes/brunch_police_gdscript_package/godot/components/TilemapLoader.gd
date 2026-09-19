extends Node2D
class_name TilemapLoader

signal level_loaded(path: String, level: Node)
signal level_cleared()

@export var level_container_path: NodePath

var current_level: Node
var parallax_entries: Array[Dictionary] = []

func _process(_delta: float) -> void:
	for entry in parallax_entries:
		var background: Node2D = entry.get("background")
		var target: Node2D = entry.get("target")
		var factor: float = entry.get("factor", 0.5)
		if is_instance_valid(background) and is_instance_valid(target):
			background.global_position = target.global_position * factor

func load_level_scene(scene_path: String) -> Node:
	clear_current_level()
	var scene := load(scene_path) as PackedScene
	if scene == null:
		push_warning("Failed to load level scene: %s" % scene_path)
		return null
	current_level = scene.instantiate()
	_get_level_container().add_child(current_level)
	level_loaded.emit(scene_path, current_level)
	return current_level

func clear_current_level() -> void:
	if current_level != null and is_instance_valid(current_level):
		current_level.queue_free()
	current_level = null
	level_cleared.emit()

func assign_tileset(tilemap: Node, tileset_path: String) -> void:
	var tileset := load(tileset_path) as TileSet
	if tileset == null:
		push_warning("Failed to load tileset: %s" % tileset_path)
		return
	if tilemap is TileMap:
		tilemap.tile_set = tileset
	else:
		push_warning("assign_tileset expected a TileMap node.")

func enable_parallax_scrolling(background: Node2D, target: Node2D, parallax_factor: float = 0.5) -> void:
	parallax_entries.append({
		"background": background,
		"target": target,
		"factor": parallax_factor
	})

func _get_level_container() -> Node:
	if level_container_path != NodePath():
		var node := get_node_or_null(level_container_path)
		if node != null:
			return node
	return self
