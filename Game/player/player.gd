# player/player.gd
class_name Player extends CharacterBody2D

@export_category("Movement")
@export var walk_speed := 300.0
@export var run_speed := 500.0
@export var crouch_walk_speed := 150.0
@export var air_speed := 500.0
#@export var speed := 500.0         ## Horizontal speed in pixels per second.
@export var gravity := 4000.0      ## Vertical acceleration in pixel per second squared.
@export var jump_impulse := 1800.0 ## Vertical speed applied when jumping.

@export_category("Glide")
@export var glide_max_speed := 1000.0
@export var glide_acceleration := 1000.0
@export var glide_gravity := 400.0
@export var glide_jump_impulse := 800.0

enum Facing { SOUTH, EAST, WEST, NORTH }
var facing : Facing = Facing.SOUTH

@onready var fsm := $StateMachine
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func get_move_input() -> float:
		return Input.get_axis("move_left", "move_right")


func has_move_input(input_x: float) -> bool:
	return not is_equal_approx(input_x, 0.0)


func set_facing_from_input(input_direction_x: float) -> void:
	if input_direction_x > 0.0:
		facing = Facing.EAST
	elif input_direction_x < 0.0:
		facing = Facing.WEST
	else:
		facing = Facing.SOUTH


func get_facing_suffix() -> String:
	match facing:
		Facing.SOUTH: return "south"
		Facing.EAST: return "east"
		Facing.WEST: return "west"
		Facing.NORTH: return "north"
	return "south" # Fallback


func stop_horizontal_movement() -> void:
	velocity.x = 0.0


func apply_horizontal_movement(input_x: float, movement_speed: float) -> void:
	set_facing_from_input(input_x)
	velocity.x = movement_speed * input_x


func apply_gravity(delta: float, gravity_value := gravity) -> void:
	if is_on_floor() and velocity.y >= 0.0:
		velocity.y = 0.0
	else:
		velocity.y += gravity_value * delta


func move_with_input(delta: float, input_x: float, movement_speed: float) -> void:
	apply_horizontal_movement(input_x, movement_speed)
	apply_gravity(delta)
	move_and_slide()


func play_directional_animation(base_name: String) -> void:
	var animation_name := "%s_%s" % [base_name, get_facing_suffix()]

	if animated_sprite.sprite_frames == null:
		push_warning("AnimatedSprite2D has no SpriteFrames resource.")
		return

	if not animated_sprite.sprite_frames.has_animation(animation_name):
		push_warning("Missing animation: " + animation_name)
		return

	if animated_sprite.animation != animation_name:
		animated_sprite.play(animation_name)
	elif not animated_sprite.is_playing():
		animated_sprite.play()

## DEBUG
#func get_debug_label_text() -> String:
	#if fsm == null or fsm.state == null:
		#return "Player: none"
	##return "Player: %s" % fsm.state.name
	#return "%s" % fsm.state.name
