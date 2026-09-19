
# 2 different movement modes:

#   Platformer mode:
# - Uses left/right input
# - Uses gravity
# - Has jump/fall
# - Has crouch/crouch-walk
# - Neutral input can face south by preference

# Isometric mode:
# - Uses 8-direction input
# - Does not use gravity
# - No jump/fall unless you add special cases
# - Movement direction controls facing

# ### player.gd
# player/player.gd
class_name Player extends CharacterBody2D

@export_category("Mode")
@export var starts_in_isometric_mode := false

@export_category("Platformer Movement")
@export var walk_speed := 300.0
@export var run_speed := 500.0
@export var crouch_walk_speed := 150.0
@export var air_speed := 500.0
@export var gravity := 4000.0
@export var jump_impulse := 1800.0

@export_category("Isometric Movement")
@export var iso_walk_speed := 220.0
@export var iso_run_speed := 360.0

enum Facing {
	SOUTH,
	SOUTH_EAST,
	EAST,
	NORTH_EAST,
	NORTH,
	NORTH_WEST,
	WEST,
	SOUTH_WEST
}

var facing: Facing = Facing.SOUTH

@onready var fsm := $StateMachine
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func get_platformer_input_x() -> float:
	return Input.get_axis("move_left", "move_right")


func get_iso_input() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")


func has_platformer_move_input(input_x: float) -> bool:
	return not is_equal_approx(input_x, 0.0)


func has_iso_move_input(input_vector: Vector2) -> bool:
	return input_vector.length_squared() > 0.0


func set_platformer_facing_from_input(input_x: float) -> void:
	if input_x > 0.0:
		facing = Facing.EAST
	elif input_x < 0.0:
		facing = Facing.WEST
	else:
		facing = Facing.SOUTH


func set_iso_facing_from_input(input_vector: Vector2) -> void:
	if not has_iso_move_input(input_vector):
		return

	var x := int(sign(input_vector.x))
	var y := int(sign(input_vector.y))

	if x == 0 and y > 0:
		facing = Facing.SOUTH
	elif x > 0 and y > 0:
		facing = Facing.SOUTH_EAST
	elif x > 0 and y == 0:
		facing = Facing.EAST
	elif x > 0 and y < 0:
		facing = Facing.NORTH_EAST
	elif x == 0 and y < 0:
		facing = Facing.NORTH
	elif x < 0 and y < 0:
		facing = Facing.NORTH_WEST
	elif x < 0 and y == 0:
		facing = Facing.WEST
	elif x < 0 and y > 0:
		facing = Facing.SOUTH_WEST


func get_facing_suffix() -> String:
	match facing:
		Facing.SOUTH:
			return "south"
		Facing.SOUTH_EAST:
			return "south_east"
		Facing.EAST:
			return "east"
		Facing.NORTH_EAST:
			return "north_east"
		Facing.NORTH:
			return "north"
		Facing.NORTH_WEST:
			return "north_west"
		Facing.WEST:
			return "west"
		Facing.SOUTH_WEST:
			return "south_west"

	return "south"


func stop_horizontal_movement() -> void:
	velocity.x = 0.0


func stop_all_movement() -> void:
	velocity = Vector2.ZERO


func apply_platformer_horizontal_movement(input_x: float, movement_speed: float) -> void:
	set_platformer_facing_from_input(input_x)
	velocity.x = input_x * movement_speed


func apply_gravity(delta: float, gravity_value := gravity) -> void:
	if is_on_floor() and velocity.y >= 0.0:
		velocity.y = 0.0
	else:
		velocity.y += gravity_value * delta


func move_platformer(delta: float, input_x: float, movement_speed: float) -> void:
	apply_platformer_horizontal_movement(input_x, movement_speed)
	apply_gravity(delta)
	move_and_slide()


