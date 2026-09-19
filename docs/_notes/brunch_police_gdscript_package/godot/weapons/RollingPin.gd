extends Weapon
class_name RollingPin

@export var swing_range: float = 48.0
@export var swing_radius: float = 28.0
@export var knockback_force: float = 420.0

func _ready() -> void:
	weapon_id = "rolling_pin"
	display_name = "Rolling Pin"
	slot = WeaponSlot.MAIN_HAND
	damage = 18.0
	cooldown = 0.45

func attack_quick(position: Vector2, direction: Vector2) -> Array[Node]:
	return _swing(position, direction, damage, 0.0, 1.0, AttackKind.QUICK)

func attack_charged(position: Vector2, direction: Vector2) -> Array[Node]:
	return _swing(position, direction, damage * 1.6, knockback_force, charged_cooldown_multiplier, AttackKind.CHARGED)

func _swing(position: Vector2, direction: Vector2, hit_damage: float, knockback: float, cooldown_multiplier: float, attack_kind: int) -> Array[Node]:
	var hit_targets: Array[Node] = []
	if not can_attack():
		attack_blocked.emit("Rolling Pin is cooling down.")
		return hit_targets

	var dir := direction.normalized() if direction != Vector2.ZERO else Vector2.RIGHT
	var shape := CircleShape2D.new()
	shape.radius = swing_radius
	var query := PhysicsShapeQueryParameters2D.new()
	query.shape = shape
	query.transform = Transform2D(0.0, position + dir * swing_range)
	query.collide_with_areas = true
	query.collide_with_bodies = true

	for result in get_world_2d().direct_space_state.intersect_shape(query, 32):
		var body: Node = result.get("collider")
		if body == null or body == wielder:
			continue
		if body.has_method("take_damage"):
			body.take_damage(hit_damage, {"source": wielder, "weapon": self})
		if knockback > 0.0 and body.has_method("apply_pushback"):
			body.apply_pushback(dir, knockback)
		hit_targets.append(body)

	start_cooldown(cooldown_multiplier)
	fired.emit(self, attack_kind)
	return hit_targets
