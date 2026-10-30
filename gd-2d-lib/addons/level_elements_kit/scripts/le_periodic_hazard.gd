## Damage zone that cycles through idle, warning and attacking periods.
##
## It changes fill color and active monitoring and emits phase signals.[br]
## Damage still follows the inherited entry-trigger contract.

@tool
extends LE_DamageZone
class_name LE_PeriodicHazard
## Telegraph -> damaging -> idle loop. Uses the DamageZone interface.

## Emitted at the start of the warning phase.
signal telegraph_started
## Emitted when the damaging phase becomes active.
signal attack_started
## Emitted when the damaging phase ends.
signal attack_finished

@export_group("Timing")
## Duration of harmless idle state before telegraph.
@export_range(0.1, 30.0, 0.1) var idle_seconds: float = 1.5
## Duration of visible warning before attack begins.
@export_range(0.1, 10.0, 0.1) var warning_seconds: float = 0.7
## Duration of active damage monitoring before the next idle period.
@export_range(0.1, 30.0, 0.1) var attack_seconds: float = 0.9
## Temporary placeholder fill used during the telegraph.
@export var warning_color: Color = Color(1.0, 0.68, 0.16)
## Temporary placeholder fill used during the attack state.
@export var attack_color: Color = Color(0.98, 0.18, 0.18)

## Original placeholder fill restored during the idle phase.
var _default_color: Color

## Starts with damage disabled, caches the normal fill color and launches the cycle outside the editor.
func _ready() -> void:
	if not Engine.is_editor_hint():
		active = false
	super._ready()
	if not Engine.is_editor_hint():
		_default_color = fill_color
		_cycle()

## Repeats idle, warning and attack using timers, fill-color changes and phase signals. It enables Area monitoring during the attack period.
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
