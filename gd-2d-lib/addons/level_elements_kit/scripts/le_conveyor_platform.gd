## Solid platform whose StaticBody2D contributes a surface velocity to contacting bodies.
##
## Disabling its belt sets surface velocity to zero; it does not disable collision.[br] 
## One-way collision is controlled separately by [member LE_PlatformBase.one_way].

@tool
extends LE_PlatformBase
class_name LE_ConveyorPlatform
## A stationary body whose surface imparts a contact velocity.

@export_group("Conveyor")
## Contact movement vector supplied by Body.constant_linear_velocity when enabled.
@export var belt_velocity: Vector2 = Vector2(100, 0):
	set(value):
		belt_velocity = value
		_apply_belt()
## Turn surface movement on or off without modifying collider solidity.
@export var belt_enabled: bool = true:
	set(value):
		belt_enabled = value
		_apply_belt()

## Initializes the StaticBody2D belt surface velocity after normal platform setup.
func _ready() -> void:
	super._ready()
	_apply_belt()

## Sets Body.constant_linear_velocity to the configured vector when enabled, otherwise Vector2.ZERO. It does not change the collision shape.
func _apply_belt() -> void:
	if not is_inside_tree():
		return
	var body := get_node_or_null("Body") as StaticBody2D
	if body != null:
		body.constant_linear_velocity = belt_velocity if belt_enabled else Vector2.ZERO

## Switch control endpoint. [param value] starts or stops belt transport without toggling solidity.
func set_enabled(value: bool) -> void:
	belt_enabled = value

## Negates belt_velocity, reversing the transport direction.
func reverse() -> void:
	belt_velocity = -belt_velocity
