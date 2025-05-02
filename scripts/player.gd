extends CharacterBody2D

# =============================================================
# Each mechanic is wrapped in three methods:  
# _<name>_start, _<name>_update, _<name>_end
# =============================================================

# -------------------------
# ▶ EXPORTS / TWEAKABLES ◀
# -------------------------

@export_group("Movement Speeds")
@export var gravity               : float =  20.0
@export var walk_speed            : float = 150.0
@export var run_speed             : float = 200.0
@export var crouch_walk_speed     : float = 100.0
@export var crouch_run_speed      : float = 150.0
@export var acceleration          : float = 0.10   # 0‑1, lerp factor
@export var friction              : float = 0.10   # 0‑1, lerp factor
@export var jump_force            : float = -500.0
@export var jump_release_decel    : float = 0.5

@export_group("Dash")
@export var dash_speed_multiplier : float = 3.5
@export var dash_distance_mult    : float = 1.2
@export var dash_duration         : float = 0.25  # safety timeout
@export var dash_cooldown         : float = 1.00
@export var dash_curve            : Curve

@export_group("Roll")
@export var roll_speed_multiplier : float = 1.3

@export_group("Jump")
@export var can_double_jump       : bool  = true

@export_group("Wall-jump / Wall-slide")
@export var wall_slide_speed      : float = 100.0
@export var wall_stick_time       : float = 0.25

@export_group("Debug")
@export var print_debug           : bool  = true

# -------------------------
# ▶ NODE REFERENCES (onready) ◀
# -------------------------

@onready var anim      : AnimationPlayer = $AnimationPlayer
@onready var sprite    : Sprite2D        = $Sprite2D
@onready var cshape    : CollisionShape2D= $CollisionShape2D
@onready var debug_lbl : Label           = $"../CanvasLayer/DebugLabel"

@onready var timers := {
	COYOTE        = $CoyoteTimer,
	JUMP_BUFFER   = $JumpBufferTimer,
	ROLL          = $RollTimer,
	ATTACK        = $AttackTimer,
	DASH          = $DashTimer,
	DASH_COOLDOWN = $DashCooldownTimer,
	WALL_STICK    = $WallStickTimer
}

# Raycasts for ceiling check
@onready var ray_overhead := [$CrouchRaycast_1, $CrouchRaycast_2]

# Raycasts for wall check
@onready var wall_raycast_left  = $WallRaycastLeft
@onready var wall_raycast_right = $WallRaycastRight

# --------------------
# ▶ COLLISION SHAPES ◀
# --------------------
var SHAPE_STAND  := preload("res://ressources/knight_standing_cshape.tres")
var SHAPE_CROUCH := preload("res://ressources/knight_crouching_cshape.tres")

# -------------------
# ▶ STATE VARIABLES ◀
# -------------------

var is_running         : bool  = false
var is_crouching       : bool  = false
var is_dashing         : bool  = false
var is_sliding         : bool  = false  # purely animation flag
var is_rolling         : bool  = false
var is_attacking       : bool  = false
var has_double_jumped  : bool  = false
var can_coyote_jump    : bool  = false
var jump_buffered      : bool  = false
var was_on_floor       : bool  = false
var is_wall_sliding    : bool  = false
var is_wall_sticking   : bool  = false
var just_touched_wall  : bool  = false

var dash_origin_x      : float = 0.0
var dash_dir           : int   = 0
var dash_speed         : float = 0.0
var dash_max_distance  : float = 0.0

var roll_dir           : int   = 0
var roll_speed         : float = 0.0

var facing             : int   = 1   # 1 right, ‑1 left

# =========================================
#  MAIN LOOP
# =========================================

func _physics_process(delta:float)->void:
	var inp := _gather_input()
	
	_apply_gravity(delta)
	_handle_horizontal(inp, delta)
	_handle_jump(inp)
	_handle_crouch(inp)
	_handle_dash(inp, delta)
	_handle_roll(inp)
	_check_double_tap_roll(inp)
	_handle_attack(inp)
	_handle_wall_slide(inp)
	
	move_and_slide()
	_ground_state_logic()
	
	_update_anim(inp.move)
	
	_update_debug_label(print_debug)
	if inp.toggle_debug: _toggle_debug_output()

# =========================================
#  INPUT GATHERING
# =========================================

func _gather_input() -> Dictionary:
	return {
		move = Input.get_axis("move_left", "move_right"),
		run = Input.is_action_pressed("run"),
		jump_down = Input.is_action_just_pressed("jump"),
		jump = Input.is_action_pressed("jump"),
		jump_up = Input.is_action_just_released("jump"),
		dash = Input.is_action_just_pressed("dash"),
		crouch_down = Input.is_action_just_pressed("crouch"),
		crouch = Input.is_action_pressed("crouch"),
		crouch_up = Input.is_action_just_released("crouch"),
		roll = Input.is_action_just_pressed("roll"),
		attack = Input.is_action_just_pressed("attack"),
		toggle_debug = Input.is_action_just_pressed("toggle_debug")
	}

# =====================================================
#  MOVEMENT HELPERS
# =====================================================

