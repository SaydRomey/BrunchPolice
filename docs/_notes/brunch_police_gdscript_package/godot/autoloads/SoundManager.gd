extends Node
class_name SoundManager

signal bgm_started(path: String)
signal bgm_stopped()
signal sfx_played(key: String)

@export_range(0.0, 1.0, 0.01) var music_volume: float = 1.0:
	set(value):
		music_volume = clampf(value, 0.0, 1.0)
		_update_bgm_volume()

@export_range(0.0, 1.0, 0.01) var sfx_volume: float = 1.0

var bgm_player: AudioStreamPlayer
var bgm_loop: bool = true
var bgm_path: String = ""
var sound_effects: Dictionary = {}

func _ready() -> void:
	bgm_player = AudioStreamPlayer.new()
	bgm_player.name = "BGMPlayer"
	add_child(bgm_player)
	bgm_player.finished.connect(_on_bgm_finished)
	_update_bgm_volume()

func set_music_volume(value: float) -> void:
	music_volume = value

func set_sfx_volume(value: float) -> void:
	sfx_volume = clampf(value, 0.0, 1.0)

func play_bgm(path: String, loop: bool = true) -> void:
	var stream := load(path) as AudioStream
	if stream == null:
		push_warning("Failed to load BGM: %s" % path)
		return
	bgm_path = path
	bgm_loop = loop
	bgm_player.stream = stream
	_update_bgm_volume()
	bgm_player.play()
	bgm_started.emit(path)

func stop_bgm() -> void:
	if bgm_player != null:
		bgm_player.stop()
	bgm_stopped.emit()

func preload_sound(key: String, path: String) -> void:
	var stream := load(path) as AudioStream
	if stream == null:
		push_warning("Failed to preload sound: %s" % path)
		return
	sound_effects[key] = stream

func play_sfx(key: String) -> AudioStreamPlayer:
	if not sound_effects.has(key):
		push_warning("Sound effect not found: %s" % key)
		return null
	var player := AudioStreamPlayer.new()
	player.stream = sound_effects[key]
	player.volume_db = linear_to_db(maxf(sfx_volume, 0.001))
	add_child(player)
	player.finished.connect(player.queue_free)
	player.play()
	sfx_played.emit(key)
	return player

func _update_bgm_volume() -> void:
	if bgm_player != null:
		bgm_player.volume_db = linear_to_db(maxf(music_volume, 0.001))

func _on_bgm_finished() -> void:
	if bgm_loop and bgm_player != null and bgm_player.stream != null:
		bgm_player.play()
