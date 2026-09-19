# enemies/ranged_platformer_enemy.gd
class_name RangedPlatformerEnemy
extends PlatformerPatrolEnemy

@export var projectile_scene: PackedScene
@export var projectile_speed := 450.0
@export var projectile_spawn_offset := Vector2(20, -8)


func update_chasing(delta: float) -> void:
	if target == null:
		set_state(EnemyState.PATROLLING)
		return

	var distance := global_position.distance_to(target.global_position)

	if distance <= detection_range:
		direction = sign(target.global_position.x - global_position.x)
		if is_equal_approx(direction, 0.0):
			direction = -1.0
		update_sprite_flip()

	if distance <= attack_range and attack_timer <= 0.0:
		set_state(EnemyState.ATTACKING)
		return

	velocity.x = 0.0
	apply_default_gravity(delta)
	move_and_slide()


func update_attacking(delta: float) -> void:
	play_animation(attack_animation)
	velocity.x = 0.0
	apply_default_gravity(delta)
	move_and_slide()

	fire_projectile()

	attack_timer = attack_cooldown
	set_state(EnemyState.CHASING)


func fire_projectile() -> void:
	if projectile_scene == null or target == null:
		return

	var projectile := projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)

	var offset := projectile_spawn_offset
	offset.x *= direction
	projectile.global_position = global_position + offset

	var projectile_direction := (target.global_position - projectile.global_position).normalized()
	if projectile.has_method("setup"):
		projectile.setup(self, projectile_direction)
