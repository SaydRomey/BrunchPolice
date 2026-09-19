extends Weapon
class_name BreadSlicer

@export var slash_range: float = 54.0
@export var slash_radius: float = 26.0
@export var pastry_damage: float = 60.0
@export var normal_damage: float = 35.0
@export var pastry_groups: Array[StringName] = [&"pastry_enemy", &"bread_enemy"]

func _ready() -> void:
	weapon_id = "bread_slicer"
	display_name = "Bread Slicer"
	slot = WeaponSlot.MAIN_HAND
	damage = normal_damage

func attack_quick(position: Vector2, direction: Vector2) -> Array[Node]:
	return _perform_slash(position, direction, 1.0, cooldown)

func attack_charged(position: Vector2, direction: Vector2) -> Array[Node]:
	return _perform_slash(position, direction, 1.6, cooldown * charged_cooldown_multiplier)

func _perform_slash(position: Vector2, direction: Vector2, damage_multiplier: float, cooldown_value: float) -> Array[Node]:
	var hit_targets: Array[Node] = []
	if not can_attack():
		attack_blocked.emit("Bread Slicer is cooling down.")
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

	var results := get_world_2d().direct_space_state.intersect_shape(query, 32)
	for result in results:
		var body: Node = result.get("collider")
		if body == null or body == wielder:
			continue
		if body.has_method("take_damage"):
			var final_damage := pastry_damage if _is_pastry_target(body) else normal_damage
			body.take_damage(final_damage * damage_multiplier, {"source": wielder, "weapon": self})
			hit_targets.append(body)

	cooldown_timer = cooldown_value
	cooldown_started.emit(cooldown_timer)
	fired.emit(self, AttackKind.QUICK)
	return hit_targets

func _is_pastry_target(body: Node) -> bool:
	for group_name in pastry_groups:
		if body.is_in_group(group_name):
			return true
	return false
