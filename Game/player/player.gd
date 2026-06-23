# Character that moves and jumps.
class_name Player extends CharacterBody2D

@export var speed := 500.0         ## Horizontal speed in pixels per second.
@export var gravity := 4000.0      ## Vertical acceleration in pixel per second squared.
@export var jump_impulse := 1800.0 ## Vertical speed applied when jumping.

#@export var glide_max_speed := 1000.0
#@export var glide_acceleration := 1000.0
#@export var glide_gravity := 400.0
#@export var glide_jump_impulse := 800.0

var facing := 1

@onready var fsm := $StateMachine
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var label : Label = $"../CanvasLayer/Label"


func _process(_delta: float) -> void:
	if is_instance_valid(label):
		label.text = fsm.state.name


func set_facing_from_input(input_direction_x: float) -> void:
	if input_direction_x > 0.0:
		facing = 1
	elif input_direction_x < 0.0:
		facing = -1


func get_facing_suffix() -> String:
	return "east" if facing > 0 else "west"


func play_directional_animation(base_name: String) -> void:
	var animation_name := "%s_%s" % [base_name, get_facing_suffix()]

	if animated_sprite.sprite_frames == null:
		return

	if not animated_sprite.sprite_frames.has_animation(animation_name):
		push_warning("Missing animation: " + animation_name)
		return

	if animated_sprite.animation != animation_name:
		animated_sprite.play(animation_name)
	elif not animated_sprite.is_playing():
		animated_sprite.play
