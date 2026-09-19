# enemies/enemy_projectile.gd
class_name EnemyProjectile
extends Area2D

@export var speed := 450.0
@export var damage := 1
@export var knockback_force := 220.0
@export var lifetime := 2.0

var source: Node
var direction := Vector2.LEFT


func setup(source_node: Node, attack_direction: Vector2) -> void:
	source = source_node
	direction = attack_direction.normalized()
	rotation = direction.angle()


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	await get_tree().create_timer(lifetime).timeout
	queue_free()


func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta


func _on_body_entered(body: Node) -> void:
	if body == source:
		return

	if body.has_method("take_damage"):
		body.take_damage(damage, {
			"source": source,
			"knockback": direction * knockback_force,
			"damage_type": "enemy_projectile"
		})

	queue_free()
