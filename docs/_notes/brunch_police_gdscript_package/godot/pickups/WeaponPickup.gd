extends Area2D
class_name WeaponPickup

@export var weapon_scene: PackedScene
@export var item_name: String = "Weapon"
@export var item_type: String = "weapon"
@export var inventory_slot: String = "main_hand"
@export var auto_equip: bool = true

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("player") and body.name != "Player":
		return

	var inventory := get_node_or_null("/root/Inventory")
	if inventory != null and inventory.has_method("add_item"):
		inventory.add_item(item_name, item_type, 1, {"slot": inventory_slot})
		if auto_equip and inventory.has_method("equip_item"):
			inventory.equip_item(item_name, inventory_slot)

	if auto_equip and weapon_scene != null:
		var controller := body.get_node_or_null("PlayerWeaponController")
		if controller != null and controller.has_method("equip_weapon"):
			var weapon := weapon_scene.instantiate()
			body.add_child(weapon)
			controller.equip_weapon(weapon)

	queue_free()
