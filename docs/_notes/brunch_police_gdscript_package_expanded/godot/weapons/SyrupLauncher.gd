extends Weapon
class_name SyrupLauncher

@export var syrup_duration: float = 3.0
@export var syrup_damage: float = 8.0

func _ready() -> void:
	weapon_id = "syrup_launcher"
	display_name = "Syrup Launcher"
	slot = WeaponSlot.TWO_HAND
	damage = syrup_damage
	cooldown = 0.8

func attack_quick(position: Vector2, direction: Vector2) -> Variant:
	return fire_projectile(position, direction, AttackKind.QUICK, syrup_damage, 0.85, {
		"method": "apply_syrup_effect",
		"duration": syrup_duration
	})

func attack_charged(position: Vector2, direction: Vector2) -> Variant:
	return fire_projectile(position, direction, AttackKind.CHARGED, syrup_damage * 1.5, 0.65, {
		"method": "apply_syrup_effect",
		"duration": syrup_duration * 1.5
	}, charged_cooldown_multiplier)
