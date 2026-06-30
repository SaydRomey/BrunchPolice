# player/states/player_state.gd
# Boilerplate class to get full autocompletion and type checks for the `player` when coding the player's states.
# Without this, we have to run the game to see typos and other errors the compiler could otherwise catch while scripting.
class_name PlayerState extends State

const IDLE = "Idle"
const WALKING = "Walking"
const RUNNING = "Running"
const JUMPING = "Jumping"
const FALLING = "Falling"
#const GLIDING = "Gliding"
const CROUCHING = "Crouching"
const CROUCH_WALKING = "CrouchWalking"

var player: Player


func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "PlayerState must only be used inside the Player scene.")


func get_input_x() -> float:
	return player.get_move_input()


func move_player(delta: float, animation_name: String, movement_speed: float = -1.0) -> float:
	var input_x := get_input_x()

	if movement_speed < 0.0:
		movement_speed = player.air_speed

	player.move_with_input(delta, input_x, movement_speed)
	player.play_directional_animation(animation_name)

	return input_x


func get_grounded_state(input_x: float) -> String:
	if Input.is_action_pressed("crouch"):
		if player.has_move_input(input_x):
			return CROUCH_WALKING
		return CROUCHING
	if player.has_move_input(input_x):
		if Input.is_action_pressed("run"):
			return RUNNING
		return WALKING
	return IDLE


func go_to_grounded_state(input_x: float) -> void:
	finished.emit(get_grounded_state(input_x))
