extends Node
class_name PlayerWeaponController

signal weapon_equipped(slot_name: String, weapon: Weapon)
signal weapon_unequipped(slot_name: String)

@export var player_path: NodePath
@export var default_direction: Vector2 = Vector2.RIGHT

var player: Node2D
var main_hand: Weapon
var off_hand: Weapon
var two_hand: Weapon
var facing_direction: Vector2 = Vector2.RIGHT

func _ready() -> void:
	player = get_node_or_null(player_path) as Node2D
	if player == null:
		player = get_parent() as Node2D

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack_main"):
		attack_main(false)
	elif event.is_action_pressed("attack_main_charged"):
		attack_main(true)
	elif event.is_action_pressed("attack_offhand"):
		attack_offhand(false)
	elif event.is_action_pressed("attack_special"):
		attack_special()

func set_facing_direction(direction: Vector2) -> void:
	if direction != Vector2.ZERO:
		facing_direction = direction.normalized()

func equip_weapon(weapon: Weapon) -> void:
	if weapon == null:
		return
	weapon.set_wielder(player)

	match weapon.slot:
		Weapon.WeaponSlot.TWO_HAND:
			_clear_main_and_offhand()
			two_hand = weapon
			weapon_equipped.emit("two_hand", weapon)
		Weapon.WeaponSlot.MAIN_HAND:
			_clear_two_hand()
			main_hand = weapon
			weapon_equipped.emit("main_hand", weapon)
		Weapon.WeaponSlot.OFF_HAND:
			_clear_two_hand()
			off_hand = weapon
			weapon_equipped.emit("off_hand", weapon)

func unequip_slot(slot_name: String) -> void:
	match slot_name:
		"main_hand":
			main_hand = null
		"off_hand":
			off_hand = null
		"two_hand":
			two_hand = null
	weapon_unequipped.emit(slot_name)

func attack_main(charged: bool = false) -> Variant:
	var weapon := two_hand if two_hand != null else main_hand
	return _attack_with_weapon(weapon, charged)

func attack_offhand(charged: bool = false) -> Variant:
	if two_hand != null:
		return null
	return _attack_with_weapon(off_hand, charged)

func attack_special() -> Variant:
	if two_hand == null:
		return null
	return two_hand.attack_special(_attack_position(), facing_direction)

func _attack_with_weapon(weapon: Weapon, charged: bool) -> Variant:
	if weapon == null:
		return null
	if charged:
		return weapon.attack_charged(_attack_position(), facing_direction)
	return weapon.attack_quick(_attack_position(), facing_direction)

func _attack_position() -> Vector2:
	if player != null:
		return player.global_position
	return Vector2.ZERO

func _clear_main_and_offhand() -> void:
	if main_hand != null:
		weapon_unequipped.emit("main_hand")
	if off_hand != null:
		weapon_unequipped.emit("off_hand")
	main_hand = null
	off_hand = null

func _clear_two_hand() -> void:
	if two_hand != null:
		weapon_unequipped.emit("two_hand")
	two_hand = null
