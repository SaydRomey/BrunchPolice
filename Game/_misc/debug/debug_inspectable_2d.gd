class_name DebugInspectable2D
extends Node2D

@export var target_path: NodePath = ^".."
@export var state_machine_path: NodePath = NodePath("")
@export var start_visible := true

@export var label_offset := Vector2(-80.0, -80.0)
@export var label_size := Vector2(160.0, 24.0)
@export var update_interval := 0.1

@export var click_button := MOUSE_BUTTON_LEFT
#@export var group_name := "debug_inspectables"

var target: Node
var collision_target: CollisionObject2D
var state_machine: StateMachine
var label: Label

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

	#add_to_group(group_name)

	_setup_label()
	_resolve_state_machine()
	set_debug_visible(start_visible)


func _setup_label() -> void:
	label = get_node_or_null("DebugLabel") as Label

	if label == null:
		label = Label.new()
		label.name = "DebugLabel"
		add_child(label)

	label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.custom_minimum_size = label_size
	label.size = label_size
	label.position = label_offset
	label.z_index = 100


func _resolve_state_machine() -> void:
	if state_machine_path != NodePath(""):
		state_machine = get_node_or_null(state_machine_path) as StateMachine
		return

	if target != null and target.has_node("StateMachine"):
		state_machine = target.get_node("StateMachine") as StateMachine


func _process(delta: float) -> void:
	_time_until_update -= delta

	if _time_until_update <= 0.0:
		_time_until_update = update_interval
		_update_label_text()


func _on_target_input_event(viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is not InputEventMouseButton:
		return

	var mouse_event := event as InputEventMouseButton

	if mouse_event.button_index != click_button:
		return

	if not mouse_event.pressed:
		return

	set_debug_visible(not visible)
	viewport.set_input_as_handled()


func set_debug_visible(enabled: bool) -> void:
	visible = enabled
	set_process(enabled)

	if label != null:
		label.visible = enabled

	if enabled:
		_time_until_update = 0.0
		_update_label_text()


func _update_label_text() -> void:
	if label == null:
		return

	label.text = _get_debug_text()


func _get_debug_text() -> String:
	if target == null:
		return "Unknown"

	if target.has_method("get_debug_label_text"):
		return str(target.call("get_debug_label_text"))

	if state_machine != null and state_machine.state != null:
		#return "%s: %s" % [target.name, state_machine.state.name]
		return "%s" % [state_machine.state.name]

	return target.name

## TODO: (maybe) a global hide-all function
#func hide_all_debug_labels() -> void:
	#for debug_node in get_tree().get_nodes_in_group("debug_inspectables"):
		#if debug_node.has_method("set_debug_visible"):
			#debug_node.set_debug_visible(false)
