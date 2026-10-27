@tool
extends LE_Element2D
class_name LE_ExitPortal
## Emits a logical level key; the hosting game's LevelManager does the loading.

signal exit_requested(actor: Node2D, target_level_key: String)

@export_group("Progression")
@export var target_level_key: String = "next_level"

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
    if actor is CharacterBody2D:
        exit_requested.emit(actor, target_level_key)
