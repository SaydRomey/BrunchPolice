# player/states/player_state.gd
# Boilerplate class to get full autocompletion and type checks for the `player` when coding the player's states.
# Without this, we have to run the game to see typos and other errors the compiler could otherwise catch while scripting.
class_name PlayerState extends State

const IDLE = "Idle"
const RUNNING = "Running"
const JUMPING = "Jumping"
const FALLING = "Falling"
#const GLIDING = "Gliding"
#const CROUNCHING = "crouching" # ?
#const CROUCH_WALKING = "crouch_walking" # ?

var player: Player


func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "PlayerState must only be used inside the Player scene.")


func get_input_x() -> float:
	return player.get_move_input()


func move_player(delta: float, animation_name: String) -> float:
	var input_x := get_input_x()

	player.move_with_input(delta, input_x)
	player.play_directional_animation(animation_name)

	return input_x


func go_to_grounded_state(input_x: float) -> void:
	if player.has_move_input(input_x):
		finished.emit(RUNNING)
	else:
		finished.emit(IDLE)
