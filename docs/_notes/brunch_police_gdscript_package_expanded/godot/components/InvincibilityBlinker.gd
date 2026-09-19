extends Node
class_name InvincibilityBlinker

@export var target_path: NodePath
@export var blink_interval: float = 0.08
@export var health_component_path: NodePath

var _target: CanvasItem
var _health: HealthComponent
var _timer: float = 0.0
var _active: bool = false

func _ready() -> void:
	_target = get_node_or_null(target_path) as CanvasItem
	_health = get_node_or_null(health_component_path) as HealthComponent
	if _health == null:
		_health = get_parent().get_node_or_null("HealthComponent") as HealthComponent
	if _health:
		_health.invincibility_started.connect(_on_invincibility_started)
		_health.invincibility_ended.connect(_on_invincibility_ended)

func _process(delta: float) -> void:
	if not _active or _target == null:
		return
	_timer -= delta
	if _timer <= 0.0:
		_timer = blink_interval
		_target.visible = not _target.visible

func _on_invincibility_started(_duration: float) -> void:
	if _target == null:
		return
	_active = true
	_timer = 0.0

func _on_invincibility_ended() -> void:
	_active = false
	if _target:
		_target.visible = true
