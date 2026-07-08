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

# Hub top-down states
const HUB_IDLE = "HubIdle"
const HUB_WALKING = "HubWalking"
const HUB_RUNNING = "HubRunning"
const HUB_INSPECTING = "HubInspecting"

var player: Player


func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "PlayerState must only be used inside the Player scene.")


func get_input_x() -> float:
	return player.get_platformer_input_x()


func get_top_down_input() -> Vector2:
	return player.get_top_down_input()


func move_platformer_player(delta: float, animation_name: String, movement_speed: float = -1.0) -> float:
	var input_x := get_input_x()

	if movement_speed < 0.0:
		movement_speed = player.air_speed

	player.move_platformer(delta, input_x, movement_speed)
	player.play_directional_animation(animation_name)

	return input_x


func move_top_down_player(animation_name: String, movement_speed: float) -> Vector2:
	var input_vector := get_top_down_input()

	player.move_top_down(input_vector, movement_speed)
	player.play_directional_animation(animation_name)

	return input_vector


# Backward-compatible alias for older platformer states.
func move_player(delta: float, animation_name: String, movement_speed: float = -1.0) -> float:
	return move_platformer_player(delta, animation_name, movement_speed)


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


# Backward-compatible alias for current Falling/Crouching scripts.
func go_to_grounded_state(input_x: float) -> void:
	go_to_platformer_grounded_state(input_x)


func get_hub_grounded_state(input_vector: Vector2) -> String:
	if player.has_top_down_move_input(input_vector):
		if Input.is_action_pressed("run"):
			return HUB_RUNNING
		return HUB_WALKING

	return HUB_IDLE


func go_to_hub_grounded_state(input_vector: Vector2) -> void:
	finished.emit(get_hub_grounded_state(input_vector))
