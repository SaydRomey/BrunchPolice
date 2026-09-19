# debug/debug_inspectable_2D_v2.gd
class_name DebugInspectable2D
extends Node2D

enum DebugMode {
	SUMMARY,
	STATE,
	MOTION,
	ANIMATION,
	COLLISION,
	CUSTOM,
	ALL,
}

const MODE_COUNT := 7
const MODE_NAMES := [
	"Summary",
	"State",
	"Motion",
	"Animation",
	"Collision",
	"Custom",
	"All",
]

@export var target_path: NodePath = ^".."
@export var state_machine_path: NodePath = NodePath("")
@export var animated_sprite_path: NodePath = NodePath("")

@export var start_visible := false
@export var show_when_cycling := true

#@export_enum("Summary", "State", "Motion", "Animation", "Collision", "Custom", "All")
var default_mode := DebugMode.SUMMARY

@export var label_offset := Vector2(-90.0, -105.0)
@export var label_size := Vector2(180.0, 120.0)
@export var update_interval := 0.1

@export var left_click_button := MOUSE_BUTTON_LEFT
@export var right_click_button := MOUSE_BUTTON_RIGHT
@export var group_name := "debug_inspectables"

var target: Node
var collision_target: CollisionObject2D
var state_machine: StateMachine
var animated_sprite: AnimatedSprite2D
var label: Label

var debug_mode := DebugMode.SUMMARY
var _time_until_update := 0.0


func _ready() -> void:
	target = get_node_or_null(target_path)

	if target == null:
		target = get_parent()

	collision_target = target as CollisionObject2D

	assert(
		collision_target != null,
		"DebugInspectable2D must point to a CollisionObject2D, such as CharacterBody2D, Area2D, StaticBody2D, or RigidBody2D."
	)

	if collision_target.collision_layer == 0:
		push_warning("%s has no collision layer set, so mouse picking may not work." % collision_target.name)

	collision_target.input_pickable = true
	collision_target.input_event.connect(_on_target_input_event)

	debug_mode = default_mode

	add_to_group(group_name)

	_setup_label()
	_resolve_state_machine()
	_resolve_animated_sprite()

	set_debug_visible(start_visible)


func _setup_label() -> void:
	label = get_node_or_null("DebugLabel") as Label

	if label == null:
		label = Label.new()
		label.name = "DebugLabel"
		add_child(label)

	label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_TOP
	label.custom_minimum_size = label_size
	label.size = label_size
	label.position = label_offset
	label.z_index = 100


func _resolve_state_machine() -> void:
	if str(state_machine_path) != "":
		state_machine = get_node_or_null(state_machine_path) as StateMachine
		return

	if target != null and target.has_node("StateMachine"):
		state_machine = target.get_node("StateMachine") as StateMachine


func _resolve_animated_sprite() -> void:
	if str(animated_sprite_path) != "":
		animated_sprite = get_node_or_null(animated_sprite_path) as AnimatedSprite2D
		return

	if target != null and target.has_node("AnimatedSprite2D"):
		animated_sprite = target.get_node("AnimatedSprite2D") as AnimatedSprite2D


func _process(delta: float) -> void:
	_time_until_update -= delta

	if _time_until_update <= 0.0:
		_time_until_update = update_interval
		_update_label_text()