func get_iso_screen_movement(input_vector: Vector2) -> Vector2:
	# Converts logical 8-direction input into isometric screen movement.
	# Right/east moves up-right.
	# Left/west moves down-left.
	# Up/north moves up-left.
	# Down/south moves down-right.
	var iso_vector := Vector2(
		input_vector.x - input_vector.y,
		(input_vector.x + input_vector.y) * 0.5
	)

	if iso_vector.length_squared() > 1.0:
		iso_vector = iso_vector.normalized()

	return iso_vector


func move_isometric(input_vector: Vector2, movement_speed: float) -> void:
	set_iso_facing_from_input(input_vector)

	var iso_vector := get_iso_screen_movement(input_vector)

	velocity = iso_vector * movement_speed
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


func get_debug_label_text() -> String:
	if fsm == null or fsm.state == null:
		return "Player: none"

	return "%s" % fsm.state.name

# ###

# (add move_up and move_down in input map)

# ### player_state.gd

# player/states/player_state.gd
class_name PlayerState extends State

# Platformer states
const IDLE = "Idle"
const WALKING = "Walking"
const RUNNING = "Running"
const JUMPING = "Jumping"
const FALLING = "Falling"
const CROUCHING = "Crouching"
const CROUCH_WALKING = "CrouchWalking"
const ROPE_CLIMBING = "RopeClimbing"

# Isometric states
const ISO_IDLE = "IsoIdle"
const ISO_WALKING = "IsoWalking"
const ISO_RUNNING = "IsoRunning"

var player: Player


func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "PlayerState must only be used inside the Player scene.")


func get_input_x() -> float:
	return player.get_platformer_input_x()


func get_iso_input() -> Vector2:
	return player.get_iso_input()


func move_platformer_player(delta: float, animation_name: String, movement_speed: float = -1.0) -> float:
	var input_x := get_input_x()

	if movement_speed < 0.0:
		movement_speed = player.air_speed

	player.move_platformer(delta, input_x, movement_speed)
	player.play_directional_animation(animation_name)

	return input_x


func move_iso_player(animation_name: String, movement_speed: float) -> Vector2:
	var input_vector := get_iso_input()

	player.move_isometric(input_vector, movement_speed)
	player.play_directional_animation(animation_name)

	return input_vector


func get_platformer_grounded_state(input_x: float) -> String:
	if Input.is_action_pressed("crouch"):
		if player.has_platformer_move_input(input_x):
			return CROUCH_WALKING
		return CROUCHING

	if player.has_platformer_move_input(input_x):
		if Input.is_action_pressed("run"):
			return RUNNING
		return WALKING

	return IDLE


func go_to_platformer_grounded_state(input_x: float) -> void:
	finished.emit(get_platformer_grounded_state(input_x))


func get_iso_grounded_state(input_vector: Vector2) -> String:
	if player.has_iso_move_input(input_vector):
		if Input.is_action_pressed("run"):
			return ISO_RUNNING
		return ISO_WALKING

	return ISO_IDLE


func go_to_iso_grounded_state(input_vector: Vector2) -> void:
	finished.emit(get_iso_grounded_state(input_vector))

# (platformer states should use move_platformer_player(). for example:)

  # player/states/walking.gd
extends PlayerState


func enter(_previous_state_path: String, _data := {}) -> void:
	player.play_directional_animation("walking")


func physics_update(delta: float) -> void:
	var input_x := get_input_x()

	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		finished.emit(JUMPING)
		return

	if Input.is_action_pressed("crouch"):
		finished.emit(CROUCH_WALKING)
		return

	if not player.has_platformer_move_input(input_x):
		player.set_platformer_facing_from_input(0.0)
		finished.emit(IDLE)
		return

	if Input.is_action_pressed("run"):
		finished.emit(RUNNING)
		return

	move_platformer_player(delta, "walking", player.walk_speed)

	if not player.is_on_floor():
		finished.emit(FALLING)
		return

# 

# player/states/running.gd
extends PlayerState


func enter(_previous_state_path: String, _data := {}) -> void:
	player.play_directional_animation("running")


