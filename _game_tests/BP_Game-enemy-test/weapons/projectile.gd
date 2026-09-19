# res://weapons/projectile.gd
class_name WeaponProjectile
extends Area2D

var source: Node
var weapon: WeaponData
var direction := Vector2.RIGHT
var velocity := Vector2.ZERO

@onready var sprite: Sprite2D = $Sprite2D


func setup(source_node: Node, weapon_data: WeaponData, attack_direction: Vector2) -> void:
	source = source_node
	weapon = weapon_data
	direction = attack_direction.normalized()
	velocity = direction * weapon.projectile_speed
	rotation = direction.angle()


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	await get_tree().create_timer(weapon.projectile_lifetime).timeout
	queue_free()


func _physics_process(delta: float) -> void:
	global_position += velocity * delta


func _on_body_entered(body: Node) -> void:
	if body == source:
		return

	if body.has_method("take_damage"):
		body.take_damage(weapon.damage, _build_damage_data())

	queue_free()


func _build_damage_data() -> Dictionary:
	return {
		"weapon_id": weapon.weapon_id,
		"status_effects": weapon.status_effects,
		"status_duration": weapon.status_duration,
		"knockback": direction * weapon.knockback,
		"source": source
	}
