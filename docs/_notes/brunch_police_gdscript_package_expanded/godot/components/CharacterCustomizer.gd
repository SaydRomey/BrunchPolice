extends Node
class_name CharacterCustomizer

signal customization_changed(options: Dictionary)
signal customizations_applied(options: Dictionary)

@export var base_sprite_path: NodePath
@export var hair_sprite_path: NodePath
@export var outfit_sprite_path: NodePath
@export var accessory_sprite_path: NodePath

var customization_options: Dictionary = {
	"skin_tone": "default",
	"hair_color": "default",
	"outfit": "default",
	"accessory": "none"
}

var skin_tone_colors: Dictionary = {
	"default": Color(1.0, 1.0, 1.0),
	"light": Color(1.0, 0.82, 0.66),
	"medium": Color(0.72, 0.48, 0.32),
	"dark": Color(0.38, 0.27, 0.2)
}

var hair_colors: Dictionary = {
	"default": Color(1.0, 1.0, 1.0),
	"black": Color(0.05, 0.04, 0.035),
	"brown": Color(0.35, 0.18, 0.08),
	"blonde": Color(0.9, 0.72, 0.28),
	"red": Color(0.75, 0.18, 0.08)
}

var outfit_textures: Dictionary = {}
var accessory_textures: Dictionary = {}

func set_customization_option(key: String, value: String) -> void:
	if not customization_options.has(key):
		push_warning("Invalid customization key: %s" % key)
		return
	customization_options[key] = value
	customization_changed.emit(customization_options.duplicate(true))

func get_customization_option(key: String) -> String:
	return String(customization_options.get(key, ""))

func set_options(options: Dictionary, apply_now: bool = true) -> void:
	for key in options.keys():
		if customization_options.has(key):
			customization_options[key] = options[key]
	customization_changed.emit(customization_options.duplicate(true))
	if apply_now:
		apply_customizations()

func get_options() -> Dictionary:
	return customization_options.duplicate(true)

func register_outfit_texture(outfit_id: String, texture: Texture2D) -> void:
	outfit_textures[outfit_id] = texture

func register_accessory_texture(accessory_id: String, texture: Texture2D) -> void:
	accessory_textures[accessory_id] = texture

func apply_customizations() -> void:
	var base_sprite := get_node_or_null(base_sprite_path) as Sprite2D
	var hair_sprite := get_node_or_null(hair_sprite_path) as Sprite2D
	var outfit_sprite := get_node_or_null(outfit_sprite_path) as Sprite2D
	var accessory_sprite := get_node_or_null(accessory_sprite_path) as Sprite2D

	if base_sprite:
		base_sprite.modulate = skin_tone_colors.get(customization_options["skin_tone"], skin_tone_colors["default"])
	if hair_sprite:
		hair_sprite.modulate = hair_colors.get(customization_options["hair_color"], hair_colors["default"])
	if outfit_sprite and outfit_textures.has(customization_options["outfit"]):
		outfit_sprite.texture = outfit_textures[customization_options["outfit"]]
	if accessory_sprite:
		var accessory_id := String(customization_options["accessory"])
		accessory_sprite.visible = accessory_id != "none"
		if accessory_textures.has(accessory_id):
			accessory_sprite.texture = accessory_textures[accessory_id]

	customizations_applied.emit(customization_options.duplicate(true))
