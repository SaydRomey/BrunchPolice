extends Weapon
class_name DishwasherSprayer

@export var spray_range: float = 140.0
@export var spray_width: float = 46.0
@export var push_force: float = 360.0
@export var clean_damage: float = 6.0

func _ready() -> void:
	weapon_id = "dishwasher_sprayer"
	display_name = "Dishwasher Sprayer"
	slot = WeaponSlot.OFF_HAND
	damage = clean_damage
	cooldown = 0.25

func attack_quick(position: Vector2, direction: Vector2) -> Array[Node]:
	return _spray(position, direction, spray_range, push_force, 1.0)

func attack_charged(position: Vector2, direction: Vector2) -> Array[Node]:
	return _spray(position, direction, spray_range * 1.25, push_force * 1.35, charged_cooldown_multiplier)

func _spray(position: Vector2, direction: Vector2, range_value: float, force: float, cooldown_multiplier: float) -> Array[Node]:
	var affected: Array[Node] = []
	if not can_attack():
		attack_blocked.emit("Dishwasher Sprayer is cooling down.")
		return affected

	var dir := direction.normalized() if direction != Vector2.ZERO else Vector2.RIGHT
	var shape := RectangleShape2D.new()
	shape.size = Vector2(range_value, spray_width)

	var query := PhysicsShapeQueryParameters2D.new()
	query.shape = shape
	query.transform = Transform2D(dir.angle(), position + dir * range_value * 0.5)
	query.collide_with_areas = true
	query.collide_with_bodies = true

	var results := get_world_2d().direct_space_state.intersect_shape(query, 48)
	for result in results:
		var body: Node = result.get("collider")
		if body == null or body == wielder:
			continue
		if body.has_method("take_damage"):
			body.take_damage(clean_damage, {"source": wielder, "weapon": self})
		if body.has_method("apply_pushback"):
			body.apply_pushback(dir, force)
		if body.has_method("cleanse_hazard"):
			body.cleanse_hazard()
		affected.append(body)

	start_cooldown(cooldown_multiplier)
	fired.emit(self, AttackKind.QUICK)
	return affected