func _on_target_input_event(viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is not InputEventMouseButton:
		return

	var mouse_event := event as InputEventMouseButton

	if not mouse_event.pressed:
		return

	if mouse_event.button_index == left_click_button:
		set_debug_visible(not visible)
		viewport.set_input_as_handled()
		return

	if mouse_event.button_index == right_click_button:
		cycle_debug_mode()

		if show_when_cycling:
			set_debug_visible(true)
		else:
			_update_label_text()

		viewport.set_input_as_handled()
		return


func set_debug_visible(enabled: bool) -> void:
	visible = enabled
	set_process(enabled)

	if label != null:
		label.visible = enabled

	if enabled:
		_time_until_update = 0.0
		_update_label_text()


func cycle_debug_mode() -> void:
	debug_mode = (debug_mode + 1) % MODE_COUNT
	_update_label_text()


func _update_label_text() -> void:
	if label == null:
		return

	label.text = _get_debug_text()


func _get_debug_text() -> String:
	match debug_mode:
		DebugMode.SUMMARY:
			return _with_header(_get_summary_text())
		DebugMode.STATE:
			return _with_header(_get_state_text())
		DebugMode.MOTION:
			return _with_header(_get_motion_text())
		DebugMode.ANIMATION:
			return _with_header(_get_animation_text())
		DebugMode.COLLISION:
			return _with_header(_get_collision_text())
		DebugMode.CUSTOM:
			return _with_header(_get_custom_text())
		DebugMode.ALL:
			return _with_header(_get_all_text())

	return "Debug"


func _with_header(body: String) -> String:
	return "%s\n%s" % [MODE_NAMES[debug_mode], body]


func _get_summary_text() -> String:
	var lines: Array[String] = []

	lines.append("Target: %s" % _get_target_name())
	lines.append("State: %s" % _get_state_name())
	lines.append("Facing: %s" % _get_facing_text())
	lines.append("Position: %s" % _get_position_text())

	if target is CharacterBody2D:
		var body := target as CharacterBody2D
		lines.append("Velocity: %s" % _format_vector2(body.velocity))

	if animated_sprite != null:
		lines.append("Animation: %s" % str(animated_sprite.animation))

	return "\n".join(lines)


func _get_state_text() -> String:
	var lines: Array[String] = []

	lines.append("Target: %s" % _get_target_name())
	lines.append("State: %s" % _get_state_name())

	if state_machine != null:
		lines.append("FSM: %s" % state_machine.name)
	else:
		lines.append("FSM: none")

	return "\n".join(lines)


func _get_motion_text() -> String:
	var lines: Array[String] = []

	lines.append("Position: %s" % _get_position_text())
	lines.append("Facing: %s" % _get_facing_text())

	if target is CharacterBody2D:
		var body := target as CharacterBody2D
		lines.append("Velocity: %s" % _format_vector2(body.velocity))
		lines.append("Speed: %.1f" % body.velocity.length())
		lines.append("On Floor: %s" % str(body.is_on_floor()))
		lines.append("On Wall: %s" % str(body.is_on_wall()))
		lines.append("On Ceiling: %s" % str(body.is_on_ceiling()))
	else:
		lines.append("Velocity: unavailable")

	return "\n".join(lines)


func _get_animation_text() -> String:
	if animated_sprite == null:
		return "Animation: none"

	var lines: Array[String] = []

	lines.append("Animation: %s" % str(animated_sprite.animation))
	lines.append("Frame: %d" % animated_sprite.frame)
	lines.append("Playing: %s" % str(animated_sprite.is_playing()))
	lines.append("Speed Scale: %.2f" % animated_sprite.speed_scale)

	if animated_sprite.sprite_frames != null:
		var frame_count := animated_sprite.sprite_frames.get_frame_count(animated_sprite.animation)
		lines.append("Frame Count: %d" % frame_count)

	return "\n".join(lines)


func _get_collision_text() -> String:
	var lines: Array[String] = []

	if collision_target != null:
		lines.append("Layer: %s" % str(collision_target.collision_layer))
		lines.append("Mask: %s" % str(collision_target.collision_mask))

	if target is CharacterBody2D:
		var body := target as CharacterBody2D

		lines.append("On Floor: %s" % str(body.is_on_floor()))
		lines.append("On Wall: %s" % str(body.is_on_wall()))
		lines.append("On Ceiling: %s" % str(body.is_on_ceiling()))
		lines.append("Slides: %d" % body.get_slide_collision_count())

		for i in range(body.get_slide_collision_count()):
			var collision := body.get_slide_collision(i)
			var collider := collision.get_collider()
			var collider_name := "unknown"

			if collider is Node:
				collider_name = (collider as Node).name

			lines.append("%d: %s %s" % [
				i,
				collider_name,
				_format_vector2(collision.get_normal())
			])

	elif target is Area2D:
		var area := target as Area2D
		lines.append("Bodies: %d" % area.get_overlapping_bodies().size())
		lines.append("Areas: %d" % area.get_overlapping_areas().size())
	else:
		lines.append("Collision telemetry unavailable")

	return "\n".join(lines)


func _get_custom_text() -> String:
	if target == null:
		return "No target"

	if target.has_method("get_debug_label_text"):
		return str(target.call("get_debug_label_text"))

	if target.has_method("get_debug_text"):
		return str(target.call("get_debug_text"))

	return "No custom debug data"


func _get_all_text() -> String:
	var lines: Array[String] = []

	lines.append(_get_summary_text())
	lines.append("")
	lines.append(_get_collision_text())

	return "\n".join(lines)


func _get_target_name() -> String:
	if target == null:
		return "none"

	return target.name


func _get_state_name() -> String:
	if state_machine == null:
		return "none"

	if state_machine.state == null:
		return "none"

	return state_machine.state.name


func _get_position_text() -> String:
	if target is Node2D:
		return _format_vector2((target as Node2D).global_position)

	return "unavailable"


func _get_facing_text() -> String:
	if target == null:
		return "unavailable"

	var facing_value = target.get("facing")

	if facing_value == null:
		return "unavailable"

	if int(facing_value) > 0:
		return "east (%d)" % int(facing_value)

	if int(facing_value) < 0:
		return "west (%d)" % int(facing_value)

	return "neutral (%d)" % int(facing_value)


func _format_vector2(value: Vector2) -> String:
	return "(%.1f, %.1f)" % [value.x, value.y]


## TODO: (maybe) a global hide-all function
#func hide_all_debug_labels() -> void:
	#for debug_node in get_tree().get_nodes_in_group("debug_inspectables"):
		#if debug_node.has_method("set_debug_visible"):
			#debug_node.set_debug_visible(false)
