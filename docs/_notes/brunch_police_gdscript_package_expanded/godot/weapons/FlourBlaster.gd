extends Weapon
class_name FlourBlaster

@export var blind_duration: float = 2.5
@export var stun_duration: float = 0.35

func _ready() -> void:
	weapon_id = "flour_blaster"
	display_name = "Flour Blaster"
	slot = WeaponSlot.MAIN_HAND
	damage = 3.0
	cooldown = 0.55

func attack_quick(position: Vector2, direction: Vector2) -> Variant:
	return fire_projectile(position, direction, AttackKind.QUICK, damage, 0.95, {
		"method": "apply_flour_blind",
		"duration": blind_duration,
		"strength": stun_duration
	})
