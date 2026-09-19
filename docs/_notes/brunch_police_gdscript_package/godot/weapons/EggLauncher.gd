extends Weapon
class_name EggLauncher

@export var splash_duration: float = 0.2
@export var splash_damage: float = 18.0

func _ready() -> void:
	weapon_id = "egg_launcher"
	display_name = "Egg Launcher"
	slot = WeaponSlot.MAIN_HAND
	damage = splash_damage
	cooldown = 0.7

func attack_quick(position: Vector2, direction: Vector2) -> Variant:
	return fire_projectile(position, direction, AttackKind.QUICK, splash_damage, 0.8, {
		"method": "apply_yolk_splash",
		"duration": splash_duration,
		"strength": splash_damage
	})
