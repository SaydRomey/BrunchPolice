## Trigger zone for movement modifiers such as sticky or slippery surfaces.
##
## It reports entry/exit through signals and optional actor methods; 
## it does not modify movement on its own.

@tool
extends LE_Element2D
class_name LE_SurfaceZone
## A signal-first movement zone. An actor can optionally implement
## enter_surface(element_id, speed_multiplier, traction_multiplier)
## and exit_surface(element_id). Works for sticky or slippery surfaces.

## Emitted when an actor enters the surface Area.
signal actor_entered_surface(actor: Node2D)
## Emitted when an actor leaves the surface Area.
signal actor_exited_surface(actor: Node2D)

@export_group("Movement Modifiers")
## Suggested horizontal movement multiplier for actors implementing enter_surface.
@export_range(0.1, 2.0, 0.05) var speed_multiplier: float = 0.5
## Suggested traction multiplier for actors implementing enter_surface.
@export_range(0.05, 2.0, 0.05) var traction_multiplier: float = 1.0
## Suggested jump multiplier for actors implementing enter_surface.
@export_range(0.1, 2.0, 0.05) var jump_multiplier: float = 1.0

## Synchronizes the Area shape and connects entry/exit signals during gameplay.
func _ready() -> void:
	super._ready()
	_sync_shape()
	if not Engine.is_editor_hint():
		var area := get_node("Area") as Area2D
		area.body_entered.connect(_on_enter)
		area.body_exited.connect(_on_exit)

## Refreshes shared presentation and updates the rectangle collision size.
func _refresh() -> void:
	super._refresh()
	_sync_shape()

## Keeps Area/CollisionShape2D rectangle dimensions matched to [member element_size].
func _sync_shape() -> void:
	if not is_inside_tree():
		return
	var node := get_node_or_null("Area/CollisionShape2D") as CollisionShape2D
	if node != null and node.shape is RectangleShape2D:
		(node.shape as RectangleShape2D).size = element_size

## Emits actor_entered_surface, then optionally calls enter_surface(instance_id, speed, traction, jump) on the actor.
func _on_enter(actor: Node2D) -> void:
	actor_entered_surface.emit(actor)
	
	if actor.has_method("enter_surface"):
		actor.call(
			"enter_surface", 
			get_instance_id(), 
			speed_multiplier, 
			traction_multiplier,
			jump_multiplier
		)

## Emits actor_exited_surface and optionally calls exit_surface(instance_id) on the actor.
func _on_exit(actor: Node2D) -> void:
	actor_exited_surface.emit(actor)
	if actor.has_method("exit_surface"):
		actor.call("exit_surface", get_instance_id())
