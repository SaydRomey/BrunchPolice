## Area that requests a level transition through a logical destination key.
##
## It emits exit_requested(actor, target_level_key) when a CharacterBody2D enters.[br]
## The host game performs scene loading.

@tool
extends LE_Element2D
class_name LE_ExitPortal
## Emits a logical level key; the hosting game's LevelManager does the loading.

## Emitted with actor and logical target_level_key; host scene manager handles loading.
signal exit_requested(actor: Node2D, target_level_key: String)

@export_group("Progression")
## Logical destination key emitted when an actor enters; this is not a scene path.
@export var target_level_key: String = "next_level"

## Synchronizes Area dimensions and connects body_entered during gameplay.
func _ready() -> void:
    super._ready()
    _sync_shape()
    if not Engine.is_editor_hint():
        (get_node("Area") as Area2D).body_entered.connect(_on_enter)

## Refreshes shared appearance and updates the exit trigger bounds.
func _refresh() -> void:
    super._refresh()
    _sync_shape()

## Resizes the Area rectangle to the exported element size.
func _sync_shape() -> void:
    if not is_inside_tree():
        return
    var node := get_node_or_null("Area/CollisionShape2D") as CollisionShape2D
    if node != null and node.shape is RectangleShape2D:
        (node.shape as RectangleShape2D).size = element_size

## Emits exit_requested(actor, target_level_key) for a CharacterBody2D; does not load a scene itself.
func _on_enter(actor: Node2D) -> void:
    if actor is CharacterBody2D:
        exit_requested.emit(actor, target_level_key)
