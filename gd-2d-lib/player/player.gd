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
@export var walk_speed: float = 175.0
@export var run_speed: float = 260.0
@export var crouch_walk_speed: float = 115.0
@export var air_speed: float = 220.0

@export var jump_impulse: float = 420.0
@export var gravity: float = 1050.0
var _bounce_boost_deadline_ms: int = 0
var _bounce_boost_extra_impulse: float = 0.0

@export var ground_acceleration: float = 1500.0
@export var air_acceleration: float = 1200.0

@export_range(8.0, 400.0, 1.0) 
var max_jump_height_px: float = 95.0


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
@onready var interaction_area: Area2D = $InteractionArea

var checkpoint_position: Vector2
var _surfaces: Dictionary = {}
var _collected_score: int = 0


func _ready() -> void:
	add_to_group("player")
	_ensure_required_input_actions()
	checkpoint_position = global_position

	# Let the StateMachine finish its own _ready() first, then switch to the desired mode.
	await get_tree().process_frame

	if starting_mode == MovementMode.HUB_TOP_DOWN:
		enter_hub_mode()
	else:
		enter_platformer_mode()


#func _physics_process(delta: float) -> void:
	#var speed_factor := 1.0
	#var traction_factor := 1.0
	#for entry in _surfaces.values():
		#speed_factor *= float(entry[0])
		#traction_factor *= float(entry[1])
	#if not is_on_floor():
		#velocity.y += gravity * delta
	#elif Input.is_action_just_pressed("ui_accept"):
		#velocity.y = -jump_impulse
	#var direction := Input.get_axis("ui_left", "ui_right")
	#var target_speed := direction * run_speed * speed_factor
	#var accel := ground_acceleration * traction_factor
	#velocity.x = move_toward(velocity.x, target_speed, accel * delta)
	#move_and_slide()
	#if global_position.y > 800.0:
		#_respawn()


func get_base_jump_impulse() -> float:
	var max_allowed_impulse := sqrt(
		2.0 * maxf(gravity, 1.0) * max_jump_height_px
	)

	return minf(
		absf(jump_impulse),
		max_allowed_impulse
	)


func get_jump_impulse() -> float:
	var multiplier: float = 1.0

	if is_on_floor():
		for entry in _surfaces.values():
			if entry.size() >= 3:
				multiplier *= float(entry[2])

	multiplier = clampf(multiplier, 0.1, 2.0)
	
	print("Jump multiplier: ", multiplier) # Debug

	return get_base_jump_impulse() * multiplier


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

# modifiers.x represents maximum horizontal speed, 
# while modifiers.y represents traction.
# If multiple zones overlap, their multipliers combine, 
# with limits to prevent extreme values
func get_surface_modifiers() -> Vector2:
	var modifiers := Vector2.ONE

	for entry in _surfaces.values():
		modifiers.x *= float(entry[0])
		modifiers.y *= float(entry[1])

	modifiers.x = clampf(modifiers.x, 0.1, 2.0)
	modifiers.y = clampf(modifiers.y, 0.05, 2.0)

	return modifiers


#func apply_platformer_horizontal_movement(input_x: float, movement_speed: float) -> void:
	#set_platformer_facing_from_input(input_x)
	#velocity.x = movement_speed * input_x

func apply_platformer_horizontal_movement(
	input_x: float,
	movement_speed: float,
	delta: float
) -> void:

	if not is_zero_approx(input_x):
		set_platformer_facing_from_input(input_x)

	var modifiers := Vector2.ONE
	var acceleration := air_acceleration

	if is_on_floor():
		modifiers = get_surface_modifiers()
		acceleration = ground_acceleration

	var target_velocity_x := (
		input_x * movement_speed * modifiers.x
	)

	acceleration *= modifiers.y

	velocity.x = move_toward(
		velocity.x,
		target_velocity_x,
		maxf(acceleration, 0.0) * delta
	)


func apply_gravity(delta: float, gravity_value := gravity) -> void:
	if is_on_floor() and velocity.y >= 0.0:
		velocity.y = 0.0
	else:
		velocity.y += gravity_value * delta


