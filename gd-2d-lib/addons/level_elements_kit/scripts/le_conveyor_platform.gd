@tool
extends LE_PlatformBase
class_name LE_ConveyorPlatform
## A stationary body whose surface imparts a contact velocity.

@export_group("Conveyor")
@export var belt_velocity: Vector2 = Vector2(100, 0):
	set(value):
		belt_velocity = value
		_apply_belt()
@export var belt_enabled: bool = true:
	set(value):
		belt_enabled = value
		_apply_belt()

func _ready() -> void:
	super._ready()
	_apply_belt()

func _apply_belt() -> void:
	if not is_inside_tree():
		return
	var body := get_node_or_null("Body") as StaticBody2D
	if body != null:
		body.constant_linear_velocity = belt_velocity if belt_enabled else Vector2.ZERO

func set_enabled(value: bool) -> void:
	belt_enabled = value

func reverse() -> void:
	belt_velocity = -belt_velocity
