extends Node
class_name SpriteAnimationController

@export var sprite_path: NodePath
@export var default_state: String = "idle"

var sprite: AnimatedSprite2D
var animation_states: Dictionary = {}
var current_state: String = ""

func _ready() -> void:
	if sprite_path != NodePath():
		sprite = get_node_or_null(sprite_path) as AnimatedSprite2D
	if sprite == null:
		sprite = get_parent().get_node_or_null("AnimatedSprite2D") as AnimatedSprite2D
	if default_state != "":
		play_state(default_state)

func set_sprite(sprite_node: AnimatedSprite2D) -> void:
	sprite = sprite_node

func add_animation_state(state: String, animation_name: String) -> void:
	animation_states[state] = animation_name

func play_state(state: String, restart: bool = false) -> void:
	if sprite == null:
		push_warning("SpriteAnimationController has no AnimatedSprite2D assigned.")
		return
	var animation_name := String(animation_states.get(state, state))
	if not sprite.sprite_frames or not sprite.sprite_frames.has_animation(animation_name):
		push_warning("Animation not found: %s" % animation_name)
		return
	if restart or current_state != state:
		sprite.play(animation_name)
		current_state = state

func set_animation_speed(speed_scale: float) -> void:
	if sprite != null:
		sprite.speed_scale = speed_scale

func set_direction(facing_right: bool) -> void:
	if sprite != null:
		sprite.flip_h = not facing_right

func get_current_state() -> String:
	return current_state
