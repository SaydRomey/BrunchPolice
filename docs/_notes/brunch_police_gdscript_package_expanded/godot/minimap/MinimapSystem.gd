extends Control
class_name MinimapSystem

signal poi_added(key: String)
signal poi_removed(key: String)
signal zoom_changed(zoom: float)

@export var player_path: NodePath
@export var content_path: NodePath
@export var player_arrow_path: NodePath
@export var poi_parent_path: NodePath
@export var zoom_level: float = 1.0
@export var rotate_with_player: bool = true
@export var world_to_minimap_scale: float = 0.15
@export var toggle_action: String = "toggle_minimap"

var points_of_interest: Dictionary = {}
var _player: Node2D
var _content: Node2D
var _player_arrow: Node2D
var _poi_parent: Node2D

func _ready() -> void:
	_player = get_node_or_null(player_path) as Node2D
	_content = get_node_or_null(content_path) as Node2D
	_player_arrow = get_node_or_null(player_arrow_path) as Node2D
	_poi_parent = get_node_or_null(poi_parent_path) as Node2D
	if _content == null:
		_content = Node2D.new()
		_content.name = "MinimapContent"
		add_child(_content)
	if _poi_parent == null:
		_poi_parent = Node2D.new()
		_poi_parent.name = "POIs"
		_content.add_child(_poi_parent)

func _process(_delta: float) -> void:
	if not toggle_action.is_empty() and Input.is_action_just_pressed(toggle_action):
		toggle_minimap(not visible)
	update_minimap()

func set_player(player: Node2D) -> void:
	_player = player

func set_zoom(zoom: float) -> void:
	zoom_level = clampf(zoom, 0.25, 4.0)
	if _content:
		_content.scale = Vector2.ONE * zoom_level
	zoom_changed.emit(zoom_level)

func toggle_minimap(show: bool) -> void:
	visible = show

func update_minimap() -> void:
	if _player == null or _content == null:
		return
	_content.position = size * 0.5 - _player.global_position * world_to_minimap_scale * zoom_level
	if rotate_with_player:
		_content.rotation = -_player.global_rotation
	if _player_arrow:
		_player_arrow.position = size * 0.5
		_player_arrow.rotation = 0.0

func add_point_of_interest(key: String, world_position: Vector2, icon_texture: Texture2D = null) -> Node2D:
	if points_of_interest.has(key):
		remove_point_of_interest(key)
	var icon := Sprite2D.new()
	icon.name = key
	icon.texture = icon_texture
	icon.position = world_position * world_to_minimap_scale
	_poi_parent.add_child(icon)
	points_of_interest[key] = icon
	poi_added.emit(key)
	return icon

func update_point_of_interest(key: String, world_position: Vector2) -> void:
	if not points_of_interest.has(key):
		return
	var icon := points_of_interest[key] as Node2D
	if is_instance_valid(icon):
		icon.position = world_position * world_to_minimap_scale

func remove_point_of_interest(key: String) -> void:
	if not points_of_interest.has(key):
		return
	var icon := points_of_interest[key] as Node
	points_of_interest.erase(key)
	if is_instance_valid(icon):
		icon.queue_free()
	poi_removed.emit(key)
