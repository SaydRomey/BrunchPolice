extends Weapon
class_name CitrusBlaster

@export var acid_duration: float = 2.0
@export var push_strength: float = 280.0

func _ready() -> void:
	weapon_id = "citrus_blaster"
	display_name = "Citrus Blaster"
	slot = WeaponSlot.TWO_HAND
	damage = 6.0
	cooldown = 0.18

func attack_quick(position: Vector2, direction: Vector2) -> Variant:
	return fire_projectile(position, direction, AttackKind.QUICK, damage, 1.25, {
		"method": "apply_citrus_acid",
		"duration": acid_duration,
		"strength": push_strength
	})
