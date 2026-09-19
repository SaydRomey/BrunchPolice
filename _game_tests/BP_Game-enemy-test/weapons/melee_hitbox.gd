# res://weapons/melee_hitbox.gd
class_name MeleeHitbox
extends Area2D

@export var lifetime := 0.12

var source: Node
var weapon: WeaponData
var direction := Vector2.RIGHT
var hit_bodies: Array[Node] = []


func setup(source_node: Node, weapon_data: WeaponData, attack_direction: Vector2) -> void:
	source = source_node
	weapon = weapon_data
	direction = attack_direction.normalized()
	rotation = direction.angle()


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	await get_tree().create_timer(lifetime).timeout
	queue_free()


func _on_body_entered(body: Node) -> void:
	if body == source:
		return

	if body in hit_bodies:
		return

	hit_bodies.append(body)

	if body.has_method("take_damage"):
		body.take_damage(weapon.damage, _build_damage_data())


func _build_damage_data() -> Dictionary:
	return {
		"weapon_id": weapon.weapon_id,
		"status_effects": weapon.status_effects,
		"status_duration": weapon.status_duration,
		"knockback": direction * weapon.knockback,
		"source": source
	}
