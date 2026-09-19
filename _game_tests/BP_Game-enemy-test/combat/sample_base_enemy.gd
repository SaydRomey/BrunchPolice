# res://combat/sample_base_enemy.gd
# Optional reference script showing the interface expected by the weapon module.
class_name SampleBaseEnemy
extends CharacterBody2D

@export var speed := 80.0
@onready var health_component: HealthComponent = $HealthComponent
@onready var status_effect_receiver: StatusEffectReceiver = $StatusEffectReceiver


func take_damage(amount: int, damage_data: Dictionary = {}) -> void:
	health_component.take_damage(amount, damage_data)

	if damage_data.has("knockback"):
		velocity += damage_data["knockback"]

	for status in damage_data.get("status_effects", []):
		status_effect_receiver.apply_status(status, damage_data.get("status_duration", 1.0))

	if health_component.is_dead():
		queue_free()
