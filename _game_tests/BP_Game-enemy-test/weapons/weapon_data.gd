# res://weapons/weapon_data.gd
class_name WeaponData
extends Resource

enum SlotType {
	MAIN_HAND,
	OFF_HAND,
	TWO_HANDED,
	TEMPORARY,
	REWARD,
	POWER_ITEM
}

enum RangeType {
	MELEE,
	RANGED,
	THROWABLE,
	DEFENSIVE,
	UTILITY
}

@export var weapon_id := ""
@export var display_name := ""
@export var level_source := ""

@export var slot_type: SlotType = SlotType.MAIN_HAND
@export var range_type: RangeType = RangeType.MELEE

@export var damage := 1
@export var cooldown := 0.25
@export var knockback := 200.0

# -1 means infinite ammo.
@export var ammo_capacity := -1

@export var projectile_scene: PackedScene
@export var melee_hitbox_scene: PackedScene

@export var status_effects: Array[String] = []
@export var status_duration := 1.0

@export var icon: Texture2D
@export var held_texture: Texture2D
@export var pickup_texture: Texture2D

@export var attack_animation_base := "attack"
@export var projectile_speed := 900.0
@export var projectile_lifetime := 1.5

@export var is_temporary := false
@export var is_reward := false

@export_multiline var notes := ""
