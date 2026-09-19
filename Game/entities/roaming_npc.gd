# entities/roaming_npc.gd
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

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var wait_timer: Timer = $WaitTimer
@onready var talk_timer: Timer = $TalkTimer
@onready var name_label: Label = %NameLabel
@onready var dialogue_label: Label = $%DialogueLabel


# NPC States
enum State {
	IDLE,
	MOVING,
	TALKING
}

var current_state := State.IDLE
var state_before_talking := State.IDLE

enum Facing {
	NORTH,
	NORTH_EAST,
	EAST,
	SOUTH_EAST,
	SOUTH,
	SOUTH_WEST,
	WEST,
	NORTH_WEST
}

var facing := Facing.SOUTH

# The Node containing all Marker2D in the Hub
var poi_parent: Node2D


func _ready() -> void:
	dialogue_label.visible = false
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
		_play_idle_animation()
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
	
	_update_facing(direction)
	_play_walk_animation()
	
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
	dialogue_label.visible = true
	velocity = Vector2.ZERO
	
	# Repeated interactions restart the talking duration.
	talk_timer.start(talk_duration)
	
	var phrase: String = dialogues.pick_random()
	print("%s NPC says: %s" % [npc_name, phrase])
	dialogue_label.text="%s" % [phrase]


func _on_talk_timer_timeout() -> void:
	dialogue_label.visible = false
	
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


func _update_facing(direction: Vector2) -> void:
	if direction.is_zero_approx():
		return
	var angle := direction.angle()
	
	# In Godot 2D:
	# right = 0
	# down = PI / 2
	# left = PI or -PI
	# up = -PI / 2
	
	if angle >= -PI / 8.0 and angle < PI / 8.0:
		facing = Facing.EAST
	
	elif angle >= PI / 8.0 and angle < 3.0 * PI / 8.0:
		facing = Facing.SOUTH_EAST
	
	elif angle >= 3.0 * PI / 8.0 and angle < 5.0 * PI / 8.0:
		facing = Facing.SOUTH
	
	elif angle >= 5.0 * PI / 8.0 and angle < 7.0 * PI / 8.0:
		facing = Facing.SOUTH_WEST
	
	elif angle >= 7.0 * PI / 8.0 or angle < -7.0 * PI / 8.0:
		facing = Facing.WEST
	
	elif angle >= -7.0 * PI / 8.0 and angle < -5.0 * PI / 8.0:
		facing = Facing.NORTH_WEST
	
	elif angle >= -5.0 * PI / 8.0 and angle < -3.0 * PI / 8.0:
		facing = Facing.NORTH
	
	else:
		facing = Facing.NORTH_EAST


func _play_walk_animation() -> void:
	match facing:
		Facing.NORTH:
			_play_animation(&"walk_north", false)

		Facing.NORTH_EAST:
			_play_animation(&"walk_north_side", true)

		Facing.EAST:
			_play_animation(&"walk_side", true)

		Facing.SOUTH_EAST:
			_play_animation(&"walk_south_side", true)

		Facing.SOUTH:
			_play_animation(&"walk_south", false)

		Facing.SOUTH_WEST:
			_play_animation(&"walk_south_side", false)

		Facing.WEST:
			_play_animation(&"walk_side", false)

		Facing.NORTH_WEST:
			_play_animation(&"walk_north_side", false)


func _play_idle_animation() -> void:
	match facing:
		Facing.NORTH:
			_play_animation(&"idle_north", false)

		Facing.NORTH_EAST:
			_play_animation(&"idle_north_side", true)

		Facing.EAST:
			_play_animation(&"idle_side", true)

		Facing.SOUTH_EAST:
			_play_animation(&"idle_south_side", true)

		Facing.SOUTH:
			_play_animation(&"idle_south", false)

		Facing.SOUTH_WEST:
			_play_animation(&"idle_south_side", false)

		Facing.WEST:
			_play_animation(&"idle_side", false)

		Facing.NORTH_WEST:
			_play_animation(&"idle_north_side", false)


func _play_animation(
	animation_name: StringName,
	should_flip: bool
) -> void:
	animated_sprite.flip_h = should_flip
	
	if (
		animated_sprite.animation != animation_name
		or not animated_sprite.is_playing()
	):
		animated_sprite.play(animation_name)

