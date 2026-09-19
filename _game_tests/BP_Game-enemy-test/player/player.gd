# player/player.gd
class_name Player extends CharacterBody2D


enum MovementMode {
	PLATFORMER,
	HUB_TOP_DOWN
}

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

@export_category("Mode")
@export var starting_mode: MovementMode = MovementMode.PLATFORMER

@export_category("Platformer Movement")
@export var walk_speed := 300.0
@export var run_speed := 500.0
@export var crouch_walk_speed := 150.0
@export var air_speed := 500.0
@export var gravity := 4000.0
@export var jump_impulse := 1800.0

@export_category("Hub Top-Down Movement")
@export var hub_walk_speed := 220.0
@export var hub_run_speed := 360.0

@export_category("Glide")
@export var glide_max_speed := 1000.0
@export var glide_acceleration := 1000.0
@export var glide_gravity := 400.0
@export var glide_jump_impulse := 800.0

var movement_mode: MovementMode = MovementMode.PLATFORMER
var facing: Facing = Facing.SOUTH

@onready var fsm: StateMachine = $StateMachine
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	add_to_group("player")
	_ensure_required_input_actions()

	# Let the StateMachine finish its own _ready() first, then switch to the desired mode.
	await get_tree().process_frame

	if starting_mode == MovementMode.HUB_TOP_DOWN:
		enter_hub_mode()
	else:
		enter_platformer_mode()


func enter_platformer_mode() -> void:
	movement_mode = MovementMode.PLATFORMER
	velocity = Vector2.ZERO
	facing = Facing.SOUTH
	fsm.transition_to("Idle")


func enter_hub_mode() -> void:
	movement_mode = MovementMode.HUB_TOP_DOWN
	velocity = Vector2.ZERO
	facing = Facing.SOUTH
	fsm.transition_to("HubIdle")


func _ensure_required_input_actions() -> void:
	_ensure_key_action(&"move_left", [KEY_LEFT, KEY_A])
	_ensure_key_action(&"move_right", [KEY_RIGHT, KEY_D])
	_ensure_key_action(&"move_up", [KEY_UP, KEY_W])
	_ensure_key_action(&"move_down", [KEY_DOWN, KEY_S])
	_ensure_key_action(&"jump", [KEY_SPACE])
	_ensure_key_action(&"run", [KEY_SHIFT])
	_ensure_key_action(&"crouch", [KEY_DOWN, KEY_S])
	_ensure_key_action(&"interact", [KEY_E])


func _ensure_key_action(action_name: StringName, physical_keycodes: Array[int]) -> void:
	if not InputMap.has_action(action_name):
		InputMap.add_action(action_name)

	if not InputMap.action_get_events(action_name).is_empty():
		return

	for physical_keycode in physical_keycodes:
		var event := InputEventKey.new()
		event.physical_keycode = physical_keycode
		InputMap.action_add_event(action_name, event)


# -----------------------------------------------------------------------------
# Input helpers
# -----------------------------------------------------------------------------

func get_platformer_input_x() -> float:
	return Input.get_axis("move_left", "move_right")


func get_top_down_input() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")


func has_platformer_move_input(input_x: float) -> bool:
	return not is_equal_approx(input_x, 0.0)


func has_top_down_move_input(input_vector: Vector2) -> bool:
	return input_vector.length_squared() > 0.0


# Backward-compatible aliases for your existing platformer states/debug code.
func get_move_input() -> float:
	return get_platformer_input_x()


func has_move_input(input_x: float) -> bool:
	return has_platformer_move_input(input_x)


# -----------------------------------------------------------------------------
# Facing helpers
# -----------------------------------------------------------------------------

func set_platformer_facing_from_input(input_x: float) -> void:
	if input_x > 0.0:
		facing = Facing.EAST
	elif input_x < 0.0:
		facing = Facing.WEST
	else:
		facing = Facing.SOUTH


func set_top_down_facing_from_input(input_vector: Vector2) -> void:
	if not has_top_down_move_input(input_vector):
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


# Backward-compatible alias for platformer states.
func set_facing_from_input(input_x: float) -> void:
	set_platformer_facing_from_input(input_x)


func get_facing_suffix() -> String:
	return get_facing_suffixes()[0]


func get_facing_suffixes() -> Array[String]:
	match facing:
		Facing.SOUTH:
			return ["south"]
		Facing.SOUTH_EAST:
			return ["south_east", "east", "south"]
		Facing.EAST:
			return ["east"]
		Facing.NORTH_EAST:
			return ["north_east", "east", "north"]
		Facing.NORTH:
			return ["north"]
		Facing.NORTH_WEST:
			return ["north_west", "west", "north"]
		Facing.WEST:
			return ["west"]
		Facing.SOUTH_WEST:
			return ["south_west", "west", "south"]

	return ["south"]


# -----------------------------------------------------------------------------
# Movement helpers
# -----------------------------------------------------------------------------

func stop_horizontal_movement() -> void:
	velocity.x = 0.0


func stop_all_movement() -> void:
	velocity = Vector2.ZERO


func apply_platformer_horizontal_movement(input_x: float, movement_speed: float) -> void:
	set_platformer_facing_from_input(input_x)
	velocity.x = movement_speed * input_x


func apply_gravity(delta: float, gravity_value := gravity) -> void:
	if is_on_floor() and velocity.y >= 0.0:
		velocity.y = 0.0
	else:
		velocity.y += gravity_value * delta


func move_platformer(delta: float, input_x: float, movement_speed: float) -> void:
	apply_platformer_horizontal_movement(input_x, movement_speed)
	apply_gravity(delta)
	move_and_slide()


# Backward-compatible alias for your older platformer states.
func move_with_input(delta: float, input_x: float, movement_speed: float) -> void:
	move_platformer(delta, input_x, movement_speed)


func move_top_down(input_vector: Vector2, movement_speed: float) -> void:
	set_top_down_facing_from_input(input_vector)

	var move_vector := input_vector
	if move_vector.length_squared() > 1.0:
		move_vector = move_vector.normalized()

	velocity = move_vector * movement_speed
	move_and_slide()


# -----------------------------------------------------------------------------
# Animation helper
# -----------------------------------------------------------------------------

func play_directional_animation(base_name: String) -> void:
	if animated_sprite.sprite_frames == null:
		push_warning("AnimatedSprite2D has no SpriteFrames resource.")
		return

	# First try the exact requested base. Then fall back to idle for missing
	# top-down north/south walking/running animations while your art is incomplete.
	var base_names: Array[String] = [base_name]
	if base_name == "walking" or base_name == "running":
		base_names.append("idle")
	elif base_name == "crouch_walking":
		base_names.append("crouching")

	for candidate_base in base_names:
		for suffix in get_facing_suffixes():
			var animation_name := "%s_%s" % [candidate_base, suffix]

			if animated_sprite.sprite_frames.has_animation(animation_name):
				if animated_sprite.animation != animation_name:
					animated_sprite.play(animation_name)
				elif not animated_sprite.is_playing():
					animated_sprite.play()

				return

	push_warning("Missing animation for base '%s' and facing '%s'." % [base_name, str(facing)])
