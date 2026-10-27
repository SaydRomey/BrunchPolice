@tool
extends LE_DamageZone
class_name LE_PeriodicHazard
## Telegraph -> damaging -> idle loop. Uses the DamageZone interface.

signal telegraph_started
signal attack_started
signal attack_finished

@export_group("Timing")
@export_range(0.1, 30.0, 0.1) var idle_seconds: float = 1.5
@export_range(0.1, 10.0, 0.1) var warning_seconds: float = 0.7
@export_range(0.1, 30.0, 0.1) var attack_seconds: float = 0.9
@export var warning_color: Color = Color(1.0, 0.68, 0.16)
@export var attack_color: Color = Color(0.98, 0.18, 0.18)

var _default_color: Color

func _ready() -> void:
	if not Engine.is_editor_hint():
		active = false
	super._ready()
	if not Engine.is_editor_hint():
		_default_color = fill_color
		_cycle()

func _cycle() -> void:
	while is_inside_tree():
		active = false
		fill_color = _default_color
		await get_tree().create_timer(idle_seconds).timeout
		if not is_inside_tree():
			return
		telegraph_started.emit()
		fill_color = warning_color
		await get_tree().create_timer(warning_seconds).timeout
		if not is_inside_tree():
			return
		fill_color = attack_color
		active = true
		attack_started.emit()
		await get_tree().create_timer(attack_seconds).timeout
		if not is_inside_tree():
			return
		active = false
		attack_finished.emit()
