extends Node
class_name HealthComponent

signal health_changed(current: float, maximum: float)
signal damaged(amount: float, source: Dictionary)
signal healed(amount: float)
signal died(source: Dictionary)
signal invincibility_started(duration: float)
signal invincibility_ended()
signal damage_ignored(reason: String, source: Dictionary)

@export var max_health: float = 100.0:
	set(value):
		max_health = maxf(1.0, value)
		current_health = clampf(current_health, 0.0, max_health)
		health_changed.emit(current_health, max_health)
@export var start_full: bool = true
@export var destroy_owner_on_death: bool = false
@export var default_invincibility_duration: float = 0.0
@export var enemy_size: String = "medium"

var current_health: float = 100.0
var is_invincible: bool = false
var invincibility_timer: float = 0.0
var last_damage_source: Dictionary = {}

func _ready() -> void:
	if start_full:
		current_health = max_health
	else:
		current_health = clampf(current_health, 0.0, max_health)
	health_changed.emit(current_health, max_health)

func _process(delta: float) -> void:
	_update_invincibility(delta)

func set_max_health(value: float, refill: bool = true) -> void:
	max_health = maxf(1.0, value)
	if refill:
		current_health = max_health
	else:
		current_health = clampf(current_health, 0.0, max_health)
	health_changed.emit(current_health, max_health)

func take_damage(base_damage: float, damage_source: Dictionary = {}) -> float:
	if is_dead():
		damage_ignored.emit("dead", damage_source)
		return 0.0
	if is_invincible and not damage_source.get("ignore_invincibility", false):
		damage_ignored.emit("invincible", damage_source)
		return 0.0

	last_damage_source = damage_source.duplicate(true)
	var final_damage := DamageCalculator.calculate(base_damage, damage_source, owner if owner else get_parent())
	current_health = maxf(0.0, current_health - final_damage)
	damaged.emit(final_damage, damage_source)
	health_changed.emit(current_health, max_health)

	var iframe_duration := float(damage_source.get("invincibility_duration", default_invincibility_duration))
	if iframe_duration > 0.0 and current_health > 0.0:
		trigger_invincibility(iframe_duration)

	if current_health <= 0.0:
		_die(damage_source)

	return final_damage

func heal(amount: float) -> float:
	if amount <= 0.0 or is_dead():
		return 0.0
	var before := current_health
	current_health = minf(max_health, current_health + amount)
	var healed_amount := current_health - before
	if healed_amount > 0.0:
		healed.emit(healed_amount)
		health_changed.emit(current_health, max_health)
	return healed_amount

func trigger_invincibility(duration: float) -> void:
	is_invincible = true
	invincibility_timer = maxf(invincibility_timer, duration)
	invincibility_started.emit(invincibility_timer)

func clear_invincibility() -> void:
	if not is_invincible:
		return
	is_invincible = false
	invincibility_timer = 0.0
	invincibility_ended.emit()

func get_current_health() -> float:
	return current_health

func get_health_percent() -> float:
	return current_health / max_health if max_health > 0.0 else 0.0

func is_dead() -> bool:
	return current_health <= 0.0

func _update_invincibility(delta: float) -> void:
	if not is_invincible:
		return
	invincibility_timer -= delta
	if invincibility_timer <= 0.0:
		clear_invincibility()

func _die(damage_source: Dictionary) -> void:
	died.emit(damage_source)
	if destroy_owner_on_death and is_instance_valid(owner):
		owner.queue_free()
