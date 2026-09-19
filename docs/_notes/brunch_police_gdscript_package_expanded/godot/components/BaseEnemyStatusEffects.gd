extends CharacterBody2D
class_name BaseEnemyStatusEffects

signal damaged(amount: float, source: Dictionary)
signal defeated()
signal status_applied(status_name: String, duration: float)
signal status_removed(status_name: String)

@export var max_health: float = 100.0
@export var wrapped_modulate: Color = Color(1.0, 0.65, 0.45, 1.0)
@export var blinded_modulate: Color = Color(1.0, 1.0, 1.0, 0.55)
@export var slowed_speed_multiplier: float = 0.45

var health: float
var base_speed: float = 80.0
var current_speed_multiplier: float = 1.0
var is_wrapped: bool = false
var is_blinded: bool = false
var is_stunned: bool = false
var original_modulate: Color = Color.WHITE

@onready var sprite: CanvasItem = get_node_or_null("Sprite2D") as CanvasItem

func _ready() -> void:
	health = max_health
	if sprite != null:
		original_modulate = sprite.modulate

func take_damage(amount: float, source: Dictionary = {}) -> void:
	if amount <= 0.0:
		return
	health = maxf(0.0, health - amount)
	damaged.emit(amount, source)
	if health <= 0.0:
		defeated.emit()
		queue_free()

func apply_bacon_wrap(duration: float = 5.0) -> void:
	is_wrapped = true
	velocity = Vector2.ZERO
	_set_sprite_modulate(wrapped_modulate)
	status_applied.emit("bacon_wrap", duration)
	await get_tree().create_timer(duration).timeout
	is_wrapped = false
	_restore_sprite_modulate_if_clear()
	status_removed.emit("bacon_wrap")

func apply_syrup_effect(duration: float = 3.0) -> void:
	is_stunned = true
	velocity = Vector2.ZERO
	status_applied.emit("syrup", duration)
	await get_tree().create_timer(duration).timeout
	is_stunned = false
	status_removed.emit("syrup")

func apply_slippery_effect(duration: float = 3.0, strength: float = 1.8) -> void:
	current_speed_multiplier = strength
	status_applied.emit("slippery", duration)
	await get_tree().create_timer(duration).timeout
	current_speed_multiplier = 1.0
	status_removed.emit("slippery")

func apply_pushback(direction: Vector2, force: float = 320.0) -> void:
	velocity = direction.normalized() * force

func apply_whipped_cream(duration: float = 3.0, strength: float = 0.45) -> void:
	current_speed_multiplier = strength
	status_applied.emit("whipped_cream", duration)
	await get_tree().create_timer(duration).timeout
	current_speed_multiplier = 1.0
	status_removed.emit("whipped_cream")

func apply_blind_effect(duration: float = 2.0) -> void:
	is_blinded = true
	_set_sprite_modulate(blinded_modulate)
	status_applied.emit("blind", duration)
	await get_tree().create_timer(duration).timeout
	is_blinded = false
	_restore_sprite_modulate_if_clear()
	status_removed.emit("blind")

func apply_flour_blind(duration: float = 2.5, stun_duration: float = 0.35) -> void:
	apply_blind_effect(duration)
	is_stunned = true
	await get_tree().create_timer(stun_duration).timeout
	is_stunned = false

func apply_gummy_bear_effect(duration: float = 4.0, explosion_damage: float = 20.0) -> void:
	current_speed_multiplier = slowed_speed_multiplier
	status_applied.emit("gummy_bear", duration)
	await get_tree().create_timer(duration).timeout
	current_speed_multiplier = 1.0
	take_damage(explosion_damage, {"effect": "gummy_bear_explosion"})
	status_removed.emit("gummy_bear")

func apply_citrus_acid(duration: float = 2.0, push_force: float = 240.0) -> void:
	status_applied.emit("citrus_acid", duration)
	# Damage-over-time example.
	var ticks := 4
	for i in range(ticks):
		take_damage(1.0, {"effect": "citrus_acid"})
		await get_tree().create_timer(duration / float(ticks)).timeout
	status_removed.emit("citrus_acid")

func apply_yolk_splash(duration: float = 0.2, splash_damage: float = 18.0) -> void:
	take_damage(splash_damage, {"effect": "yolk_splash"})
	is_stunned = true
	await get_tree().create_timer(duration).timeout
	is_stunned = false

func cleanse_hazard() -> void:
	queue_free()

func _set_sprite_modulate(color: Color) -> void:
	if sprite != null:
		sprite.modulate = color

func _restore_sprite_modulate_if_clear() -> void:
	if sprite != null and not is_wrapped and not is_blinded:
		sprite.modulate = original_modulate
