@tool
extends LE_Element2D
class_name LE_DamageZone
## Area trigger: damages once on entry. For periodic hits, subclass or add a timer.

signal actor_hit(actor: Node2D, damage: int)

@export_group("Damage")
@export_range(0, 100, 1) var damage: int = 1
@export var active: bool = true:
	set(value):
		active = value
		_apply_active()

func _ready() -> void:
	super._ready()
	_sync_shape()
	if not Engine.is_editor_hint():
		(get_node("Area") as Area2D).body_entered.connect(_on_enter)
	_apply_active()

func _refresh() -> void:
	super._refresh()
	_sync_shape()

func _sync_shape() -> void:
	if not is_inside_tree():
		return
	var shape_node := get_node_or_null("Area/CollisionShape2D") as CollisionShape2D
	if shape_node != null:
		var rect := shape_node.shape as RectangleShape2D
		if rect != null:
			rect.size = element_size

func _apply_active() -> void:
	if not is_inside_tree() or Engine.is_editor_hint():
		return
	var area := get_node_or_null("Area") as Area2D
	if area != null:
		area.set_deferred("monitoring", active)

func _on_enter(body: Node2D) -> void:
	if not active:
		return
	actor_hit.emit(body, damage)
	if body.has_method("receive_damage"):
		body.call("receive_damage", damage, global_position)

func set_enabled(value: bool) -> void:
	active = value
