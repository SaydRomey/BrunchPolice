extends CharacterBody2D

signal clue_collected(total: int)
signal player_respawned

@export var walk_speed: float = 260.0
@export var sprint_speed: float = 420.0
@export var jump_velocity: float = -560.0
#@export var gravity: float = 1550.0
@export var gravity: float = 1050.0
@export var coyote_time: float = 0.10
@export var jump_buffer_time: float = 0.12

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var _coyote_timer := 0.0
var _jump_buffer_timer := 0.0
var _was_on_floor := false
var _collected_clues := 0
var spawn_position := Vector2.ZERO

func _ready() -> void:
	spawn_position = global_position
	_build_sprite_frames()
	anim.play("idle")

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	var target_speed := sprint_speed if Input.is_action_pressed("sprint") else walk_speed
	velocity.x = move_toward(velocity.x, direction * target_speed, target_speed * 9.0 * delta)

	if is_on_floor():
		_coyote_timer = coyote_time
	else:
		_coyote_timer -= delta
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump"):
		_jump_buffer_timer = jump_buffer_time
	else:
		_jump_buffer_timer -= delta

	if _jump_buffer_timer > 0.0 and _coyote_timer > 0.0:
		velocity.y = jump_velocity
		_jump_buffer_timer = 0.0
		_coyote_timer = 0.0

	move_and_slide()
	_update_animation(direction)

	if global_position.y > 1050.0:
		_respawn()

	_was_on_floor = is_on_floor()

func add_clue() -> void:
	_collected_clues += 1
	clue_collected.emit(_collected_clues)

func _respawn() -> void:
	global_position = spawn_position
	velocity = Vector2.ZERO
	player_respawned.emit()

func _update_animation(direction: float) -> void:
	if abs(direction) > 0.01:
		anim.flip_h = direction < 0.0

	if not is_on_floor():
		anim.play("jump")
		return

	if not _was_on_floor and velocity.y >= 0.0:
		anim.play("land")
		return

	if abs(velocity.x) > 320.0:
		anim.play("sprint")
	elif abs(velocity.x) > 20.0:
		anim.play("walk")
	else:
		anim.play("idle")

func _build_sprite_frames() -> void:
	var frames := SpriteFrames.new()
	_add_sheet_animation(frames, "idle", "res://assets/player/Idle.png", 4, 7.0, true)
	_add_sheet_animation(frames, "walk", "res://assets/player/Walk.png", 8, 10.0, true)
	_add_sheet_animation(frames, "sprint", "res://assets/player/Sprint.png", 8, 14.0, true)
	_add_sheet_animation(frames, "jump", "res://assets/player/Jump.png", 5, 9.0, false)
	_add_sheet_animation(frames, "land", "res://assets/player/Land.png", 4, 10.0, false)
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