func physics_update(delta: float) -> void:
	var input_x := get_input_x()

	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		finished.emit(JUMPING)
		return

	if Input.is_action_pressed("crouch"):
		finished.emit(CROUCH_WALKING)
		return

	if not player.has_platformer_move_input(input_x):
		player.set_platformer_facing_from_input(0.0)
		finished.emit(IDLE)
		return

	if not Input.is_action_pressed("run"):
		finished.emit(WALKING)
		return

	move_platformer_player(delta, "running", player.run_speed)

	if not player.is_on_floor():
		finished.emit(FALLING)
		return

# 

# player/states/crouching.gd
extends PlayerState


func enter(_previous_state_path: String, _data := {}) -> void:
	player.stop_horizontal_movement()
	player.play_directional_animation("crouching")


func physics_update(delta: float) -> void:
	var input_x := get_input_x()

	player.set_platformer_facing_from_input(input_x)

	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		finished.emit(JUMPING)
		return

	if not Input.is_action_pressed("crouch"):
		go_to_platformer_grounded_state(input_x)
		return

	if player.has_platformer_move_input(input_x):
		finished.emit(CROUCH_WALKING)
		return

	player.apply_gravity(delta)
	player.move_and_slide()
	player.play_directional_animation("crouching")

	if not player.is_on_floor():
		finished.emit(FALLING)
		return

# 

# player/states/crouch_walking.gd
extends PlayerState


func enter(_previous_state_path: String, _data := {}) -> void:
	player.play_directional_animation("crouch_walk")


func physics_update(delta: float) -> void:
	var input_x := get_input_x()

	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		finished.emit(JUMPING)
		return

	if not Input.is_action_pressed("crouch"):
		go_to_platformer_grounded_state(input_x)
		return

	if not player.has_platformer_move_input(input_x):
		player.set_platformer_facing_from_input(0.0)
		finished.emit(CROUCHING)
		return

	move_platformer_player(delta, "crouch_walk", player.crouch_walk_speed)

	if not player.is_on_floor():
		finished.emit(FALLING)
		return

# 

# ### jumping.gd becomes

# player/states/jumping.gd
extends PlayerState


func enter(_previous_state_path: String, _data := {}) -> void:
	player.velocity.y = -player.jump_impulse
	player.play_directional_animation("jumping")


func physics_update(delta: float) -> void:
	move_platformer_player(delta, "jumping", player.air_speed)

	if player.velocity.y >= 0.0:
		finished.emit(FALLING)
		return

# ### falling.gs becomes

# player/states/falling.gd
extends PlayerState


func enter(_previous_state_path: String, _data := {}) -> void:
	player.play_directional_animation("falling")


func physics_update(delta: float) -> void:
	var input_x := move_platformer_player(delta, "falling", player.air_speed)

	if player.is_on_floor():
		go_to_platformer_grounded_state(input_x)
		return

# 

# ### (for rope_climbing later)

# player/states/rope_climbing.gd
extends PlayerState

@export var climb_speed := 220.0


func enter(_previous_state_path: String, _data := {}) -> void:
	player.velocity = Vector2.ZERO
	player.facing = Player.Facing.NORTH
	player.play_directional_animation("climbing")


func physics_update(_delta: float) -> void:
	var vertical_input := Input.get_axis("move_up", "move_down")
	var horizontal_input := get_input_x()

	player.velocity = Vector2(0.0, vertical_input * climb_speed)
	player.move_and_slide()

	player.facing = Player.Facing.NORTH

	if not is_equal_approx(vertical_input, 0.0):
		player.play_directional_animation("climbing")
	else:
		player.play_directional_animation("climb_idle")

	if Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
		return

	# Later, replace this with your own rope-detection variable.
	if not Input.is_action_pressed("interact"):
		go_to_platformer_grounded_state(horizontal_input)
		return

# ### isometric part (different states)


# player/states/iso_idle.gd
extends PlayerState


func enter(_previous_state_path: String, _data := {}) -> void:
	player.stop_all_movement()
	player.play_directional_animation("iso_idle")


