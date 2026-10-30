## Pickup that emits an item identifier and score value, then removes itself.
##
## Collects when a CharacterBody2D enters its Area; 
## the receiving game owns inventory and reward effects.

@tool
extends LE_Element2D
class_name LE_Collectible

## Emitted with actor, item_id, score_value immediately before queue_free.
signal collected(actor: Node2D, item_id: String, score_value: int)

@export_group("Collectible")
## Logical identifier reported to a host inventory or evidence system when collected.
@export var item_id: String = "collectible"
## Optional score amount supplied with collected; scoring is handled by the host.
@export_range(0, 100000, 1) var score_value: int = 100

## Synchronizes its Area and connects entry detection at runtime.
func _ready() -> void:
	super._ready()
	_sync_shape()
	if not Engine.is_editor_hint():
		(get_node("Area") as Area2D).body_entered.connect(_on_enter)

## Refreshes base appearance and synchronizes pickup size.
func _refresh() -> void:
	super._refresh()
	_sync_shape()

## Sets the pickup Area rectangle to the exported element dimensions.
func _sync_shape() -> void:
	if not is_inside_tree():
		return
	var node := get_node_or_null("Area/CollisionShape2D") as CollisionShape2D
	if node != null and node.shape is RectangleShape2D:
		(node.shape as RectangleShape2D).size = element_size

## Emits collected(actor, item_id, score_value) for a CharacterBody2D, then queues this pickup for deletion.
func _on_enter(actor: Node2D) -> void:
	if not actor is CharacterBody2D:
		return
	collected.emit(actor, item_id, score_value)
	queue_free()
