# res://combat/status_effect_receiver.gd
class_name StatusEffectReceiver
extends Node

signal status_started(status_name: String, duration: float)
signal status_ended(status_name: String)

var active_statuses: Dictionary = {}


func apply_status(status_name: String, duration: float) -> void:
	if status_name == "":
		return

	active_statuses[status_name] = duration
	status_started.emit(status_name, duration)


func has_status(status_name: String) -> bool:
	return active_statuses.has(status_name)


func _process(delta: float) -> void:
	var finished_statuses: Array[String] = []

	for status_name in active_statuses.keys():
		active_statuses[status_name] -= delta
		if active_statuses[status_name] <= 0.0:
			finished_statuses.append(status_name)

	for status_name in finished_statuses:
		active_statuses.erase(status_name)
		status_ended.emit(status_name)