func move_platformer(delta: float, input_x: float, movement_speed: float) -> void:
	apply_platformer_horizontal_movement(
		input_x, 
		movement_speed, 
		delta)
	
	apply_gravity(delta)
	move_and_slide()
	
	if global_position.y > 800.0:
		_respawn()


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


# -----------------------------------------------------------------------------
# Interaction helper
# -----------------------------------------------------------------------------

func _unhandled_input(event: InputEvent) -> void:
	var viewport := get_viewport()

	# Timed bounce input has priority.
	if try_bounce_boost(event):
		if viewport != null:
			viewport.set_input_as_handled()
		return

	if not event.is_action_pressed(&"interact"):
		return
	
	if viewport != null:
		viewport.set_input_as_handled()
	
	_try_interact()


func _try_interact() -> void:
	# Gather all the zones (NPCs) in the InteractionArea of the player
	for area: Area2D in interaction_area.get_overlapping_areas():
		var target: Node = area

		if not target.has_method(&"interact"):
			target = area.get_parent()
		
		# If the zone has an 'interact' method (It's an NPC)
		if target != null and target.has_method(&"interact"):
			target.call(&"interact")
			return # We interact with only one NPC at a time


# -----------------------------------------------------------------------------
# le_elements_kit demo test
# -----------------------------------------------------------------------------

func apply_launch(new_velocity: Vector2) -> void:
	if movement_mode == MovementMode.HUB_TOP_DOWN:
		return
	
	velocity = new_velocity
	
	print("BOUNCE PAD: ", new_velocity.y) # Debug
	
	if fsm != null and fsm.state != null:
		if fsm.state.name != "Falling":
			fsm.transition_to("Falling")


func start_bounce_boost_window(
	window_seconds: float,
	extra_impulse: float
) -> void:
	# Replace any previous bounce opportunity.
	clear_bounce_boost()

	if window_seconds <= 0.0 or extra_impulse <= 0.0:
		return

	_bounce_boost_extra_impulse = extra_impulse
	_bounce_boost_deadline_ms = (
		Time.get_ticks_msec()
		+ int(round(window_seconds * 1000.0))
	)

	print("BOUNCE WINDOW OPEN") # Debug


func clear_bounce_boost() -> void:
	_bounce_boost_deadline_ms = 0
	_bounce_boost_extra_impulse = 0.0


func try_bounce_boost(event: InputEvent) -> bool:
	# Only a new Jump press counts, not a held key.
	if not event.is_action_pressed(&"jump"):
		return false

	if _bounce_boost_deadline_ms == 0:
		return false

	# Reject late input.
	if Time.get_ticks_msec() > _bounce_boost_deadline_ms:
		clear_bounce_boost()
		return false

	# Only boost while rising in platformer mode.
	if movement_mode != MovementMode.PLATFORMER:
		clear_bounce_boost()
		return false

	if velocity.y >= 0.0:
		clear_bounce_boost()
		return false

	# Add upward speed without resetting the whole bounce.
	velocity.y -= _bounce_boost_extra_impulse

	# Consume this opportunity: only one boost per contact.
	clear_bounce_boost()

	print("PERFECT BOUNCE BOOST!") # Debug
	return true


func receive_damage(_damage: int, _source: Vector2) -> void:
	_respawn()

func set_checkpoint(new_position: Vector2) -> void:
	checkpoint_position = new_position

func enter_surface(
	token: int, 
	speed_factor: float, 
	traction_factor: float,
	jump_factor: float = 1.0
) -> void:
	
	_surfaces[token] = [
		speed_factor, 
		traction_factor, 
		jump_factor
	]
	print("SURFACE ENTER: ", speed_factor, ", ", traction_factor, ", ", jump_factor) # Debug

func exit_surface(token: int) -> void:
	_surfaces.erase(token)
	print("SURFACE EXIT") # Debug

func _respawn() -> void:
	clear_bounce_boost()
	
	global_position = checkpoint_position
	velocity = Vector2.ZERO
	_surfaces.clear()

func add_score(value: int) -> void:
	_collected_score += value
	print("Demo score: ", _collected_score)
