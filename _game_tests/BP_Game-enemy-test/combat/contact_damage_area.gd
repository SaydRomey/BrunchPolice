# combat/contact_damage_area.gd
class_name ContactDamageArea
extends Area2D

@export var damage := 1
@export var knockback_force := 320.0
@export var hit_cooldown := 0.5

var source: Node
var _cooldowns: Dictionary = {}


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _physics_process(delta: float) -> void:
	for body in _cooldowns.keys():
		_cooldowns[body] = maxf(float(_cooldowns[body]) - delta, 0.0)


func setup(source_node: Node, damage_amount: int, knockback: float) -> void:
	source = source_node
	damage = damage_amount
	knockback_force = knockback


func _on_body_entered(body: Node) -> void:
	if body == source:
		return

	if _cooldowns.get(body, 0.0) > 0.0:
		return

	_cooldowns[body] = hit_cooldown

	var direction := Vector2.RIGHT
	if source is Node2D and body is Node2D:
		direction = ((body as Node2D).global_position - (source as Node2D).global_position).normalized()
		if direction == Vector2.ZERO:
			direction = Vector2.RIGHT

	if body.has_method("take_damage"):
		body.take_damage(damage, {
			"source": source,
			"knockback": direction * knockback_force,
			"damage_type": "contact"
		})
