extends Weapon
class_name WhippedCreamCannon

@export var slow_duration: float = 3.0
@export var slow_strength: float = 0.45

func _ready() -> void:
	weapon_id = "whipped_cream_cannon"
	display_name = "Whipped Cream Cannon"
	slot = WeaponSlot.MAIN_HAND
	damage = 4.0
	cooldown = 0.65

func attack_quick(position: Vector2, direction: Vector2) -> Variant:
	return fire_projectile(position, direction, AttackKind.QUICK, damage, 0.9, {
		"method": "apply_whipped_cream",
		"duration": slow_duration,
		"strength": slow_strength
	})
