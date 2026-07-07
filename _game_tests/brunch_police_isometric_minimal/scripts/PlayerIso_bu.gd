# scripts/PlayerIso.gd
#
# Isometric player controller for Godot 4.
#
# Main goals of this script:
# 1. Read WASD / arrow-key input as movement on an isometric floor.
# 2. Convert that input into screen-space velocity for CharacterBody2D.
# 3. Pick one of 8 directional animations for idle, walk, and run.
# 4. Normalize sprite frames so differently-sized sprite sheets do not make
#    AnimatedSprite2D appear to slide, jump, or change position.
#
# Important idea:
# AnimatedSprite2D draws every frame using that frame texture's size and center.
# If idle frames are 82x107 but walk/run frames are 112x146, the visual center
# changes when the animation changes. That is why the sprite can look like it
# slides even when the CharacterBody2D is not moving.
#
# This script fixes that by copying every source frame into a same-sized
# transparent canvas before adding it to SpriteFrames. The final drawn frame is
# always 112x146, even when the original idle sheet cells are only 82x107.

extends CharacterBody2D

signal clue_collected(total: int)
signal player_respawned

# -----------------------------------------------------------------------------
# Movement tuning
# -----------------------------------------------------------------------------

@export var walk_speed: float = 175.0
@export var run_speed: float = 285.0

# Higher value means the player reaches the target velocity faster.
# This is not pixels-per-second; it is used as a lerp strength multiplier.
@export var acceleration: float = 12.0

# -----------------------------------------------------------------------------
# Sprite sheet paths
# -----------------------------------------------------------------------------
# These should point to the PNGs in your Godot project.
#
# Your uploaded sheets currently appear to be:
# - idle: 2048x854, visually laid out as 25 columns x 8 rows, source cell 82x107
# - walk: 896x1168, exactly 8 columns x 8 rows, source cell 112x146
# - run: 1792x1168, exactly 16 columns x 8 rows, source cell 112x146
#
# The idle sheet is 2 pixels smaller than a perfect 25*82 by 8*107 grid
# because 25*82 = 2050 and 8*107 = 856. That crop mismatch is one reason idle
# splicing can look wrong if you treat the image as a perfect grid without
# padding or normalization.

@export_file("*.png") var idle_sheet_path: String = "res://assets/base_char_iso/iso_idle.png"
@export_file("*.png") var walk_sheet_path: String = "res://assets/base_char_iso/iso_walk.png"
@export_file("*.png") var run_sheet_path: String = "res://assets/base_char_iso/iso_run.png"

# -----------------------------------------------------------------------------
# Source crop sizes
# -----------------------------------------------------------------------------
# These are the sizes of ONE CELL in the source PNG.
# They answer: "How big is the rectangle I cut out of the sheet?"
#
# Do not use these to decide how large the final sprite should draw on screen.
# The final drawn size is controlled by draw_frame_size below.

@export var idle_source_frame_size: Vector2i = Vector2i(82, 107)
@export var walk_source_frame_size: Vector2i = Vector2i(112, 146)
@export var run_source_frame_size: Vector2i = Vector2i(112, 146)

@export var idle_frames_per_direction: int = 25
@export var walk_frames_per_direction: int = 8
@export var run_frames_per_direction: int = 16

# -----------------------------------------------------------------------------
# Final drawn frame size
# -----------------------------------------------------------------------------
# Every animation frame is copied into this same transparent canvas size before
# being added to SpriteFrames.
#
# This is the main fix for your idle sliding / size mismatch problem.
# Walk and run already use 112x146 cells, so 112x146 is a good final size.
# Idle uses smaller 82x107 cells, so those are padded into this 112x146 canvas.

@export var draw_frame_size: Vector2i = Vector2i(112, 146)

# Where the cropped source frame is pasted inside the final 112x146 canvas.
#
# For idle:
#   source is 82x107
#   final is 112x146
#   x padding = (112 - 82) / 2 = 15
#   y padding = 146 - 107 = 39
#
# That puts idle centered horizontally and bottom-aligned vertically. Bottom
# alignment matters in isometric games because the player's feet should stay on
# the same ground point while the body/head animates above it.
#
# Walk/run are already 112x146, so their paste offset is zero.

@export var idle_draw_offset: Vector2i = Vector2i(15, 39)
@export var walk_draw_offset: Vector2i = Vector2i(0, 0)
@export var run_draw_offset: Vector2i = Vector2i(0, 0)

# -----------------------------------------------------------------------------
# Animation playback speeds
# -----------------------------------------------------------------------------

@export var idle_fps: float = 7.0
@export var walk_fps: float = 10.0
@export var run_fps: float = 14.0

# -----------------------------------------------------------------------------
# Visual placement of the AnimatedSprite2D node
# -----------------------------------------------------------------------------
# CharacterBody2D's origin should represent the player's feet on the floor.
# With a 112x146 centered sprite, the bottom of the sprite is 73px below its
# center. Placing AnimatedSprite2D at y = -73 means the bottom of the sprite
# lands at the CharacterBody2D origin.
#
# If the feet appear too high or too low on the floor, adjust this value in the
# Inspector. Do not compensate by changing collision shapes or z_index logic.

