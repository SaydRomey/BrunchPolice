# res://weapons/weapon_pickup.gd
class_name WeaponPickup
extends Area2D

@export var weapon_data: WeaponData

@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	if weapon_data != null and weapon_data.pickup_texture != null:
		sprite.texture = weapon_data.pickup_texture

	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node) -> void:
	if not body is Player:
		return

	var controller := body.get_node_or_null("WeaponController") as WeaponController
	if controller == null:
		push_warning("Player has no WeaponController.")
		return

	controller.equip_weapon(weapon_data)
	queue_free()
