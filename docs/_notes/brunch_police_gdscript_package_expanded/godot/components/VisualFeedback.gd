extends Node
class_name VisualFeedback

@export var target_path: NodePath
@export var blink_interval: float = 0.1

var target: CanvasItem
var _blink_running: bool = false

func _ready() -> void:
	if target_path != NodePath():
		target = get_node_or_null(target_path) as CanvasItem
	if target == null:
		target = get_parent() as CanvasItem

func blink(duration: float = 1.0, interval: float = -1.0) -> void:
	if target == null or _blink_running:
		return
	_blink_running = true
	var step := blink_interval if interval <= 0.0 else interval
	var elapsed := 0.0
	while elapsed < duration and is_instance_valid(target):
		target.visible = not target.visible
		await get_tree().create_timer(step).timeout
		elapsed += step
	if is_instance_valid(target):
		target.visible = true
	_blink_running = false