func _apply_gravity(delta:float)->void:
	if !is_on_floor() && !can_coyote_jump && !is_dashing:
		velocity.y = min(velocity.y + gravity, 1000)

func _current_ground_speed()->float:
	if is_crouching:
		return crouch_run_speed if is_running else crouch_walk_speed
	return run_speed if is_running else walk_speed

func _handle_horizontal(inp:Dictionary, delta:float)->void:
	is_running = inp.run

	if is_rolling:
		velocity.x = roll_speed * roll_dir
		return
	if is_dashing:
		return  # dash overrides manual control
	
	var speed = _current_ground_speed()
	var target: float = float(inp.move) * speed
	
	if inp.move != 0:
		facing = sign(inp.move)
		_switch_direction(facing)
		#velocity.x = lerp(velocity.x, target, acceleration)
		velocity.x = move_toward(velocity.x, target, speed * acceleration)
	else:
		#velocity.x = lerp(velocity.x, 0.0, friction)
		velocity.x = move_toward(velocity.x, target, walk_speed * friction)

# =====================================================
#  JUMP / DOUBLE‑JUMP / COYOTE
# =====================================================

func _handle_jump(inp:Dictionary)->void:
	
	# jump pressed
	if inp.jump_down:
		if is_on_floor() || can_coyote_jump:
			_do_jump()
		elif can_double_jump && !has_double_jumped:
			_do_jump(); has_double_jumped = true
		else:
			jump_buffered = true; timers.JUMP_BUFFER.start()

	# variable height
	if inp.jump_up && velocity.y < 0:
		velocity.y *= jump_release_decel

func _do_jump():
	velocity.y = jump_force
	can_coyote_jump = false
	timers.WALL_STICK.stop()

# =========================================
#  WALL-SLIDE / WALL-JUMP
# =========================================

func _handle_wall_slide(inp: Dictionary) -> void:
	
	# Reset if we left the wall or landed
	if is_on_floor() || !is_on_wall():
		is_wall_sliding = false
		is_wall_sticking = false
		just_touched_wall = false
		timers.WALL_STICK.stop()
		_switch_direction(facing)
		return
	
	# Are we pushing into the wall?
	var pushing_left = inp.move < 0 && _is_on_wall_only_left()
	var pushing_right = inp.move > 0 && !_is_on_wall_only_left()
	if !(pushing_left || pushing_right):
		just_touched_wall = false
		return
	
	# First frame on the wall -> start stick timer
	if !just_touched_wall:
		just_touched_wall = true
		is_wall_sticking = true
		timers.WALL_STICK.start(wall_stick_time)
	
	is_wall_sliding = true
	_switch_direction(-facing)
	
	# Stick or slide?
	#if is_wall_sticking:
		#velocity.y = min(velocity.y, 0)
	#else:
		#velocity.y = min(velocity.y, wall_slide_speed)
	
	velocity.y = min(velocity.y, 0 if is_wall_sticking else wall_slide_speed)

func _is_on_wall_only_left() -> bool:
	return wall_raycast_left.is_colliding() && !wall_raycast_right.is_colliding()

func _on_WallStickTimer_timeout() -> void: is_wall_sticking = false

# =====================================================
#  CROUCH / STAND
# =====================================================

func _handle_crouch(inp: Dictionary) -> void:
	if inp.crouch_down:
		_crouch()
	elif inp.crouch_up && _ceiling_clear():
		_stand()
	elif !inp.crouch && is_crouching && _ceiling_clear():
		_stand()

func _crouch():
	if is_crouching: return
	is_crouching = true
	cshape.shape = SHAPE_CROUCH
	cshape.position.y = 0

func _stand():
	if !is_crouching: return
	is_crouching = false
	cshape.shape = SHAPE_STAND
	cshape.position.y = -5

func _ceiling_clear()->bool:
	for ray in ray_overhead:
		if ray.is_colliding():
			return false
	return true

# =====================================================
#  DASH (inc. SLIDE)
# =====================================================

func _handle_dash(inp:Dictionary, delta:float)->void:
	if is_rolling: return #? TOCHECK: This prevents mid-roll dash cancel
	
	if inp.dash && inp.move != 0 && !is_dashing && timers.DASH_COOLDOWN.is_stopped():
		_dash_start(sign(inp.move))

	if is_dashing:
		_dash_update(inp)

func _dash_start(dir:int)->void:
	is_dashing = true
	is_sliding = is_crouching && is_on_floor()   # slide if started crouched on ground

	dash_origin_x     = position.x
	dash_dir          = dir
	dash_speed        = _current_ground_speed() * dash_speed_multiplier
	dash_max_distance = _current_ground_speed() * dash_distance_mult

	timers.DASH.start(dash_duration)
	timers.DASH_COOLDOWN.start(dash_cooldown)

	# make sure we face the right way
	_switch_direction(dir)

func _dash_update(inp:Dictionary)->void:
	var travelled: float = abs(position.x - dash_origin_x)
	if travelled >= dash_max_distance || is_on_wall():
		_dash_end()
		return

	velocity.x = dash_dir * dash_speed * dash_curve.sample(travelled / dash_max_distance)
	velocity.y = 0

	# mid‑dash slide conversion (ground only)
	if inp.crouch_down && is_on_floor():
		is_sliding = true
		_crouch()

