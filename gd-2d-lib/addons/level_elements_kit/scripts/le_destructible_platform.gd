## Solid platform that tracks health and loses its collider when destroyed.
##
## It receives damage via receive_damage(amount, source), 
## emits health_changed and destroyed, and becomes invisible at zero HP.

@tool
extends LE_PlatformBase
class_name LE_DestructiblePlatform

## Emitted once when health reaches zero.
signal destroyed
## Emitted with remaining_health after damage is processed.
signal health_changed(remaining_health: int)

@export_group("Durability")
## Number of damage points required to destroy the platform at runtime.
@export_range(1, 100, 1) var max_health: int = 3
## Current runtime health, initialized from max_health.
var health: int = 3

## Initializes runtime health to max_health after normal platform setup.
func _ready() -> void:
	super._ready()
	if not Engine.is_editor_hint():
		health = max_health

## Subtracts nonnegative [param amount] from health. Emits health_changed, and at zero emits destroyed, disables the collider and hides the platform. [param _source] is unused.
func receive_damage(amount: int, _source: Vector2 = Vector2.ZERO) -> void:
	if Engine.is_editor_hint() or health <= 0:
		return
	health = maxi(0, health - maxi(0, amount))
	health_changed.emit(health)
	if health == 0:
		destroyed.emit()
		(get_node("Body/CollisionShape2D") as CollisionShape2D).set_deferred("disabled", true)
		visible = false
