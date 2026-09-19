extends Node
class_name FootstepSurfaceAudio

@export var audio_player_path: NodePath
@export var default_surface: String = "default"
@export var random_pitch_min: float = 0.92
@export var random_pitch_max: float = 1.08

var surface_sounds: Dictionary = {}
var current_surface: String = "default"
var _audio_player: AudioStreamPlayer

func _ready() -> void:
	_audio_player = get_node_or_null(audio_player_path) as AudioStreamPlayer
	if _audio_player == null:
		_audio_player = AudioStreamPlayer.new()
		add_child(_audio_player)

func register_surface_sound(surface: String, stream: AudioStream) -> void:
	if surface.is_empty() or stream == null:
		return
	if not surface_sounds.has(surface):
		surface_sounds[surface] = []
	(surface_sounds[surface] as Array).append(stream)

func register_surface_sound_path(surface: String, path: String) -> void:
	var stream := load(path) as AudioStream
	register_surface_sound(surface, stream)

func set_surface(surface: String) -> void:
	current_surface = surface if surface_sounds.has(surface) else default_surface

func play_footstep(surface: String = "") -> void:
	var key := surface if not surface.is_empty() else current_surface
	if not surface_sounds.has(key):
		key = default_surface
	if not surface_sounds.has(key):
		return
	var sounds: Array = surface_sounds[key]
	if sounds.is_empty():
		return
	_audio_player.stream = sounds.pick_random()
	_audio_player.pitch_scale = randf_range(random_pitch_min, random_pitch_max)
	_audio_player.play()
