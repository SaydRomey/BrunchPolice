extends Weapon
class_name GummyBearGrenade

@export var gummy_duration: float = 4.0
@export var explosion_damage: float = 22.0

func _ready() -> void:
	weapon_id = "gummy_bear_grenade"
	display_name = "Gummy Bear Grenade"
	slot = WeaponSlot.OFF_HAND
	damage = explosion_damage
	cooldown = 1.1

func attack_quick(position: Vector2, direction: Vector2) -> Variant:
	return fire_projectile(position, direction, AttackKind.QUICK, explosion_damage, 0.75, {
		"method": "apply_gummy_bear_effect",
		"duration": gummy_duration,
		"strength": explosion_damage
	})
