@tool
extends LE_PlatformBase
class_name LE_CollapsingPlatform

signal warning_started
signal collapsed
signal restored

@export_group("Collapse")
@export_range(0.05, 10.0, 0.05) var warning_seconds: float = 0.6
@export_range(0.1, 30.0, 0.1) var respawn_seconds: float = 2.0

var _busy: bool = false

func _ready() -> void:
	super._ready()
	_sync_trigger()
	if not Engine.is_editor_hint():
		var area := get_node("Trigger") as Area2D
		area.body_entered.connect(_on_body_entered)

func _refresh() -> void:
	super._refresh()
	_sync_trigger()

func _sync_trigger() -> void:
	if not is_inside_tree():
		return
	var shape_node := get_node_or_null("Trigger/CollisionShape2D") as CollisionShape2D
	if shape_node == null:
		return
	var rect := shape_node.shape as RectangleShape2D
	if rect != null:
		rect.size = Vector2(element_size.x, 8.0)
	shape_node.position = Vector2(0, -element_size.y * 0.5 - 4.0)

func _on_body_entered(body: Node2D) -> void:
	if _busy or not body is CharacterBody2D:
		return
	_begin_collapse()

func _begin_collapse() -> void:
	_busy = true
	warning_started.emit()
	await get_tree().create_timer(warning_seconds).timeout
	if not is_inside_tree():
		return
	var collider := get_node("Body/CollisionShape2D") as CollisionShape2D
	collider.set_deferred("disabled", true)
	visible = false
	collapsed.emit()
	await get_tree().create_timer(respawn_seconds).timeout
	if not is_inside_tree():
		return
	visible = true
	collider.set_deferred("disabled", not solid)
	restored.emit()
	_busy = false
