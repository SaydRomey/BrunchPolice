# fsm/state_machine.gd
class_name StateMachine extends Node

## Emitted right after a state transition.
signal state_changed(previous_state: State, new_state: State)

## The initial state of the state machine. If not set, the first child node is used.
@export var initial_state: State = null

## The current state of the state machine.
#@onready var state: State = (func _get_initial_state() -> State:
	#return initial_state if initial_state != null else get_child(0)
#).call()
@onready var state: State = _get_initial_state()


func _get_initial_state() -> State:
	if initial_state != null:
		return initial_state

	var first_child := get_child(0) as State
	assert(first_child != null, "StateMachine needs at least one child State.")
	return first_child


func _ready() -> void:
	# Connect to every state's finished signal to transition to the next state.
	for state_node: State in find_children("*", "State"):
		state_node.finished.connect(_transition_to_next_state)

	# State machines usually access data from the root node of the scene they're part of: the owner.
	# We wait for the owner to be ready to guarantee all the data and nodes the states may need are available.
	await owner.ready
	state.enter("")


func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


func _transition_to_next_state(target_state_path: String, data: Dictionary = {}) -> void:
	if not has_node(target_state_path):
		printerr(owner.name + ": Trying to transition to state " + target_state_path + " but it does not exist.")
		return

	var previous_state := state
	var previous_state_path := state.name

	state.exit()
	state = get_node(target_state_path) as State
	state.enter(previous_state_path, data)

	state_changed.emit(previous_state, state)
