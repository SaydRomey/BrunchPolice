extends Weapon
class_name BaconGun

@export var wrap_duration: float = 5.0
@export var bacon_damage: float = 0.0

func _ready() -> void:
	weapon_id = "bacon_gun"
	display_name = "Bacon Gun"
	slot = WeaponSlot.MAIN_HAND
	damage = bacon_damage

func attack_quick(position: Vector2, direction: Vector2) -> Variant:
	return fire_projectile(
		position,
		direction,
		AttackKind.QUICK,
		bacon_damage,
		1.0,
		{"method": "apply_bacon_wrap", "duration": wrap_duration}
	)

func attack_charged(position: Vector2, direction: Vector2) -> Variant:
	return fire_projectile(
		position,
		direction,
		AttackKind.CHARGED,
		bacon_damage,
		0.85,
		{"method": "apply_bacon_wrap", "duration": wrap_duration * 1.5},
		charged_cooldown_multiplier
	)
