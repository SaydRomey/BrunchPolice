@tool
extends LE_Element2D
class_name LE_Collectible

signal collected(actor: Node2D, item_id: String, score_value: int)

@export_group("Collectible")
@export var item_id: String = "collectible"
@export_range(0, 100000, 1) var score_value: int = 100

func _ready() -> void:
	super._ready()
	_sync_shape()
	if not Engine.is_editor_hint():
		(get_node("Area") as Area2D).body_entered.connect(_on_enter)

func _refresh() -> void:
	super._refresh()
	_sync_shape()

func _sync_shape() -> void:
	if not is_inside_tree():
		return
	var node := get_node_or_null("Area/CollisionShape2D") as CollisionShape2D
	if node != null and node.shape is RectangleShape2D:
		(node.shape as RectangleShape2D).size = element_size

func _on_enter(actor: Node2D) -> void:
	if not actor is CharacterBody2D:
		return
	collected.emit(actor, item_id, score_value)
	queue_free()
