extends Weapon
class_name ButterKnife

@export var slash_range: float = 42.0
@export var slash_radius: float = 22.0
@export var slippery_duration: float = 3.0
@export var slippery_strength: float = 1.8

func _ready() -> void:
	weapon_id = "butter_knife"
	display_name = "Butter Knife"
	slot = WeaponSlot.MAIN_HAND
	damage = 12.0

func attack_quick(position: Vector2, direction: Vector2) -> Array[Node]:
	return _butter_targets(position, direction, damage, slippery_duration)

func attack_charged(position: Vector2, direction: Vector2) -> Array[Node]:
	return _butter_targets(position, direction, damage * 1.4, slippery_duration * 1.5, charged_cooldown_multiplier)

func _butter_targets(position: Vector2, direction: Vector2, hit_damage: float, duration: float, cooldown_multiplier: float = 1.0) -> Array[Node]:
	var hit_targets: Array[Node] = []
	if not can_attack():
		attack_blocked.emit("Butter Knife is cooling down.")
		return hit_targets

	var dir := direction.normalized() if direction != Vector2.ZERO else Vector2.RIGHT
	var center := position + dir * slash_range
	var shape := CircleShape2D.new()
	shape.radius = slash_radius

	var query := PhysicsShapeQueryParameters2D.new()
	query.shape = shape
	query.transform = Transform2D(0.0, center)
	query.collide_with_areas = true
	query.collide_with_bodies = true

	var results := get_world_2d().direct_space_state.intersect_shape(query, 24)
	for result in results:
		var body: Node = result.get("collider")
		if body == null or body == wielder:
			continue
		if body.has_method("take_damage"):
			body.take_damage(hit_damage, {"source": wielder, "weapon": self})
		if body.has_method("apply_slippery_effect"):
			body.apply_slippery_effect(duration, slippery_strength)
			hit_targets.append(body)

	start_cooldown(cooldown_multiplier)
	fired.emit(self, AttackKind.QUICK)
	return hit_targets
