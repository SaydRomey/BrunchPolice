extends RefCounted
class_name DamageCalculator

const DEFAULT_CRITICAL_MULTIPLIER := 2.0

static func calculate(base_damage: float, damage_source: Dictionary = {}, target: Node = null) -> float:
	var final_damage := maxf(0.0, base_damage)

	if damage_source.get("critical_hit", false):
		final_damage *= float(damage_source.get("critical_multiplier", DEFAULT_CRITICAL_MULTIPLIER))

	var flat_bonus := float(damage_source.get("flat_bonus", 0.0))
	var multiplier := float(damage_source.get("damage_multiplier", 1.0))
	final_damage = (final_damage + flat_bonus) * multiplier

	var weapon_type := String(damage_source.get("weapon_type", ""))
	if weapon_type == "bacon_gun":
		final_damage *= float(damage_source.get("bacon_gun_multiplier", 1.0))

	if is_instance_valid(target):
		if target.has_method("get_damage_resistance"):
			final_damage *= clampf(1.0 - float(target.get_damage_resistance(damage_source)), 0.0, 1.0)
		if target.has_method("get_damage_vulnerability"):
			final_damage *= maxf(0.0, float(target.get_damage_vulnerability(damage_source)))

	var armor := float(damage_source.get("target_armor", 0.0))
	if is_instance_valid(target) and target.has_method("get_armor"):
		armor += float(target.get_armor())
	final_damage = maxf(0.0, final_damage - armor)

	return final_damage

static func effect_allowed_for_enemy_size(effect_id: String, enemy_size: String) -> bool:
	if effect_id.is_empty():
		return false
	match enemy_size:
		"small":
			return true
		"medium":
			return true
		"large", "mob", "swarm", "boss":
			return false
		_:
			return true
