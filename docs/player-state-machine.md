
# Player State Machine

```gdscript
# -----------------------------------------------------------------------------
# Player.gd – root script of CharacterBody2D
# -----------------------------------------------------------------------------
extends CharacterBody2D

# =============================================================
# ▶ EXPORTS / TWEAKABLES ◀
# =============================================================
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
@export var wall_jump_force       = Vector2(250, -450)  # X for push-off, Y for height
@export var wall_stick_jump_force = Vector2(200, -550)
@export var wall_slide_speed      : float = 100.0
@export var wall_stick_time       : float = 0.45

@export_group("Glide")
@export var glide_gravity         : float = 8.0
@export var glide_max_speed       : float = 180.0 # horizontal cap while gliding
@export var glide_accel           : float = 0.25  # lerp factor for steering

@export_group("Debug")
@export var enable_print_debug    : bool  = true

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
    WALL_STICK    = $WallStickTimer,
}

# Raycasts for ceiling & walls
@onready var ray_overhead := [$CrouchRaycast_1, $CrouchRaycast_2]
@onready var wall_raycast_left  = $WallRaycastLeft
@onready var wall_raycast_right = $WallRaycastRight

# --------------------
# ▶ COLLISION SHAPES ◀
# --------------------
var SHAPE_STAND  := preload("res://ressources/knight_standing_cshape.tres")
var SHAPE_CROUCH := preload("res://ressources/knight_crouching_cshape.tres")

# --------------------
# ▶ STATE MACHINE ◀
# --------------------
@onready var sm : StateMachine = $StateMachine

func _ready() -> void:
    sm.state_changed.connect(_on_state_changed)

# Forward engine callbacks to the state‑machine so states receive them
func _unhandled_input(event: InputEvent) -> void:
    sm._unhandled_input(event)

func _process(delta: float) -> void:
    sm._process(delta)

func _physics_process(delta: float) -> void:
    sm._physics_process(delta)

# Called whenever the active state changes – optional animation bookkeeping
func _on_state_changed() -> void:
    # You can keep all animation switching inside states instead if you prefer.
    pass

# =============================================================
#  HELPER METHODS (re‑used by every state)
# =============================================================
func _current_ground_speed() -> float:
    return crouch_run_speed if is_crouching and is_running else (
        crouch_walk_speed if is_crouching else (run_speed if is_running else walk_speed))

func _apply_gravity(delta: float) -> void:
    velocity.y = min(velocity.y + gravity * delta, 1000)

func _switch_direction(dir: float) -> void:
    sprite.flip_h = dir < 0
    sprite.position.x = dir * 4

func start_timer(name: String, time := -1.0) -> void:
    if time > 0:
        timers[name].start(time)
    else:
        timers[name].start()

func stop_timer(name: String) -> void:
    timers[name].stop()

func is_timer_active(name: String) -> bool:
    return !timers[name].is_stopped()

func _ceiling_clear() -> bool:
    for ray in ray_overhead:
        if ray.is_colliding():
            return false
    return true

func _wall_side_from_rays() -> int:
    if wall_raycast_left.is_colliding() and !wall_raycast_right.is_colliding():
        return -1
    if wall_raycast_right.is_colliding() and !wall_raycast_left.is_colliding():
        return 1
    return 0

# Convenience flags used by several states – states are responsible for toggling them
var facing             : int = 1
var is_running         := false
var is_crouching       := false
var just_touched_wall  := false

# -----------------------------------------------------------------------------
# State‑query helper used for debugging UI (optional)
# -----------------------------------------------------------------------------
func _debug_state_name() -> String:
    return sm.state.name

# -----------------------------------------------------------------------------
# Debug label output (unchanged)
# -----------------------------------------------------------------------------
func _update_debug_label() -> void:
    if !enable_print_debug: return
    debug_lbl.text = "State: %s\nVel: %.0f, %.0f" % [_debug_state_name(), velocity.x, velocity.y]

# -----------------------------------------------------------------------------
# End Player.gd
# -----------------------------------------------------------------------------



# -----------------------------------------------------------------------------
# StateMachine.gd – attach to the StateMachine node
# -----------------------------------------------------------------------------
class_name StateMachine
extends Node

signal state_changed()

@export var initial_state: State = null
@onready var state: State = (func get_initial_state() -> State:
        return initial_state if initial_state != null else get_child(0)
).call()

@onready var player := owner   # <-- quick access for every state

func _ready() -> void:
    for s: State in find_children("*", "State"):
        s.finished.connect(_transition_to_next_state)
    await owner.ready
    state.enter("", {})

func _unhandled_input(event: InputEvent) -> void:
    state.handle_input(event)

func _process(delta: float) -> void:
    state.update(delta)

func _physics_process(delta: float) -> void:
    state.physics_update(delta)

func _transition_to_next_state(target_state_path: String, data: Dictionary = {}) -> void:
    if !has_node(target_state_path):
        push_error("State '%s' does not exist" % target_state_path)
        return
    var prev := state.name
    state.exit()
    state = get_node(target_state_path)
    state.enter(prev, data)
    state_changed.emit()

# -----------------------------------------------------------------------------
# Base State.gd – put one copy in res://states/BaseState.gd and autoload if you like
# -----------------------------------------------------------------------------
class_name State
extends Node

signal finished(next_state_path: String, data := {})

func handle_input(_e: InputEvent) -> void:    pass
func update(_d: float) -> void:              pass
func physics_update(_d: float) -> void:      pass
func enter(_prev: String, _data := {}) -> void: pass
func exit() -> void:                         pass

# -----------------------------------------------------------------------------
# Ground.gd – idle / walk / run / crouch
# -----------------------------------------------------------------------------
class_name Ground
extends State

func enter(_prev: String, _data := {}) -> void:
    player.is_running   = false
    player.is_crouching = false

func handle_input(e: InputEvent) -> void:
    if e.is_action_pressed("run"):
        player.is_running = true
    elif e.is_action_released("run"):
        player.is_running = false

    if e.is_action_pressed("crouch"):
        player.is_crouching = true
    elif e.is_action_released("crouch") and player._ceiling_clear():
        player.is_crouching = false

func physics_update(_delta: float) -> void:
    var move_axis := Input.get_axis("move_left", "move_right")
    var speed := player._current_ground_speed()
    var target := move_axis * speed

    # direction & acceleration
    if abs(move_axis) > 0.01:
        player.facing = sign(move_axis)
        player._switch_direction(player.facing)
        player.velocity.x = move_toward(player.velocity.x, target, speed * player.acceleration)
    else:
        player.velocity.x = move_toward(player.velocity.x, 0, speed * player.friction)

    # jump?
    if Input.is_action_just_pressed("jump"):
        finished.emit("Jump")
        return

    # dash?
    if Input.is_action_just_pressed("dash") and move_axis != 0 and !player.is_timer_active("DASH_COOLDOWN"):
        finished.emit("Dash", {"dir": sign(move_axis)})
        return

    # roll?
    if Input.is_action_just_pressed("roll") and move_axis != 0:
        finished.emit("Roll", {"dir": sign(move_axis)})
        return

    player.move_and_slide()

func exit() -> void:
    pass

# -----------------------------------------------------------------------------
# Jump.gd – single + double + fall handling
# -----------------------------------------------------------------------------
class_name Jump
extends State

var has_double_jumped := false

func enter(_prev: String, _data := {}) -> void:
    _do_jump()
    has_double_jumped = false

func physics_update(delta: float) -> void:
    var move_axis := Input.get_axis("move_left", "move_right")
    player.velocity.y += player.gravity * delta
    player.velocity.x = move_toward(player.velocity.x, move_axis * player.run_speed, player.run_speed * player.acceleration)

    # variable height
    if Input.is_action_just_released("jump") and player.velocity.y < 0:
        player.velocity.y *= player.jump_release_decel

    # double jump
    if Input.is_action_just_pressed("jump") and player.can_double_jump and !has_double_jumped:
        _do_jump()
        has_double_jumped = true

    # wall check – start wall slide
    if player.is_on_wall() and player._wall_side_from_rays() != 0 and player.velocity.y > 0:
        finished.emit("WallSlide")
        return

    # glide check
    if Input.is_action_pressed("jump") and player.velocity.y > 0 and !Input.is_action_just_pressed("jump"):
        finished.emit("Glide")
        return

    # dash in air
    if Input.is_action_just_pressed("dash") and move_axis != 0 and !player.is_timer_active("DASH_COOLDOWN"):
        finished.emit("Dash", {"dir": sign(move_axis)})
        return

    player.move_and_slide()

    if player.is_on_floor():
        finished.emit("Ground")

func _do_jump() -> void:
    if !player._ceiling_clear():
        return
    player.velocity.y = player.jump_force

# -----------------------------------------------------------------------------
# Dash.gd – ground & air dash
# -----------------------------------------------------------------------------
class_name Dash
extends State

var dir := 1
var origin_x := 0.0
var max_distance := 0.0
var speed := 0.0

func enter(_prev: String, data := {}) -> void:
    dir = data.dir
    origin_x = player.position.x
    speed = player._current_ground_speed() * player.dash_speed_multiplier
    max_distance = player._current_ground_speed() * player.dash_distance_mult

    player.start_timer("DASH", player.dash_duration)
    player.start_timer("DASH_COOLDOWN", player.dash_cooldown)

    player._switch_direction(dir)

func physics_update(_delta: float) -> void:
    var travelled := abs(player.position.x - origin_x)
    if travelled >= max_distance or player.is_on_wall():
        finished.emit("Ground" if player.is_on_floor() else "Jump")
        return

    player.velocity.x = dir * speed * player.dash_curve.sample(travelled / max_distance)
    player.velocity.y = 0
    player.move_and_slide()

func exit() -> void:
    player.velocity.x *= 0.5

# -----------------------------------------------------------------------------
# Roll.gd – ground roll
# -----------------------------------------------------------------------------
class_name Roll
extends State

var dir := 1
var speed := 0.0

func enter(_prev: String, data := {}) -> void:
    if !player.is_on_floor():
        finished.emit("Jump")
        return
    dir   = data.dir
    speed = player._current_ground_speed() * player.roll_speed_multiplier
    player._switch_direction(dir)
    player.start_timer("ROLL", 0.5) # reuse existing timer

func physics_update(_delta: float) -> void:
    player.velocity.x = dir * speed
    player.move_and_slide()

    # jump cancel
    if Input.is_action_just_pressed("jump"):
        finished.emit("Jump")
        return

    # dash cancel
    if Input.is_action_just_pressed("dash") and !player.is_timer_active("DASH_COOLDOWN"):
        finished.emit("Dash", {"dir": dir})
        return

    # timer finished?
    if player.is_timer_active("ROLL") == false:
        finished.emit("Ground" if player.is_on_floor() else "Jump")

func exit() -> void:
    player.velocity.x *= 0.5

# -----------------------------------------------------------------------------
# WallSlide.gd – slide + stick + jump off
# -----------------------------------------------------------------------------
class_name WallSlide
extends State

func enter(_prev: String, _data := {}) -> void:
    player.just_touched_wall = true
    player.start_timer("WALL_STICK", player.wall_stick_time)

func physics_update(_delta: float) -> void:
    # stick phase
    var sticking := player.just_touched_wall and player.is_timer_active("WALL_STICK")
    player.velocity.y = min(player.velocity.y, 0 if sticking else player.wall_slide_speed)
    player.move_and_slide()

    var wall_dir := player._wall_side_from_rays()
    if wall_dir != 0:
        player._switch_direction(-wall_dir)

    # wall jump
    if Input.is_action_just_pressed("jump"):
        var force := player.wall_stick_jump_force if sticking else player.wall_jump_force
        player.velocity = Vector2(-wall_dir * force.x, force.y)
        finished.emit("Jump")
        return

    # left wall
    if !player.is_on_wall():
        finished.emit("Jump")
        return

    if player.is_on_floor():
        finished.emit("Ground")

func exit() -> void:
    player.stop_timer("WALL_STICK")
    player.just_touched_wall = false

# -----------------------------------------------------------------------------
# Glide.gd – mid‑air glide
# -----------------------------------------------------------------------------
class_name Glide
extends State

func enter(_prev: String, _data := {}) -> void:
    player.velocity.y = min(player.velocity.y + player.glide_gravity, 600)

func physics_update(_delta: float) -> void:
    var move_axis := Input.get_axis("move_left", "move_right")
    var target_x  := move_axis * player.glide_max_speed
    player.velocity.x = move_toward(player.velocity.x, target_x, player.glide_max_speed * player.glide_accel)

    player.velocity.y = min(player.velocity.y, player.glide_gravity)

    player.move_and_slide()

    if Input.is_action_pressed("jump") == false or player.is_on_floor():
        finished.emit("Ground" if player.is_on_floor() else "Jump")
        return

    if Input.is_action_just_pressed("dash") and move_axis != 0 and !player.is_timer_active("DASH_COOLDOWN"):
        finished.emit("Dash", {"dir": sign(move_axis)})

# -----------------------------------------------------------------------------
# Attack.gd – simple attack state (animation driven)
# -----------------------------------------------------------------------------
class_name Attack
extends State

func enter(prev: String, _data := {}) -> void:
    player.anim.play("attack")
    await player.anim.animation_finished
    finished.emit(prev)   # return to previous state

# -----------------------------------------------------------------------------
# End of file bundle – save each class in its own .gd file as shown by headers.
# -----------------------------------------------------------------------------

```

---
