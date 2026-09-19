# enemies/small_angry_pig.gd
class_name SmallAngryPig
extends PlatformerPatrolEnemy

enum PigChargeState {
	NONE,
	WINDUP,
	CHARGING,
	RECOVERY
}

@export var charge_speed := 420.0
@export var charge_windup_time := 0.35
@export var charge_duration := 0.75
@export var charge_recovery_time := 0.45

var charge_state: PigChargeState = PigChargeState.NONE
var charge_timer := 0.0


func _ready() -> void:
	super()

	enemy_id = "small_angry_pig"
	display_name = "Small Angry Pig"
	level_source = "Grease Canyon"
	enemy_class = "Ground charger"
	max_health = max(max_health, 2)
	health = max_health


func update_chasing(delta: float) -> void:
	if target == null:
		set_state(EnemyState.PATROLLING)
		return

	var distance := global_position.distance_to(target.global_position)

	if distance <= detection_range and charge_state == PigChargeState.NONE:
		start_charge_windup()
		return

	if charge_state != PigChargeState.NONE:
		update_charge(delta)
		return

	super.update_chasing(delta)


func start_charge_windup() -> void:
	charge_state = PigChargeState.WINDUP
	charge_timer = charge_windup_time
	velocity.x = 0.0
	play_animation("charge_windup")


func update_charge(delta: float) -> void:
	charge_timer -= delta

	match charge_state:
		PigChargeState.WINDUP:
			velocity.x = 0.0
			apply_default_gravity(delta)
			move_and_slide()

			if charge_timer <= 0.0:
				if target != null:
					direction = sign(target.global_position.x - global_position.x)
					if is_equal_approx(direction, 0.0):
						direction = -1.0

				update_sprite_flip()
				charge_state = PigChargeState.CHARGING
				charge_timer = charge_duration
				play_animation("charge")

		PigChargeState.CHARGING:
			if should_turn_around():
				stop_charge_recovery()
				return

			velocity.x = direction * charge_speed
			apply_default_gravity(delta)
			move_and_slide()

			if charge_timer <= 0.0:
				stop_charge_recovery()

		PigChargeState.RECOVERY:
			velocity.x = move_toward(velocity.x, 0.0, charge_speed * 3.0 * delta)
			apply_default_gravity(delta)
			move_and_slide()

			if charge_timer <= 0.0:
				charge_state = PigChargeState.NONE
				set_state(EnemyState.PATROLLING)


func stop_charge_recovery() -> void:
	charge_state = PigChargeState.RECOVERY
	charge_timer = charge_recovery_time
	play_animation(stunned_animation)


func apply_status(status: String, duration: float) -> void:
	charge_state = PigChargeState.NONE
	super.apply_status(status, duration)
