extends CharacterBody2D

signal clue_collected(total: int)
signal player_respawned

# Movement tuning.
# walk_speed and run_speed are in screen pixels per second.
@export var walk_speed: float = 175.0
@export var run_speed: float = 285.0

# Higher acceleration means the player reaches full speed faster.
# Lower acceleration gives more slide / easing.
@export var acceleration: float = 12.0

# Optional deadzone so tiny input values do not trigger animation changes.
@export var input_deadzone: float = 0.05

# This should point to the AnimatedSprite2D child on the Player scene.
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

# Keep this if your scene has InteractArea.
# It is not used in this basic movement script yet, but leaving it here is fine.
@onready var interact_area: Area2D = $InteractArea

var spawn_position: Vector2 = Vector2.ZERO
var collected_clues: int = 0

# The last direction the character faced.
# This is used for idle animations.
var facing_dir: String = "s"

# Used so we do not restart the same animation every physics frame.
var current_animation: StringName = &""

# This maps screen-space movement angle to your animation direction names.
#
# Screen-space directions:
# e  = right
# se = down-right
# s  = down
# sw = down-left
# w  = left
# nw = up-left
# n  = up
# ne = up-right
#
# If the character faces the wrong way, change this array only.
# Do not change the movement conversion unless movement itself is wrong.
const DIRS_CLOCKWISE: Array[String] = [
	"e",
	"se",
	"s",
	"sw",
	"w",
	"nw",
	"n",
	"ne"
]

func _ready() -> void:
	spawn_position = global_position

	# Required for manual y-depth sorting in an isometric scene.
	z_as_relative = false

	# Your sheet already has all directions.
	# Do not flip horizontally or left/right directions will become inconsistent.
	anim.flip_h = false

	# This script does not build SpriteFrames.
	# Add the animations manually in AnimatedSprite2D's SpriteFrames resource.
	#
	# Expected names:
	# idle_n, idle_ne, idle_e, idle_se, idle_s, idle_sw, idle_w, idle_nw
	# walk_n, walk_ne, walk_e, walk_se, walk_s, walk_sw, walk_w, walk_nw
	# run_n,  run_ne,  run_e,  run_se,  run_s,  run_sw,  run_w,  run_nw
	_play_animation("idle")


func _physics_process(delta: float) -> void:
	# Read input as grid/cardinal movement.
	#
	# In your input map, these should exist:
	# move_right
	# move_left
	# move_down
	# move_up
	# run
	#var input_vec: Vector2 = Vector2(
		#Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		#Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	#)
	var input_vec: Vector2 = _get_input_vector()

	var has_keyboard_input: bool = input_vec.length() > input_deadzone

	var target_velocity: Vector2 = Vector2.ZERO

	if has_keyboard_input:
		var screen_vec: Vector2 = _input_to_iso_screen_vector(input_vec)

		# Store facing direction only while input is active.
		# When input stops, the idle animation uses this saved direction.
		facing_dir = _direction_from_screen_vector(screen_vec)

		var target_speed: float = run_speed if Input.is_action_pressed("run") else walk_speed
		target_velocity = screen_vec * target_speed

		if Input.is_action_pressed("run"):
			_play_animation("run")
		else:
			_play_animation("walk")
	else:
		# No input means idle, regardless of leftover velocity.
		# This prevents walk/run animations from playing while the player is standing still.
		_play_animation("idle")

	# Smooth velocity toward the target.
	# If there is no input, target_velocity is Vector2.ZERO.
	velocity = velocity.lerp(
		target_velocity,
		clamp(acceleration * delta, 0.0, 1.0)
	)

	# Kill tiny leftover movement after releasing the key.
	if not has_keyboard_input and velocity.length() < 3.0:
		velocity = Vector2.ZERO

	move_and_slide()

	z_index = int(global_position.y)

	## Prevent diagonal input from being faster than straight input.
	#if input_vec.length() > 1.0:
		#input_vec = input_vec.normalized()
#
	#var is_moving: bool = input_vec.length() > input_deadzone
#
	#var screen_vec: Vector2 = Vector2.ZERO
#
	#if is_moving:
		## Convert top-down grid input into isometric screen movement.
		##
		## input_vec.x = east/west on the logical grid.
		## input_vec.y = south/north on the logical grid.
		##
		## This formula turns that into diamond/isometric screen movement.
		#screen_vec = Vector2(
			#input_vec.x - input_vec.y,
			#(input_vec.x + input_vec.y) * 0.5
		#)
#
		#if screen_vec.length() > 0.0:
			#screen_vec = screen_vec.normalized()
#
		## Store the direction so idle uses the last direction faced.
		#facing_dir = _direction_from_screen_vector(screen_vec)
#
	#var target_speed: float = run_speed if Input.is_action_pressed("run") else walk_speed
	#var target_velocity: Vector2 = screen_vec * target_speed
#
	## Smoothly move current velocity toward the target velocity.
	#velocity = velocity.lerp(
		#target_velocity,
		#clamp(acceleration * delta, 0.0, 1.0)
	#)
#
	## Avoid tiny leftover sliding when input stops.
	#if not is_moving and velocity.length() < 2.0:
		#velocity = Vector2.ZERO
#
	#move_and_slide()
#
	## Pick animation after movement has been calculated.
	#if is_moving:
		#if Input.is_action_pressed("run"):
			#_play_animation("run")
		#else:
			#_play_animation("walk")
	#else:
		#_play_animation("idle")
#
	## Isometric depth sorting.
	## Lower screen position draws in front of higher screen position.
	#z_index = int(global_position.y)


func _get_input_vector() -> Vector2:
	var input_vec := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)

	if input_vec.length() > 1.0:
		input_vec = input_vec.normalized()

	return input_vec


func _input_to_iso_screen_vector(input_vec: Vector2) -> Vector2:
	var screen_vec := Vector2(
		input_vec.x - input_vec.y,
		(input_vec.x + input_vec.y) * 0.5
	)

	if screen_vec.length() > 0.0:
		screen_vec = screen_vec.normalized()

	return screen_vec


func _direction_from_screen_vector(v: Vector2) -> String:
	# atan2 gives the angle of the screen movement vector.
	# Then we divide by 45 degrees, round, and use that as an 8-direction index.
	var angle: float = atan2(v.y, v.x)
	var index: int = int(round(angle / (PI * 0.25)))

	# Wrap negative angles into the 0-7 range.
	index = (index + 8) % 8

	return DIRS_CLOCKWISE[index]


func _play_animation(state: String) -> void:
	# Animation names are built from movement state + facing direction.
	# Example:
	# state = "walk"
	# facing_dir = "se"
	# result = "walk_se"
	var animation_name: StringName = StringName("%s_%s" % [state, facing_dir])

	if anim.sprite_frames == null:
		push_warning("AnimatedSprite2D has no SpriteFrames resource.")
		return

	if not anim.sprite_frames.has_animation(animation_name):
		push_warning("Missing animation: %s" % animation_name)
		return

	# Do not call play() every frame if the animation is already active.
	# Calling play() repeatedly can make animations look stuck or jittery.
	if current_animation != animation_name:
		current_animation = animation_name
		anim.play(animation_name)


func add_clue() -> void:
	collected_clues += 1
	clue_collected.emit(collected_clues)


func respawn() -> void:
	global_position = spawn_position
	velocity = Vector2.ZERO
	_play_animation("idle")
	player_respawned.emit()
