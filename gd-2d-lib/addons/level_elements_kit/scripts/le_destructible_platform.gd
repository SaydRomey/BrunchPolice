@tool
extends LE_PlatformBase
class_name LE_DestructiblePlatform

signal destroyed
signal health_changed(remaining_health: int)

@export_group("Durability")
@export_range(1, 100, 1) var max_health: int = 3
var health: int = 3

func _ready() -> void:
	super._ready()
	if not Engine.is_editor_hint():
		health = max_health

func receive_damage(amount: int, _source: Vector2 = Vector2.ZERO) -> void:
	if Engine.is_editor_hint() or health <= 0:
		return
	health = maxi(0, health - maxi(0, amount))
	health_changed.emit(health)
	if health == 0:
		destroyed.emit()
		(get_node("Body/CollisionShape2D") as CollisionShape2D).set_deferred("disabled", true)
		visible = false