@export var sprite_node_offset: Vector2 = Vector2(0, -73)

# -----------------------------------------------------------------------------
# Child nodes
# -----------------------------------------------------------------------------

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var interact_area: Area2D = $InteractArea

# -----------------------------------------------------------------------------
# Direction tables
# -----------------------------------------------------------------------------
# DIRS_BY_ROW maps sprite sheet row index to animation direction.
# You said you fixed the directions because they were inverted. Keep this row
# order if it matches your current sheets.
#
# Row 0 -> nw
# Row 1 -> w
# Row 2 -> sw
# Row 3 -> s
# Row 4 -> se
# Row 5 -> e
# Row 6 -> ne
# Row 7 -> n
#
# If a direction is wrong, fix this table only. Do not flip the sprite.
# The sheet already has all 8 directions.

const DIRS_BY_ROW: Array[String] = ["nw", "w", "sw", "s", "se", "e", "ne", "n"]

# This table converts a screen-space angle into one of the 8 direction names.
# atan2() returns 0 when pointing right/east, then increases clockwise/downward
# in Godot screen coordinates.
const DIRS_CLOCKWISE: Array[String] = ["e", "se", "s", "sw", "w", "nw", "n", "ne"]

# -----------------------------------------------------------------------------
# Runtime state
# -----------------------------------------------------------------------------

var spawn_position: Vector2 = Vector2.ZERO
var collected_clues: int = 0

# Last direction the player intentionally moved/faced.
# Idle animation uses this direction so the character keeps facing the same way
# after movement stops.
var facing_dir: String = "se"

func _ready() -> void:
	spawn_position = global_position

	# z_index is set manually from global_position.y. Setting z_as_relative to
	# false makes the number absolute instead of relative to the parent node.
	z_as_relative = false

	# For pixel art, make sure your PNG import settings also have Filter disabled.
	# This line only affects the runtime node; import settings still matter.
	anim.flip_h = false
	anim.centered = true
	anim.position = sprite_node_offset

	# Build all SpriteFrames in code so the .tscn does not need manually-spliced
	# animations. This also guarantees the runtime frame sizes are normalized.
	_build_sprite_frames()

	_play_state("idle")

func _physics_process(delta: float) -> void:
	# -------------------------------------------------------------------------
	# 1. Read input in grid/cardinal space.
	# -------------------------------------------------------------------------
	# input_vec.x:
	#   -1 means left, +1 means right
	# input_vec.y:
	#   -1 means up,   +1 means down
	#
	# These are logical directions, not final screen pixels yet.

	var input_vec: Vector2 = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)

	# Prevent diagonal input from being faster than straight input.
	if input_vec.length_squared() > 1.0:
		input_vec = input_vec.normalized()

	var moving: bool = input_vec.length_squared() > 0.001
	var screen_vec: Vector2 = Vector2.ZERO

	if moving:
		# ---------------------------------------------------------------------
		# 2. Convert grid/cardinal input into isometric screen movement.
		# ---------------------------------------------------------------------
		# Formula:
		#   screen_x = input_x - input_y
		#   screen_y = (input_x + input_y) * 0.5
		#
		# Examples:
		#   Right input: Vector2( 1,  0) -> screen down-right
		#   Down input:  Vector2( 0,  1) -> screen down-left
		#   Left input:  Vector2(-1,  0) -> screen up-left
		#   Up input:    Vector2( 0, -1) -> screen up-right
		#
		# This matches the same projection used by IsoLevel.iso_to_screen().

		screen_vec = Vector2(
			input_vec.x - input_vec.y,
			(input_vec.x + input_vec.y) * 0.5
		).normalized()

		# Save the direction for both movement animation and idle facing.
		facing_dir = _direction_from_screen_vector(screen_vec)

	# -------------------------------------------------------------------------
	# 3. Move the CharacterBody2D.
	# -------------------------------------------------------------------------

	var target_speed: float = run_speed if Input.is_action_pressed("run") else walk_speed
	var target_velocity: Vector2 = screen_vec * target_speed

	velocity = velocity.lerp(
		target_velocity,
		clamp(acceleration * delta, 0.0, 1.0)
	)

	# Stop tiny leftover lerp velocity so idle does not drift forever.
	if not moving and velocity.length() < 2.0:
		velocity = Vector2.ZERO

	move_and_slide()

	# -------------------------------------------------------------------------
	# 4. Pick the correct animation.
	# -------------------------------------------------------------------------

	if moving:
		if Input.is_action_pressed("run"):
			_play_state("run")
		else:
			_play_state("walk")
	else:
		_play_state("idle")

	# Higher y means visually lower on screen, so draw later/on top.
	z_index = int(global_position.y)

