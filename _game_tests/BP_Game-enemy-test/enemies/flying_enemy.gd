# enemies/flying_enemy.gd
class_name FlyingEnemy
extends BaseEnemy

@export var hover_amplitude := 16.0
@export var hover_frequency := 3.0
@export var swoop_speed := 360.0
@export var return_speed := 120.0

var start_position := Vector2.ZERO
var time_alive := 0.0
var swooping := false


func _ready() -> void:
	apply_gravity = false
	avoid_edges = false
	wall_turns_enemy = false
	super()
	start_position = global_position


func update_patrolling(delta: float) -> void:
	time_alive += delta
	play_animation(patrol_animation)

	var hover_offset := sin(time_alive * hover_frequency) * hover_amplitude
	global_position.y = start_position.y + hover_offset

	if can_see_target():
		set_state(EnemyState.CHASING)


func update_chasing(delta: float) -> void:
	play_animation(chase_animation)

	if target == null:
		set_state(EnemyState.PATROLLING)
		return

	var to_target := target.global_position - global_position
	if to_target.length() <= attack_range and attack_timer <= 0.0:
		set_state(EnemyState.ATTACKING)
		return

	velocity = to_target.normalized() * return_speed * status_speed_multiplier
	move_and_slide()


func update_attacking(delta: float) -> void:
	play_animation(attack_animation)

	if target != null:
		var to_target := target.global_position - global_position
		velocity = to_target.normalized() * swoop_speed * status_speed_multiplier
	else:
		velocity = Vector2.ZERO

	move_and_slide()

	attack_timer = attack_cooldown
	set_state(EnemyState.CHASING)


func update_disabled(delta: float) -> void:
	velocity = velocity.move_toward(Vector2.ZERO, swoop_speed * delta)
	move_and_slide()