func physics_update(_delta: float) -> void:
	var input_vector := get_iso_input()

	if player.has_iso_move_input(input_vector):
		player.set_iso_facing_from_input(input_vector)

		if Input.is_action_pressed("run"):
			finished.emit(ISO_RUNNING)
		else:
			finished.emit(ISO_WALKING)

		return

	player.stop_all_movement()
	player.move_and_slide()
	player.play_directional_animation("iso_idle")

# 

# player/states/iso_walking.gd
extends PlayerState


func enter(_previous_state_path: String, _data := {}) -> void:
	player.play_directional_animation("iso_walking")


func physics_update(_delta: float) -> void:
	var input_vector := get_iso_input()

	if not player.has_iso_move_input(input_vector):
		finished.emit(ISO_IDLE)
		return

	if Input.is_action_pressed("run"):
		finished.emit(ISO_RUNNING)
		return

	move_iso_player("iso_walking", player.iso_walk_speed)

# 

# player/states/iso_running.gd
extends PlayerState


func enter(_previous_state_path: String, _data := {}) -> void:
	player.play_directional_animation("iso_running")


func physics_update(_delta: float) -> void:
	var input_vector := get_iso_input()

	if not player.has_iso_move_input(input_vector):
		finished.emit(ISO_IDLE)
		return

	if not Input.is_action_pressed("run"):
		finished.emit(ISO_WALKING)
		return

	move_iso_player("iso_running", player.iso_run_speed)

# 

# ### StateMachine would become

# StateMachine
# ├── Idle
# ├── Walking
# ├── Running
# ├── Jumping
# ├── Falling
# ├── Crouching
# ├── CrouchWalking
# ├── RopeClimbing
# ├── IsoIdle
# ├── IsoWalking
# └── IsoRunning

# Idle            -> idle.gd
# Walking         -> walking.gd
# Running         -> running.gd
# Jumping         -> jumping.gd
# Falling         -> falling.gd
# Crouching       -> crouching.gd
# CrouchWalking   -> crouch_walking.gd
# RopeClimbing    -> rope_climbing.gd
# IsoIdle         -> iso_idle.gd
# IsoWalking      -> iso_walking.gd
# IsoRunning      -> iso_running.gd

# (animation names)

# idle_south
# idle_east
# idle_west

# walking_east
# walking_west

# running_east
# running_west

# jumping_south
# jumping_east
# jumping_west

# falling_south
# falling_east
# falling_west

# crouching_south
# crouching_east
# crouching_west

# crouch_walk_east
# crouch_walk_west

# ##
# isometric animation names

# iso_idle_south
# iso_idle_south_east
# iso_idle_east
# iso_idle_north_east
# iso_idle_north
# iso_idle_north_west
# iso_idle_west
# iso_idle_south_west

# iso_walking_south
# iso_walking_south_east
# iso_walking_east
# iso_walking_north_east
# iso_walking_north
# iso_walking_north_west
# iso_walking_west
# iso_walking_south_west

# iso_running_south
# iso_running_south_east
# iso_running_east
# iso_running_north_east
# iso_running_north
# iso_running_north_west
# iso_running_west
# iso_running_south_west

# #####

# To switch between the two parts of the game, call the state machine transition directly. For example, when entering an isometric area:

$Player/StateMachine._transition_to_next_state("IsoIdle")

# When returning to the platformer area:

$Player/StateMachine._transition_to_next_state("Idle")

# Because _transition_to_next_state() is currently not marked private in a strict way, this works, but I would add a public wrapper to state_machine.gd:

func transition_to(target_state_path: String, data: Dictionary = {}) -> void:
	_transition_to_next_state(target_state_path, data)

# then use:
$Player/StateMachine.transition_to("IsoIdle")

# and
$Player/StateMachine.transition_to("Idle")

# the important setion is this:

Platformer states call:
move_platformer_player(...)

Isometric states call:
move_iso_player(...)

Platformer facing uses:
set_platformer_facing_from_input(input_x)

Isometric facing uses:
set_iso_facing_from_input(input_vector)