func _direction_from_screen_vector(v: Vector2) -> String:
	# Convert a normalized screen-space vector to one of 8 direction strings.
	#
	# atan2(y, x) gives an angle in radians.
	# Dividing by PI * 0.25 divides the circle into 45-degree wedges.
	# round() chooses the nearest wedge.
	# +8 and %8 keep the index inside 0..7 even for negative angles.

	var angle: float = atan2(v.y, v.x)
	var index: int = int(round(angle / (PI * 0.25)))
	index = (index + 8) % 8
	return DIRS_CLOCKWISE[index]

func _play_state(state: String) -> void:
	# Build the animation name from movement state and facing direction.
	# Examples: "idle_se", "walk_w", "run_ne".

	var anim_name: StringName = StringName("%s_%s" % [state, facing_dir])

	if anim.sprite_frames == null:
		return

	if not anim.sprite_frames.has_animation(anim_name):
		push_warning("Missing player animation: " + String(anim_name))
		return

	# Avoid restarting the same animation every physics frame. Restarting it each
	# frame would keep it stuck on frame 0.
	if anim.animation != anim_name or not anim.is_playing():
		anim.play(anim_name)

func add_clue() -> void:
	collected_clues += 1
	clue_collected.emit(collected_clues)

func respawn() -> void:
	global_position = spawn_position
	velocity = Vector2.ZERO
	player_respawned.emit()

func _build_sprite_frames() -> void:
	# Build a new SpriteFrames resource from the three sprite sheets.
	# The scene can have an empty SpriteFrames resource; this replaces it at run.

	var frames := SpriteFrames.new()

	_add_directional_sheet(
		frames,
		"idle",
		idle_sheet_path,
		idle_source_frame_size,
		idle_frames_per_direction,
		idle_fps,
		true,
		idle_draw_offset
	)

	_add_directional_sheet(
		frames,
		"walk",
		walk_sheet_path,
		walk_source_frame_size,
		walk_frames_per_direction,
		walk_fps,
		true,
		walk_draw_offset
	)

	_add_directional_sheet(
		frames,
		"run",
		run_sheet_path,
		run_source_frame_size,
		run_frames_per_direction,
		run_fps,
		true,
		run_draw_offset
	)

	anim.sprite_frames = frames

func _add_directional_sheet(
	frames: SpriteFrames,
	state_name: String,
	path: String,
	source_frame_size: Vector2i,
	frame_count: int,
	fps: float,
	loop: bool,
	draw_offset: Vector2i
) -> void:
	# This function creates animations from one sprite sheet.
	#
	# For each direction row:
	#   1. Create an animation named state_direction, such as walk_se.
	#   2. Cut frame_count rectangles from that row.
	#   3. Paste each rectangle into a fixed 112x146 transparent image.
	#   4. Add the fixed-size image to SpriteFrames.
	#
	# That normalization step is the key difference from using raw AtlasTexture
	# regions directly. AtlasTexture regions with different sizes make the sprite
	# appear to move because their visual center changes.

	var texture := load(path) as Texture2D

	if texture == null:
		push_error("Missing player sprite sheet: " + path)
		return

	var source_image: Image = texture.get_image()

	if source_image == null:
		push_error("Could not read image data from: " + path)
		return

	if source_image.is_compressed():
		source_image.decompress()

	# Use one consistent format so blit_rect() can copy safely.
	source_image.convert(Image.FORMAT_RGBA8)

	for row: int in range(DIRS_BY_ROW.size()):
		var dir_name: String = DIRS_BY_ROW[row]
		var anim_name: StringName = StringName("%s_%s" % [state_name, dir_name])

		frames.add_animation(anim_name)
		frames.set_animation_speed(anim_name, fps)
		frames.set_animation_loop(anim_name, loop)

		for col: int in range(frame_count):
			var source_x: int = col * source_frame_size.x
			var source_y: int = row * source_frame_size.y

			# Stop if the requested frame starts outside the image.
			# This protects against sheet-size mistakes.
			if source_x >= source_image.get_width() or source_y >= source_image.get_height():
				break

			# Clamp width/height when the sheet is slightly trimmed.
			# Your idle sheet appears to be 2048x854 even though 25x8 cells of
			# 82x107 would ideally be 2050x856. This prevents an out-of-bounds
			# crop on the last column or row.
			var crop_width: int = min(source_frame_size.x, source_image.get_width() - source_x)
			var crop_height: int = min(source_frame_size.y, source_image.get_height() - source_y)

			var source_rect := Rect2i(source_x, source_y, crop_width, crop_height)

			# The final frame is always the same size for every animation.
			# This keeps AnimatedSprite2D stable.
			var frame_image: Image = Image.create(
				draw_frame_size.x,
				draw_frame_size.y,
				false,
				Image.FORMAT_RGBA8
			)
			frame_image.fill(Color(0, 0, 0, 0))

			# Paste the cropped source frame into the fixed-size output frame.
			frame_image.blit_rect(source_image, source_rect, draw_offset)

			var frame_texture: ImageTexture = ImageTexture.create_from_image(frame_image)
			frames.add_frame(anim_name, frame_texture)
