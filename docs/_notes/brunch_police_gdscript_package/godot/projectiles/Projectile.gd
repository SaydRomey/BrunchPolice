extends Area2D
class_name Projectile

signal hit_body(body: Node)
signal expired(projectile: Projectile)

@export var speed: float = 300.0
@export var damage: float = 10.0
@export var max_range: float = 800.0
@export var lifespan: float = 3.0
@export var destroy_on_hit: bool = true
@export var hit_groups: Array[StringName] = [&"enemy"]

var velocity: Vector2 = Vector2.RIGHT
var source: Node
var effect_data: Dictionary = {}
var _start_position: Vector2
var _age: float = 0.0
var _has_hit: bool = false

func _ready() -> void:
	_start_position = global_position
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)
	if not area_entered.is_connected(_on_area_entered):
		area_entered.connect(_on_area_entered)

func _physics_process(delta: float) -> void:
	global_position += velocity * speed * delta
	_age += delta
	if _age >= lifespan or global_position.distance_to(_start_position) >= max_range:
		expire()

func set_velocity(direction: Vector2) -> void:
	velocity = direction.normalized() if direction != Vector2.ZERO else Vector2.RIGHT

func set_damage(value: float) -> void:
	damage = value

func set_speed_multiplier(multiplier: float) -> void:
	speed *= multiplier

func set_effect_data(data: Dictionary) -> void:
	effect_data = data.duplicate(true)

func set_source(node: Node) -> void:
	source = node

func expire() -> void:
	expired.emit(self)
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	_handle_hit(area)

func _on_body_entered(body: Node) -> void:
	_handle_hit(body)

func _handle_hit(body: Node) -> void:
	if _has_hit and destroy_on_hit:
		return
	if body == source:
		return
	if not _is_valid_target(body):
		return

	_has_hit = true
	_apply_damage(body)
	_apply_effect(body)
	hit_body.emit(body)

	if destroy_on_hit:
		queue_free()

func _is_valid_target(body: Node) -> bool:
	if hit_groups.is_empty():
		return true
	for group_name in hit_groups:
		if body.is_in_group(group_name):
			return true
	return body.has_method("take_damage") or _target_accepts_effect(body)

func _apply_damage(body: Node) -> void:
	if damage <= 0.0:
		return
	if body.has_method("take_damage"):
		body.take_damage(damage, {"source": source, "projectile": self, "effect": effect_data})

func _apply_effect(body: Node) -> void:
	var method_name := String(effect_data.get("method", ""))
	if method_name.is_empty() or not body.has_method(method_name):
		return

	var duration := effect_data.get("duration", null)
	var strength := effect_data.get("strength", null)
	if duration != null and strength != null:
		body.call(method_name, duration, strength)
	elif duration != null:
		body.call(method_name, duration)
	else:
		body.call(method_name)

func _target_accepts_effect(body: Node) -> bool:
	var method_name := String(effect_data.get("method", ""))
	return not method_name.is_empty() and body.has_method(method_name)
