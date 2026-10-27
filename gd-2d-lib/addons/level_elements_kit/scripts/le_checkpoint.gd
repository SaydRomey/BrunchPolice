@tool
extends LE_Element2D
class_name LE_Checkpoint

signal reached(actor: Node2D, respawn_position: Vector2)

@export_group("Checkpoint")
@export var respawn_offset: Vector2 = Vector2(0, -32)
@export var one_shot: bool = true
var _activated: bool = false

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
	if not actor is CharacterBody2D or (one_shot and _activated):
		return
	_activated = true
	var spawn_pos := global_position + respawn_offset
	reached.emit(actor, spawn_pos)
	if actor.has_method("set_checkpoint"):
		actor.call("set_checkpoint", spawn_pos)
