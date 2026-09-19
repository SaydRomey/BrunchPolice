extends CanvasLayer
class_name DebugOverlay

@export var toggle_action: String = "toggle_debug"
@export var target_path: NodePath
@export var update_interval: float = 0.1
@export var start_visible: bool = false

var custom_values: Dictionary = {}
var _label: Label
var _target: Node
var _timer: float = 0.0

func _ready() -> void:
	visible = start_visible
	_target = get_node_or_null(target_path)
	_label = Label.new()
	_label.name = "DebugLabel"
	_label.position = Vector2(12, 12)
	_label.size = Vector2(520, 360)
	add_child(_label)
	_update_text()

func _process(delta: float) -> void:
	if not toggle_action.is_empty() and Input.is_action_just_pressed(toggle_action):
		visible = not visible
	if not visible:
		return
	_timer -= delta
	if _timer <= 0.0:
		_timer = update_interval
		_update_text()

func set_target(node: Node) -> void:
	_target = node

func set_debug_value(key: String, value: Variant) -> void:
	custom_values[key] = value

func clear_debug_value(key: String) -> void:
	custom_values.erase(key)

func _update_text() -> void:
	if _label == null:
		return
	var lines: Array[String] = []
	lines.append("FPS: %s" % Engine.get_frames_per_second())
	lines.append("Memory Static: %.2f MB" % (float(Performance.get_monitor(Performance.MEMORY_STATIC)) / 1048576.0))
	lines.append("Scene: %s" % (get_tree().current_scene.scene_file_path if get_tree().current_scene else "none"))
	if is_instance_valid(_target):
		if _target is Node2D:
			lines.append("Target Position: %s" % (_target as Node2D).global_position)
		var velocity_value = _target.get("velocity")
		if velocity_value != null:
			lines.append("Target Velocity: %s" % velocity_value)
	for key in custom_values.keys():
		lines.append("%s: %s" % [key, custom_values[key]])
	_label.text = "\n".join(lines)
