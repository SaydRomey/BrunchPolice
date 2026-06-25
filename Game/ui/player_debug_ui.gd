# ui/player_debug_ui.gd
class_name PlayerDebugUI extends CanvasLayer

@export var player_path: NodePath = ^"../Player"
#@export var state_label_path: NodePath = ^"Label"
@export var debug_label_path: NodePath = ^"Label"
@export var toggle_action := "toggle_debug_ui"
@export var start_visible := true
@export_range(0.0, 1.0, 0.01) var update_interval := 0.1

var player: Player
#var state_label: Label
var debug_label: Label
var _time_until_update := 0.0

func _ready() -> void:
	player = get_node_or_null(player_path) as Player
	#state_label = get_node_or_null(state_label_path) as Label
	#debug_label = get_node_or_null(state_label_path) as Label
	debug_label = get_node_or_null(debug_label_path) as Label
	#assert(player != null, "PlayerDebugUI could not find Player.")
	#assert(state_label != null, "PlayerDebugUI could not find state Label.")
	assert(player != null, "PlayerDebugUI could not find Player at path: %s" % player_path)
	assert(debug_label != null, "PlayerDebugUI could not find Label at path: %s" % debug_label_path)

	if not InputMap.has_action(toggle_action):
		push_warning("Missing InputMap action: " + toggle_action)

	_set_debug_visible(start_visible)

	#if is_instance_valid(player.fsm):
		#player.fsm.state_changed.connect(_on_player_state_changed)
#
	#visible = false
	#_update_state_label()


func _unhandled_input(event: InputEvent) -> void:
	if not InputMap.has_action(toggle_action):
		return

	if event is InputEventKey and event.echo:
		return

	if event.is_action_pressed(toggle_action):
		#visible = not visible
		_set_debug_visible(not visible)
		get_viewport().set_input_as_handled()


func _process(delta: float) -> void:
	if update_interval <= 0.0:
		_update_debug_text()
		return

	_time_until_update -= delta

	if _time_until_update <= 0.0:
		_time_until_update = update_interval
		_update_debug_text()


func _set_debug_visible(enabled: bool) -> void:
	visible = enabled
	set_process(enabled)

	if enabled:
		_time_until_update = 0.0
		_update_debug_text()


func _update_debug_text() -> void:
	if not is_instance_valid(player) or not is_instance_valid(debug_label):
		return

	var state_name := _get_state_name()
	var animation_name := _get_animation_name()
	var facing_name := _get_facing_name()
	var fps := int(round(Engine.get_frames_per_second()))

	debug_label.text = "\n".join([
		"DEBUG",
		"State: %s" % state_name,
		"Animation: %s" % animation_name,
		"Facing: %s (%d)" % [facing_name, player.facing],
		"Position: %s" % _format_vector2(player.global_position),
		"Velocity: %s" % _format_vector2(player.velocity),
		"On Floor: %s" % str(player.is_on_floor()),
		"On Wall: %s" % str(player.is_on_wall()),
		"On Ceiling: %s" % str(player.is_on_ceiling()),
		"Slide Collisions: %s" % _get_collision_summary(),
		"FPS: %d" % fps,
	])


func _get_state_name() -> String:
	if not is_instance_valid(player.fsm):
		return "none"

	if not is_instance_valid(player.fsm.state):
		return "none"

	return player.fsm.state.name


func _get_animation_name() -> String:
	if not is_instance_valid(player.animated_sprite):
		return "none"

	return str(player.animated_sprite.animation)


func _get_facing_name() -> String:
	match player.facing:
		Player.Facing.SOUTH:
			return "south"
		Player.Facing.EAST:
			return "east"
		Player.Facing.WEST:
			return "west"
		Player.Facing.NORTH:
			return "north"
	return "unknown"


func _get_collision_summary() -> String:
	var collision_count := player.get_slide_collision_count()

	if collision_count <= 0:
		return "0"

	var parts := PackedStringArray()

	for i in range(collision_count):
		var collision := player.get_slide_collision(i)

		if collision == null:
			continue

		var collider := collision.get_collider()
		var collider_name := "unknown"

		if collider is Node:
			collider_name = (collider as Node).name

		parts.append("%s normal=%s" % [
			collider_name,
			_format_vector2(collision.get_normal())
		])

	return "%d [%s]" % [collision_count, ", ".join(parts)]


func _format_vector2(value: Vector2) -> String:
	return "(%.1f, %.1f)" % [value.x, value.y]



#func _on_player_state_changed(_previous_state: State, _new_state: State) -> void:
	#_update_state_label()
#
#
#func _update_state_label() -> void:
	#if not is_instance_valid(player):
		#return
#
	#if not is_instance_valid(player.fsm):
		#return
#
	#if not is_instance_valid(player.fsm.state):
		#return
#
	#state_label.text = "State: %s" % player.fsm.state.name
