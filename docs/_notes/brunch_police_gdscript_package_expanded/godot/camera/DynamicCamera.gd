extends Camera2D
class_name DynamicCamera

@export var target_path: NodePath
@export var follow_speed: float = 8.0
@export var follow_offset: Vector2 = Vector2.ZERO
@export var snap_on_ready: bool = true
@export var enable_smoothing_follow: bool = true
@export var shake_decay: float = 8.0

var target: Node2D
var shake_strength: float = 0.0
var _base_offset: Vector2 = Vector2.ZERO

func _ready() -> void:
	_base_offset = offset
	if not target_path.is_empty():
		target = get_node_or_null(target_path) as Node2D
	if snap_on_ready and target:
		global_position = target.global_position + follow_offset

func _process(delta: float) -> void:
	_update_follow(delta)
	_update_shake(delta)

func set_target(node: Node2D) -> void:
	target = node

func set_follow_speed(speed: float) -> void:
	follow_speed = maxf(0.0, speed)

func zoom_to(factor: float, duration: float = 0.35) -> void:
	var tween := create_tween()
	tween.tween_property(self, "zoom", Vector2(factor, factor), maxf(0.0, duration)).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func pan_to(position: Vector2, duration: float = 0.4) -> void:
	var tween := create_tween()
	tween.tween_property(self, "global_position", position, maxf(0.0, duration)).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func shake(strength: float = 8.0, duration: float = 0.2) -> void:
	shake_strength = maxf(shake_strength, strength)
	if duration > 0.0:
		await get_tree().create_timer(duration).timeout
		shake_strength = minf(shake_strength, strength * 0.25)

func _update_follow(delta: float) -> void:
	if target == null:
		return
	var desired := target.global_position + follow_offset
	if enable_smoothing_follow:
		global_position = global_position.lerp(desired, clampf(follow_speed * delta, 0.0, 1.0))
	else:
		global_position = desired

func _update_shake(delta: float) -> void:
	if shake_strength <= 0.01:
		offset = _base_offset
		shake_strength = 0.0
		return
	var random_offset := Vector2(randf_range(-shake_strength, shake_strength), randf_range(-shake_strength, shake_strength))
	offset = _base_offset + random_offset
	shake_strength = lerpf(shake_strength, 0.0, clampf(shake_decay * delta, 0.0, 1.0))
