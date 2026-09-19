extends Node2D
class_name Weapon

enum WeaponSlot { MAIN_HAND, OFF_HAND, TWO_HAND }
enum AttackKind { QUICK, CHARGED, SPECIAL }

signal fired(weapon: Weapon, attack_kind: int)
signal cooldown_started(duration: float)
signal attack_blocked(reason: String)

@export var weapon_id: String = "weapon"
@export var display_name: String = "Weapon"
@export_enum("Main Hand", "Off Hand", "Two Hand") var slot: int = WeaponSlot.MAIN_HAND
@export var damage: float = 10.0
@export var cooldown: float = 0.5
@export var charged_cooldown_multiplier: float = 1.4
@export var special_cooldown_multiplier: float = 2.0
@export var projectile_scene: PackedScene
@export var projectile_spawn_distance: float = 18.0

var cooldown_timer: float = 0.0
var wielder: Node2D

func _process(delta: float) -> void:
	if cooldown_timer > 0.0:
		cooldown_timer = maxf(0.0, cooldown_timer - delta)

func set_wielder(node: Node2D) -> void:
	wielder = node

func can_attack() -> bool:
	return cooldown_timer <= 0.0

func start_cooldown(multiplier: float = 1.0) -> void:
	cooldown_timer = maxf(0.0, cooldown * multiplier)
	cooldown_started.emit(cooldown_timer)

func attack_quick(position: Vector2, direction: Vector2) -> Variant:
	return fire_projectile(position, direction, AttackKind.QUICK, damage)

func attack_charged(position: Vector2, direction: Vector2) -> Variant:
	return fire_projectile(position, direction, AttackKind.CHARGED, damage * 1.75, 1.0, {}, charged_cooldown_multiplier)

func attack_special(position: Vector2, direction: Vector2) -> Variant:
	if slot != WeaponSlot.TWO_HAND:
		attack_blocked.emit("Special attack is only available for two-handed weapons.")
		return null
	return fire_projectile(position, direction, AttackKind.SPECIAL, damage * 2.5, 1.0, {}, special_cooldown_multiplier)

func fire_projectile(
		position: Vector2,
		direction: Vector2,
		attack_kind: int = AttackKind.QUICK,
		projectile_damage: float = -1.0,
		speed_multiplier: float = 1.0,
		effect_data: Dictionary = {},
		cooldown_multiplier: float = 1.0
	) -> Node:
	if not can_attack():
		attack_blocked.emit("Weapon is cooling down.")
		return null

	if projectile_scene == null:
		push_warning("%s has no projectile_scene assigned." % display_name)
		attack_blocked.emit("No projectile scene assigned.")
		return null

	var dir := direction.normalized()
	if dir == Vector2.ZERO:
		dir = Vector2.RIGHT

	var projectile := projectile_scene.instantiate()
	var projectile_parent := _get_projectile_parent()
	projectile_parent.add_child(projectile)

	if projectile is Node2D:
		projectile.global_position = position + dir * projectile_spawn_distance
		projectile.rotation = dir.angle()

	if projectile.has_method("set_velocity"):
		projectile.set_velocity(dir)
	if projectile.has_method("set_damage"):
		projectile.set_damage(projectile_damage if projectile_damage >= 0.0 else damage)
	if projectile.has_method("set_speed_multiplier"):
		projectile.set_speed_multiplier(speed_multiplier)
	if projectile.has_method("set_effect_data"):
		projectile.set_effect_data(effect_data)
	if projectile.has_method("set_source"):
		projectile.set_source(wielder if is_instance_valid(wielder) else self)

	start_cooldown(cooldown_multiplier)
	fired.emit(self, attack_kind)
	return projectile

func _get_projectile_parent() -> Node:
	var tree := get_tree()
	if tree and tree.current_scene:
		return tree.current_scene
	if get_parent():
		return get_parent()
	return self
