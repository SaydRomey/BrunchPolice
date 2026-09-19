extends Node
class_name InventoryManager

signal item_added(item_name: String, quantity: int)
signal item_removed(item_name: String, quantity: int)
signal item_used(item_name: String)
signal item_equipped(slot_name: String, item_name: String)
signal inventory_changed()

@export var max_unique_items: int = 24

var items: Dictionary = {}
var equipped: Dictionary = {
	"main_hand": "",
	"off_hand": "",
	"two_hand": ""
}

func add_item(item_name: String, item_type: String = "item", quantity: int = 1, data: Dictionary = {}) -> bool:
	if item_name.is_empty() or quantity <= 0:
		return false
	if not items.has(item_name) and items.size() >= max_unique_items:
		push_warning("Inventory full.")
		return false

	if not items.has(item_name):
		items[item_name] = {
			"name": item_name,
			"type": item_type,
			"quantity": 0,
			"data": data.duplicate(true)
		}
	items[item_name]["quantity"] += quantity
	item_added.emit(item_name, quantity)
	inventory_changed.emit()
	return true

func remove_item(item_name: String, quantity: int = 1) -> bool:
	if not has_item(item_name, quantity):
		return false
	items[item_name]["quantity"] -= quantity
	if items[item_name]["quantity"] <= 0:
		items.erase(item_name)
		_clear_equipped_item(item_name)
	item_removed.emit(item_name, quantity)
	inventory_changed.emit()
	return true

func has_item(item_name: String, quantity: int = 1) -> bool:
	return items.has(item_name) and int(items[item_name].get("quantity", 0)) >= quantity

func use_item(item_name: String, quantity: int = 1) -> bool:
	if not remove_item(item_name, quantity):
		return false
	item_used.emit(item_name)
	return true

func equip_item(item_name: String, slot_name: String = "main_hand") -> bool:
	if not has_item(item_name):
		push_warning("Cannot equip missing item: %s" % item_name)
		return false
	if not equipped.has(slot_name):
		push_warning("Unknown equipment slot: %s" % slot_name)
		return false

	if slot_name == "two_hand":
		equipped["main_hand"] = ""
		equipped["off_hand"] = ""
		equipped["two_hand"] = item_name
	else:
		equipped["two_hand"] = ""
		equipped[slot_name] = item_name

	item_equipped.emit(slot_name, item_name)
	inventory_changed.emit()
	return true

func unequip(slot_name: String) -> void:
	if slot_name in equipped:
		equipped[slot_name] = ""
		inventory_changed.emit()

func get_item(item_name: String) -> Dictionary:
	return items.get(item_name, {}).duplicate(true)

func get_all_items() -> Dictionary:
	return items.duplicate(true)

func get_equipped() -> Dictionary:
	return equipped.duplicate(true)

func set_state(new_items: Dictionary, new_equipped: Dictionary) -> void:
	items = new_items.duplicate(true)
	for slot_name in equipped.keys():
		equipped[slot_name] = String(new_equipped.get(slot_name, ""))
	inventory_changed.emit()

func clear() -> void:
	items.clear()
	for slot_name in equipped.keys():
		equipped[slot_name] = ""
	inventory_changed.emit()

func _clear_equipped_item(item_name: String) -> void:
	for slot_name in equipped.keys():
		if equipped[slot_name] == item_name:
			equipped[slot_name] = ""
