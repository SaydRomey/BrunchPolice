# res://combat/health_component.gd
class_name HealthComponent
extends Node

signal damaged(amount: int, damage_data: Dictionary)
signal healed(amount: int)
signal died

@export var max_health := 3
var current_health := 3


func _ready() -> void:
	current_health = max_health


func take_damage(amount: int, damage_data: Dictionary = {}) -> void:
	if amount <= 0:
		return

	current_health = max(current_health - amount, 0)
	damaged.emit(amount, damage_data)

	if current_health <= 0:
		died.emit()


func heal(amount: int) -> void:
	if amount <= 0:
		return

	current_health = min(current_health + amount, max_health)
	healed.emit(amount)


func is_dead() -> bool:
	return current_health <= 0
