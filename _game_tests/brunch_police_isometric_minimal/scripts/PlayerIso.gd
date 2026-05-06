extends CharacterBody2D

signal clue_collected(total: int)
signal player_respawned

@export var walk_speed: float = 175.0
@export var sprint_speed: float = 285.0
@export var acceleration: float = 12.0

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var interact_area: Area2D = $InteractArea

var spawn_position := Vector2.ZERO
var collected_clues := 0
var facing := Vector2(1, 1)

func _ready() -> void:
	spawn_position = global_position
	_build_sprite_frames()
	anim.play("idle")
	z_as_relative = false

func _physics_process(delta: float) -> void:
	var raw := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	var desired := Vector2.ZERO
	if raw.length() > 0.01:
		raw = raw.normalized()
		# Convert cardinal input into isometric screen movement.
		desired = Vector2(raw.x - raw.y, (raw.x + raw.y) * 0.5).normalized()
		facing = raw
	var target_speed := sprint_speed if Input.is_action_pressed("sprint") else walk_speed
	velocity = velocity.lerp(desired * target_speed, clamp(acceleration * delta, 0.0, 1.0))
	move_and_slide()
	_update_animation(raw)
	z_index = int(global_position.y)

func add_clue() -> void:
	collected_clues += 1
	clue_collected.emit(collected_clues)

func respawn() -> void:
	global_position = spawn_position
	velocity = Vector2.ZERO
	player_respawned.emit()

func _update_animation(raw: Vector2) -> void:
	if raw.length() > 0.01:
		anim.flip_h = raw.x < 0.0 or raw.y < 0.0
		if Input.is_action_pressed("sprint"):
			anim.play("sprint")
		else:
			anim.play("walk")
	else:
		anim.play("idle")

func _build_sprite_frames() -> void:
	var frames := SpriteFrames.new()
	_add_sheet_animation(frames, "idle", "res://assets/player/Iso_Idle.png", 4, 7.0, true)
	_add_sheet_animation(frames, "walk", "res://assets/player/Iso_Walk.png", 8, 10.0, true)
	_add_sheet_animation(frames, "sprint", "res://assets/player/Iso_Sprint.png", 8, 14.0, true)
	_add_sheet_animation(frames, "jump", "res://assets/player/Iso_Jump.png", 5, 9.0, false)
	_add_sheet_animation(frames, "land", "res://assets/player/Iso_Land.png", 4, 10.0, false)
	anim.sprite_frames = frames

func _add_sheet_animation(frames: SpriteFrames, anim_name: StringName, path: String, count: int, fps: float, loop: bool) -> void:
	frames.add_animation(anim_name)
	frames.set_animation_speed(anim_name, fps)
	frames.set_animation_loop(anim_name, loop)
	var texture := load(path) as Texture2D
	for i in count:
		var atlas := AtlasTexture.new()
		atlas.atlas = texture
		atlas.region = Rect2(i * 128, 0, 128, 128)
		frames.add_frame(anim_name, atlas)
