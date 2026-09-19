extends Projectile
class_name BaconProjectile

@export var wrap_duration: float = 5.0
@export var wrap_damage: float = 0.0

func _ready() -> void:
	damage = wrap_damage
	effect_data = {
		"method": "apply_bacon_wrap",
		"duration": wrap_duration
	}
	super._ready()

func _apply_effect(body: Node) -> void:
	if body.has_method("apply_bacon_wrap"):
		body.apply_bacon_wrap(wrap_duration)
