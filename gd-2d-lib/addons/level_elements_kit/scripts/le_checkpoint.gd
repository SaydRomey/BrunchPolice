## Trigger that publishes a respawn position on first or repeat player contact.
##
## Emits reached and optionally invokes actor.set_checkpoint(position); 
## one_shot prevents repeated activations.

@tool
extends LE_Element2D
class_name LE_Checkpoint

## Emitted with actor and computed world-space respawn_position on activation.
signal reached(actor: Node2D, respawn_position: Vector2)

@export_group("Checkpoint")
## Local offset from this node's global position used as the respawn point.
@export var respawn_offset: Vector2 = Vector2(0, -32)
## If true, only the first eligible overlap emits reached.
@export var one_shot: bool = true
## Tracks whether the checkpoint has already fired, used when one_shot is enabled.
var _activated: bool = false

## Synchronizes the Area shape and connects its player entry callback at runtime.
func _ready() -> void:
	super._ready()
	_sync_shape()
	if not Engine.is_editor_hint():
		(get_node("Area") as Area2D).body_entered.connect(_on_enter)

## Updates base appearance and synchronizes checkpoint Area size.
func _refresh() -> void:
	super._refresh()
	_sync_shape()

## Matches the Area rectangle to [member element_size].
func _sync_shape() -> void:
	if not is_inside_tree():
		return
	var node := get_node_or_null("Area/CollisionShape2D") as CollisionShape2D
	if node != null and node.shape is RectangleShape2D:
		(node.shape as RectangleShape2D).size = element_size

## On an eligible CharacterBody2D, emits reached(actor, global_position + respawn_offset), and optionally calls actor.set_checkpoint(position).
func _on_enter(actor: Node2D) -> void:
	if not actor is CharacterBody2D or (one_shot and _activated):
		return
	_activated = true
	var spawn_pos := global_position + respawn_offset
	reached.emit(actor, spawn_pos)
	if actor.has_method("set_checkpoint"):
		actor.call("set_checkpoint", spawn_pos)