func _dash_end():
	is_dashing = false
	is_sliding = false

func _on_DashTimer_timeout(): _dash_end()
func _on_DashCooldownTimer_timeout() -> void: pass

# =====================================================
#  ROLL
# =====================================================

func _handle_roll(inp:Dictionary)->void:
	if is_dashing: return #? TOCHECK: This prevents mid-dash roll cancel
	
	if inp.roll && is_on_floor() && !is_rolling && inp.move!=0:
		_roll_start(sign(inp.move))
	if is_rolling:  # stop when timer finishes in callback
		pass

func _roll_start(dir:int):
	is_rolling = true
	roll_dir   = dir
	roll_speed = _current_ground_speed() * roll_speed_multiplier
	_switch_direction(roll_dir)
	timers.ROLL.start()
	_crouch()

func _on_RollTimer_timeout():
	is_rolling = false
	velocity.x *= 0.5
	if _ceiling_clear() && !is_crouching:
		_stand()

var double_tap_time = 0.3
var last_tap_left_time = 0.1
var last_tap_right_time = 0.1

func _check_double_tap_roll(inp:Dictionary)->void:
	if is_rolling: return
	
	var current_time = Time.get_ticks_msec() / 1000.0
	
	if Input.is_action_just_pressed("move_left"):
		if current_time - last_tap_left_time <= double_tap_time:
			if last_tap_left_time > last_tap_right_time:
				_roll_start(-1)
		last_tap_left_time = current_time
	
	if Input.is_action_just_pressed("move_right"):
		if current_time - last_tap_right_time <= double_tap_time:
			if last_tap_right_time > last_tap_left_time:
				_roll_start(1)
		last_tap_right_time = current_time

# =====================================================
#  ATTACK
# =====================================================

func _handle_attack(inp:Dictionary)->void:
	if is_dashing || is_rolling: return
	
	if inp.attack && !is_attacking:
		is_attacking = true
		timers.ATTACK.start()

func _on_AttackTimer_timeout():
	is_attacking = false

# =====================================================
#  GROUND / AIR TRANSITIONS
# =====================================================

func _ground_state_logic():
	# falling off ledge – coyote
	if is_on_floor():
		was_on_floor = true
		has_double_jumped = false
	else:
		if was_on_floor:
			can_coyote_jump = true
			timers.COYOTE.start()
			was_on_floor = false

func _on_CoyoteTimer_timeout(): can_coyote_jump = false
func _on_JumpBufferTimer_timeout(): jump_buffered = false

# =====================================================
# 
# =====================================================

func _switch_direction(dir: float):
	sprite.flip_h = dir < 0
	sprite.position.x = dir * 4

# =====================================================
#  ANIMATION
# =====================================================

func _update_anim(move_axis:float)->void:
	anim.speed_scale = 1.0

	if is_attacking:
		anim.play("crouch_attack" if is_crouching else "attack")
		return

	if is_rolling:
		anim.play("roll"); return
	if is_dashing:
		if is_sliding && is_on_floor():
			anim.play("slide"); return
		anim.play("dash"); return

	if is_on_floor():
		if is_crouching:
			if abs(move_axis) > 0.01:
				anim.play("crouch_walk")
			else:
				anim.play("crouch")
		else:
			if abs(move_axis) > 0.01:
				anim.play("run")
				if is_running: anim.speed_scale = 1.2
			else:
				anim.play("idle")
	else:
		if is_wall_sliding:
			anim.play("wall_slide")
			if is_wall_sticking: anim.speed_scale = 0
		else:
			anim.play("crouch" if is_crouching else ("jump" if velocity.y < 0 else "fall"))

# =====================================================
#  DEBUG TEXT
# =====================================================

func _toggle_debug_output():
	print_debug = !print_debug
	debug_lbl.visible = print_debug
#
func _update_debug_label(enabled: bool):
	if !enabled: return
	
	var lines := []

	# Base info
	lines.append("Speed: %.2f" % _current_ground_speed())
	lines.append("Velocity: (%.2f, %.2f)" % [velocity.x, velocity.y])

	# Determine movement state
	var state := ""

	if is_rolling:
		state = "Rolling"
	elif is_dashing:
		state = "Dashing"
	elif is_wall_sliding:
		state = "Wall Sticking" if is_wall_sticking else "Wall Sliding"
	elif !is_on_floor():
		if has_double_jumped:
			state = "Double Jumping" if velocity.y < 0 else "Falling"
		else:
			state = "Jumping" if velocity.y < 0 else "Falling"
	elif is_crouching:
		if abs(velocity.x) > 0.1:
			state = "Crouch Running" if is_running else "Crouch Walking"
		else:
			state = "Crouching"
	else:
		if abs(velocity.x) > 0.1:
			state = "Running" if is_running else "Walking"
		else:
			state = "Idle"
	
	lines.append("State: %s" % state)
	debug_lbl.text = "\n".join(lines)

func tell(message: String) -> void:
	if print_debug:
		print(message)
