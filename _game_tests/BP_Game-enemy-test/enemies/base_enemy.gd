# enemies/base_enemy.gd
class_name BaseEnemy
extends CharacterBody2D

signal died(enemy: BaseEnemy)
signal damaged(enemy: BaseEnemy, amount: int, damage_data: Dictionary)
signal state_changed(enemy: BaseEnemy, old_state: EnemyState, new_state: EnemyState)

enum EnemyState {
	IDLE,
	PATROLLING,
	CHASING,
	ATTACKING,
	STUNNED,
	WRAPPED,
	SLOWED,
	DEAD
}

@export_category("Identity")
@export var enemy_data: EnemyData
@export var enemy_id := "base_enemy"
@export var display_name := "Base Enemy"
@export var level_source := ""
@export var enemy_class := ""

@export_category("Stats")
@export var max_health := 3
@export var speed := 90.0
@export var damage := 1
@export var detection_range := 220.0
@export var attack_range := 32.0
@export var attack_cooldown := 0.8
@export var knockback_force := 320.0
@export var gravity := 4000.0

@export_category("Movement")
@export var starts_facing_right := false
@export var apply_gravity := true
@export var avoid_edges := true
@export var wall_turns_enemy := true

@export_category("Animation")
@export var idle_animation := "idle"
@export var patrol_animation := "patrol"
@export var chase_animation := "chase"
@export var attack_animation := "attack"
@export var stunned_animation := "stunned"
@export var wrapped_animation := "wrapped"
@export var death_animation := "defeat"

var health := 1
var state: EnemyState = EnemyState.IDLE
var direction := -1.0
var target: Node2D
var attack_timer := 0.0
var status_timer := 0.0
var status_speed_multiplier := 1.0
var is_dead := false

@onready var sprite: AnimatedSprite2D = get_node_or_null("AnimatedSprite2D")
@onready var floor_ray_left: RayCast2D = get_node_or_null("FloorRayLeft")
@onready var floor_ray_right: RayCast2D = get_node_or_null("FloorRayRight")
@onready var wall_ray_left: RayCast2D = get_node_or_null("WallRayLeft")
@onready var wall_ray_right: RayCast2D = get_node_or_null("WallRayRight")
@onready var contact_damage_area: Area2D = get_node_or_null("ContactDamageArea")


func _ready() -> void:
	_apply_enemy_data()

	health = max_health
	direction = 1.0 if starts_facing_right else -1.0
	target = get_tree().get_first_node_in_group("player") as Node2D

	if contact_damage_area != null and contact_damage_area.has_method("setup"):
		contact_damage_area.setup(self, damage, knockback_force)

	set_state(EnemyState.PATROLLING)


func _apply_enemy_data() -> void:
	if enemy_data == null:
		return

	if enemy_data.enemy_id != "":
		enemy_id = enemy_data.enemy_id
	if enemy_data.display_name != "":
		display_name = enemy_data.display_name
	if enemy_data.level_source != "":
		level_source = enemy_data.level_source
	if enemy_data.enemy_class != "":
		enemy_class = enemy_data.enemy_class

	max_health = enemy_data.max_health
	speed = enemy_data.speed
	damage = enemy_data.damage
	detection_range = enemy_data.detection_range
	attack_range = enemy_data.attack_range
	attack_cooldown = enemy_data.attack_cooldown
	knockback_force = enemy_data.knockback_force
	gravity = enemy_data.gravity


func _physics_process(delta: float) -> void:
	if is_dead:
		return

	attack_timer = maxf(attack_timer - delta, 0.0)

	if status_timer > 0.0:
		status_timer = maxf(status_timer - delta, 0.0)
		if status_timer <= 0.0:
			_clear_temporary_status()

	match state:
		EnemyState.IDLE:
			update_idle(delta)
		EnemyState.PATROLLING:
			update_patrolling(delta)
		EnemyState.CHASING:
			update_chasing(delta)
		EnemyState.ATTACKING:
			update_attacking(delta)
		EnemyState.STUNNED, EnemyState.WRAPPED:
			update_disabled(delta)
		EnemyState.SLOWED:
			update_chasing(delta)
		EnemyState.DEAD:
			pass


func update_idle(delta: float) -> void:
	play_animation(idle_animation)
	apply_default_gravity(delta)
	move_and_slide()

	if can_see_target():
		set_state(EnemyState.CHASING)


func update_patrolling(delta: float) -> void:
	play_animation(patrol_animation)

	if can_see_target():
		set_state(EnemyState.CHASING)
		return

	patrol_move(delta)


func update_chasing(delta: float) -> void:
	play_animation(chase_animation)

	if target == null:
		set_state(EnemyState.PATROLLING)
		return

	var distance := global_position.distance_to(target.global_position)

	if distance <= attack_range and attack_timer <= 0.0:
		set_state(EnemyState.ATTACKING)
		return

	chase_target(delta)


