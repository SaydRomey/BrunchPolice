## Area2D trigger that applies a configured hit when a body enters while active.
##
## Emits actor_hit, and optionally calls receive_damage(damage, source_position) on the actor.[br]
## Does not tick damage continuously.

@tool
extends LE_Element2D
class_name LE_DamageZone
## Area trigger: damages once on entry. For periodic hits, subclass or add a timer.

## Emitted with actor and configured damage on an active Area entry.
signal actor_hit(actor: Node2D, damage: int)

@export_group("Damage")
## Integer damage value emitted or sent when a body enters the active Area.
@export_range(0, 100, 1) var damage: int = 1
## Whether the Area monitors new entries and applies entry damage at runtime.
@export var active: bool = true:
	set(value):
		active = value
		_apply_active()

## Connects entry detection during gameplay, syncs Area geometry and applies active monitoring state.
func _ready() -> void:
	super._ready()
	_sync_shape()
	if not Engine.is_editor_hint():
		(get_node("Area") as Area2D).body_entered.connect(_on_enter)
	_apply_active()

## Updates debug/appearance settings and synchronizes Area/CollisionShape2D size.
func _refresh() -> void:
	super._refresh()
	_sync_shape()

## Resizes the Area rectangle to [member element_size] when its shape supports rectangles.
func _sync_shape() -> void:
	if not is_inside_tree():
		return
	var shape_node := get_node_or_null("Area/CollisionShape2D") as CollisionShape2D
	if shape_node != null:
		var rect := shape_node.shape as RectangleShape2D
		if rect != null:
			rect.size = element_size

## Schedules Area.monitoring to follow [member active] at runtime. Does not change monitoring in the editor.
func _apply_active() -> void:
	if not is_inside_tree() or Engine.is_editor_hint():
		return
	var area := get_node_or_null("Area") as Area2D
	if area != null:
		area.set_deferred("monitoring", active)

## If active, emits actor_hit and calls body.receive_damage(damage, global_position) when that method exists. Runs only on entry.
func _on_enter(body: Node2D) -> void:
	if not active:
		return
	actor_hit.emit(body, damage)
	if body.has_method("receive_damage"):
		body.call("receive_damage", damage, global_position)

## Controls the active state of the damage zone through [member active]. [param value] is the desired state.
func set_enabled(value: bool) -> void:
	active = value
