## Platform that emits a warning, temporarily disables its collider and later restores itself.
##
## A Trigger area detects CharacterBody2D actors.[br]
## Warning and respawn durations are configured in the Inspector.

@tool
extends LE_PlatformBase
class_name LE_CollapsingPlatform

## Emitted before the warning wait begins.
signal warning_started
## Emitted when collision is disabled and the platform becomes invisible.
signal collapsed
## Emitted after the platform becomes visible and collision is restored.
signal restored

@export_group("Collapse")
## Time between player trigger and collider disappearing.
@export_range(0.05, 10.0, 0.05) var warning_seconds: float = 0.6
## Time the platform stays invisible and non-colliding before returning.
@export_range(0.1, 30.0, 0.1) var respawn_seconds: float = 2.0

## True while a collapse-and-respawn sequence is in progress.
var _busy: bool = false

## Synchronizes Trigger size and connects body_entered outside the editor.
func _ready() -> void:
	super._ready()
	_sync_trigger()
	if not Engine.is_editor_hint():
		var area := get_node("Trigger") as Area2D
		area.body_entered.connect(_on_body_entered)

## Refreshes shared presentation/collider settings and repositions the top-contact Trigger.
func _refresh() -> void:
	super._refresh()
	_sync_trigger()

## Keeps the thin Trigger collision shape aligned with the top of the element's current width and height.
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

## Starts a collapse when a CharacterBody2D enters and this platform is not already collapsing.
func _on_body_entered(body: Node2D) -> void:
	if _busy or not body is CharacterBody2D:
		return
	_begin_collapse()

## Emits warning_started, waits warning_seconds, disables collision and hides, waits respawn_seconds, then restores collision and visibility. Stops if removed from the tree.
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