func update_attacking(delta: float) -> void:
	play_animation(attack_animation)
	velocity.x = move_toward(velocity.x, 0.0, speed * 6.0 * delta)
	apply_default_gravity(delta)
	move_and_slide()

	attack_timer = attack_cooldown
	set_state(EnemyState.CHASING)


func update_disabled(delta: float) -> void:
	velocity.x = move_toward(velocity.x, 0.0, speed * 8.0 * delta)
	apply_default_gravity(delta)
	move_and_slide()


func patrol_move(delta: float) -> void:
	if should_turn_around():
		turn_around()

	velocity.x = direction * speed * status_speed_multiplier
	apply_default_gravity(delta)
	move_and_slide()


func chase_target(delta: float) -> void:
	if target == null:
		return

	direction = sign(target.global_position.x - global_position.x)
	if is_equal_approx(direction, 0.0):
		direction = 1.0

	if should_turn_around() and avoid_edges:
		velocity.x = 0.0
	else:
		velocity.x = direction * speed * status_speed_multiplier

	apply_default_gravity(delta)
	move_and_slide()


func apply_default_gravity(delta: float) -> void:
	if not apply_gravity:
		return

	if is_on_floor() and velocity.y >= 0.0:
		velocity.y = 0.0
	else:
		velocity.y += gravity * delta


func should_turn_around() -> bool:
	if wall_turns_enemy:
		if direction < 0.0 and wall_ray_left != null and wall_ray_left.is_colliding():
			return true
		if direction > 0.0 and wall_ray_right != null and wall_ray_right.is_colliding():
			return true

	if avoid_edges and is_on_floor():
		if direction < 0.0 and floor_ray_left != null and not floor_ray_left.is_colliding():
			return true
		if direction > 0.0 and floor_ray_right != null and not floor_ray_right.is_colliding():
			return true

	return false


func turn_around() -> void:
	direction *= -1.0
	update_sprite_flip()


func update_sprite_flip() -> void:
	if sprite != null:
		sprite.flip_h = direction > 0.0


func can_see_target() -> bool:
	if target == null:
		target = get_tree().get_first_node_in_group("player") as Node2D
		if target == null:
			return false

	return global_position.distance_to(target.global_position) <= detection_range


func set_state(new_state: EnemyState) -> void:
	if state == new_state:
		return

	var old_state := state
	state = new_state
	state_changed.emit(self, old_state, new_state)

	match new_state:
		EnemyState.IDLE:
			play_animation(idle_animation)
		EnemyState.PATROLLING:
			play_animation(patrol_animation)
		EnemyState.CHASING:
			play_animation(chase_animation)
		EnemyState.ATTACKING:
			play_animation(attack_animation)
		EnemyState.STUNNED:
			play_animation(stunned_animation)
		EnemyState.WRAPPED:
			play_animation(wrapped_animation)
		EnemyState.DEAD:
			play_animation(death_animation)


func play_animation(animation_name: String) -> void:
	if sprite == null or sprite.sprite_frames == null:
		return

	if not sprite.sprite_frames.has_animation(animation_name):
		return

	if sprite.animation != animation_name:
		sprite.play(animation_name)
	elif not sprite.is_playing():
		sprite.play()


func take_damage(amount: int, damage_data: Dictionary = {}) -> void:
	if is_dead:
		return

	health -= amount
	damaged.emit(self, amount, damage_data)

	if damage_data.has("knockback"):
		velocity += damage_data["knockback"]

	var status_effects: Array = damage_data.get("status_effects", [])
	var duration := float(damage_data.get("status_duration", 1.0))

	for status in status_effects:
		apply_status(str(status), duration)

	if health <= 0:
		die()


func apply_status(status: String, duration: float) -> void:
	if enemy_data != null and status in enemy_data.status_resistances:
		return

	match status:
		"wrapped", "immobilized":
			status_timer = duration
			status_speed_multiplier = 0.0
			set_state(EnemyState.WRAPPED)

		"stunned":
			status_timer = duration
			status_speed_multiplier = 0.0
			set_state(EnemyState.STUNNED)

		"slowed", "sticky":
			status_timer = duration
			status_speed_multiplier = 0.45
			set_state(EnemyState.SLOWED)

		"frozen":
			status_timer = duration
			status_speed_multiplier = 0.0
			set_state(EnemyState.STUNNED)

		"blinded":
			# Later: reduce detection, line of sight, or ranged accuracy.
			status_timer = duration


func _clear_temporary_status() -> void:
	status_speed_multiplier = 1.0

	if state in [EnemyState.STUNNED, EnemyState.WRAPPED, EnemyState.SLOWED]:
		if can_see_target():
			set_state(EnemyState.CHASING)
		else:
			set_state(EnemyState.PATROLLING)


func die() -> void:
	is_dead = true
	set_state(EnemyState.DEAD)
	died.emit(self)

	if sprite != null and sprite.sprite_frames != null and sprite.sprite_frames.has_animation(death_animation):
		await sprite.animation_finished

	queue_free()


func check_is_dead() -> bool:
	return health <= 0 or is_dead
