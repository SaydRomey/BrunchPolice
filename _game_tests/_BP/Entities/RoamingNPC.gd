# Entities/RoamingNPC.gd
extends CharacterBody2D

@export var speed: float = 100.0
@export var npc_type: String = "RoamingNPC"
@export var npc_name: String = ""
@export var dialogues: Array[String] = [
	"Hello !",
	"This place is great.",
	"Miam."
]
@export var talk_duration: float = 3.0

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var wait_timer: Timer = $WaitTimer
@onready var talk_timer: Timer = $TalkTimer
@onready var name_label: Label = %NameLabel

# NPC States
enum State {
	IDLE,
	MOVING,
	TALKING
}

var current_state := State.IDLE
var state_before_talking := State.IDLE

# The Node containing all Marker2D in the Hub
var poi_parent: Node2D


func _ready() -> void:
	name_label.text = npc_name if npc_name else npc_type
	
	# At launch, look for the first node with "poi_zone" tag
	poi_parent = get_tree().get_first_node_in_group(
		&"poi_zone"
	) as Node2D
	
	if poi_parent == null:
		push_warning(
			"%s could not find the poi_zone group."
			% name
		)
	
	# (These can also be enabled in the Inspector)
	wait_timer.one_shot = true
	talk_timer.one_shot = true
	
	# Connect each signal exactly once
	#wait_timer.timeout.connect(_on_wait_timer_timeout)
	#talk_timer.timeout.connect(_on_talk_timer_timeout)
	
	# Start small random delay before the NPC can choose it's first destination
	start_waiting(randf_range(1.0, 3.0))


func _physics_process(_delta: float) -> void:
	if current_state != State.MOVING:
		velocity = Vector2.ZERO
		return
	
	# If we have arrived at the destination
	if nav_agent.is_navigation_finished():
		start_waiting(randf_range(3.0, 8.0)) # Pause of 3 to 8 secondes
		return
	
	# Calculate the target and direction towards the next point of the trajectory
	var next_path_position: Vector2 = (
		nav_agent.get_next_path_position()
	)
	var direction: Vector2 = global_position.direction_to(
		next_path_position
	)
	# Move
	velocity = direction * speed
	
	# move_and_slide() handles collisions automatically.
	# If the player is on the trajectory, the NPC will bumb against him without pushing him violently
	# (while the player is also a CharacterBody2D).
	move_and_slide()


func start_waiting(duration: float) -> void:
	current_state = State.IDLE
	velocity = Vector2.ZERO # Stop moving
	wait_timer.start(duration)


func _on_wait_timer_timeout() -> void:
	# This guard prevents an old timeout from interrupting dialogue.
	if current_state != State.IDLE:
		return
	choose_new_destination()


func choose_new_destination() -> void:
	#if not poi_parent or poi_parent.get_child_count() == 0:
		#return # no points defined
	if poi_parent == null:
		start_waiting(1.0)
		return
	if poi_parent.get_child_count() == 0:
		push_warning("The POI container contains no Marker2D nodes.")
		start_waiting(1.0)
		return
	
	# Choose a Marker2D randomly
	var selected_node: Node = poi_parent.get_children().pick_random()
	var selected_marker := selected_node as Marker2D
	
	if selected_marker == null:
		push_warning(
			"All children of the POI container should be Marker2D nodes."
		)
		start_waiting(1.0)
		return
	
	# Assign the target to the NavigationAgent
	nav_agent.target_position = selected_marker.global_position
	current_state = State.MOVING


# Fonction called by PlayerHub when he presses 'E' (interact)
func interact() -> void:
	if dialogues.is_empty():
		push_warning("%s has no dialogue lines." % npc_name)
		return
	
	# Do not replace the saved state when the player interacts
	# repeateadly during the same conversation
	if current_state != State.TALKING:
		state_before_talking = current_state
	
	# Stop an idle timer so it cannot choose a destination during dialogue
	wait_timer.stop()
	
	current_state = State.TALKING
	velocity = Vector2.ZERO
	
	# Repeated interactions restart the talking duration.
	talk_timer.start(talk_duration)
	
	var phrase: String = dialogues.pick_random()
	print("%s NPC says: %s" % [npc_name, phrase])


func _on_talk_timer_timeout() -> void:
	# Resume the previous destination if the NPC was walking
	if (
		state_before_talking == State.MOVING
		and not nav_agent.is_navigation_finished()
	):
		current_state = State.MOVING
		return
	
	# If the NPC was idle, or its destination was reached,
	# wait briefly before choosing another destination
	start_waiting(randf_range(1.0, 3.0))
