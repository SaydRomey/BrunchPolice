extends AudioStreamPlayer2D
class_name DynamicSoundEffect

@export var listener_path: NodePath
@export var max_distance: float = 500.0
@export var base_volume_linear: float = 1.0
@export var update_every_frame: bool = true
@export var randomize_pitch_on_play: bool = false
@export var pitch_min: float = 0.9
@export var pitch_max: float = 1.1

var listener: Node2D

func _ready() -> void:
	if not listener_path.is_empty():
		listener = get_node_or_null(listener_path) as Node2D
	if listener == null:
		var players := get_tree().get_nodes_in_group("player")
		if not players.is_empty():
			listener = players[0] as Node2D

func _process(_delta: float) -> void:
	if update_every_frame:
		update_volume()

func set_listener(node: Node2D) -> void:
	listener = node

func set_max_distance(distance: float) -> void:
	max_distance = maxf(1.0, distance)

func update_volume() -> void:
	if listener == null:
		return
	var distance := global_position.distance_to(listener.global_position)
	var normalized := clampf(1.0 - (distance / max_distance), 0.0, 1.0)
	var linear_volume := maxf(0.0001, base_volume_linear * normalized)
	volume_db = linear_to_db(linear_volume)

func play_dynamic(from_position: float = 0.0) -> void:
	if randomize_pitch_on_play:
		pitch_scale = randf_range(pitch_min, pitch_max)
	update_volume()
	play(from_position)
