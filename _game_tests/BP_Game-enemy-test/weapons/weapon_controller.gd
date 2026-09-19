# res://weapons/weapon_controller.gd
class_name WeaponController
extends Node2D

@export var starting_weapon: WeaponData
@export var attacks_enabled_in_hub := false
@export var attack_origin_distance := 28.0
@export var held_weapon_distance := 18.0

var player: Player
var equipped_weapon: WeaponData
var cooldown_timer := 0.0
var ammo := -1

@onready var attack_origin: Marker2D = $AttackOrigin
@onready var held_weapon_sprite: Sprite2D = $HeldWeaponSprite


func _ready() -> void:
	player = owner as Player
	assert(player != null, "WeaponController must be a child of Player.")

	if starting_weapon != null:
		equip_weapon(starting_weapon)


func _physics_process(delta: float) -> void:
	cooldown_timer = maxf(cooldown_timer - delta, 0.0)
	update_attack_origin()
	update_held_weapon_sprite()

	if Input.is_action_just_pressed("attack_primary"):
		attack()


func equip_weapon(weapon: WeaponData) -> void:
	equipped_weapon = weapon
	cooldown_timer = 0.0
	ammo = weapon.ammo_capacity

	if held_weapon_sprite != null:
		held_weapon_sprite.texture = weapon.held_texture
		held_weapon_sprite.visible = weapon.held_texture != null


func can_attack() -> bool:
	if equipped_weapon == null:
		return false

	# The hub is primarily for investigating. Set attacks_enabled_in_hub to true
	# if you later add harmless tools or hub-only equipment.
	if not attacks_enabled_in_hub and _player_is_in_hub_mode():
		return false

	if cooldown_timer > 0.0:
		return false

	if equipped_weapon.ammo_capacity >= 0 and ammo <= 0:
		return false

	return true


func attack() -> void:
	if not can_attack():
		return

	cooldown_timer = equipped_weapon.cooldown

	if equipped_weapon.ammo_capacity >= 0:
		ammo -= 1

	if player.has_method("play_directional_animation") and equipped_weapon.attack_animation_base != "":
		player.play_directional_animation(equipped_weapon.attack_animation_base)

	match equipped_weapon.range_type:
		WeaponData.RangeType.MELEE:
			spawn_melee_hitbox()
		WeaponData.RangeType.RANGED:
			spawn_projectile()
		WeaponData.RangeType.THROWABLE:
			spawn_projectile()
		WeaponData.RangeType.DEFENSIVE:
			activate_defense()
		WeaponData.RangeType.UTILITY:
			activate_utility()


func spawn_melee_hitbox() -> void:
	if equipped_weapon.melee_hitbox_scene == null:
		push_warning("Weapon has no melee_hitbox_scene: " + equipped_weapon.weapon_id)
		return

	var hitbox := equipped_weapon.melee_hitbox_scene.instantiate()
	get_tree().current_scene.add_child(hitbox)

	hitbox.global_position = attack_origin.global_position
	hitbox.setup(player, equipped_weapon, get_attack_direction())


func spawn_projectile() -> void:
	if equipped_weapon.projectile_scene == null:
		push_warning("Weapon has no projectile_scene: " + equipped_weapon.weapon_id)
		return

	var projectile := equipped_weapon.projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)

	projectile.global_position = attack_origin.global_position
	projectile.setup(player, equipped_weapon, get_attack_direction())


func activate_defense() -> void:
	# Later: shield, parry, temporary armor, one-hit protection.
	pass


func activate_utility() -> void:
	# Later: grease slide, syrup boots, trap placement, evidence scanner, etc.
	pass


func get_attack_direction() -> Vector2:
	var facing_name := _get_player_facing_name()

	match facing_name:
		"north":
			return Vector2.UP
		"north_east":
			return Vector2(1.0, -1.0).normalized()
		"east":
			return Vector2.RIGHT
		"south_east":
			return Vector2(1.0, 1.0).normalized()
		"south":
			return Vector2.DOWN
		"south_west":
			return Vector2(-1.0, 1.0).normalized()
		"west":
			return Vector2.LEFT
		"north_west":
			return Vector2(-1.0, -1.0).normalized()

	return Vector2.RIGHT


func update_attack_origin() -> void:
	if attack_origin == null:
		return

	attack_origin.position = get_attack_direction() * attack_origin_distance


func update_held_weapon_sprite() -> void:
	if held_weapon_sprite == null or equipped_weapon == null:
		return

	if held_weapon_sprite.texture == null:
		held_weapon_sprite.texture = equipped_weapon.held_texture

	var direction := get_attack_direction()
	held_weapon_sprite.position = direction * held_weapon_distance
	held_weapon_sprite.flip_h = direction.x < 0.0
	held_weapon_sprite.visible = held_weapon_sprite.texture != null


func _get_player_facing_name() -> String:
	# Works with the player.gd from the hub/platformer package.
	if player.has_method("get_facing_suffixes"):
		var suffixes: Array = player.get_facing_suffixes()
		if not suffixes.is_empty():
			return str(suffixes[0])

	if player.has_method("get_facing_suffix"):
		return str(player.get_facing_suffix())

	# Fallback for the earlier four-direction enum: SOUTH=0, EAST=1, WEST=2, NORTH=3.
	var value := int(player.facing)
	match value:
		0:
			return "south"
		1:
			return "east"
		2:
			return "west"
		3:
			return "north"

	return "east"


func _player_is_in_hub_mode() -> bool:
	if not "movement_mode" in player:
		return false

	if not "MovementMode" in player:
		return false

	return player.movement_mode == player.MovementMode.HUB_TOP_DOWN
