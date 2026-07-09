
# Scraps from 2dknight

```
acceleration/friction instead of instant horizontal velocity
variable jump height when releasing jump early
coyote time
jump buffering
double jump, if you want it
crouch collision shape / ceiling check
glide logic, since your Player.gd already has glide exports
dash, roll, wall-slide later as separate states
```

```
velocity.x = movement_speed * input_x
# becomes
velocity.x = move_toward(velocity.x, target, acceleration_amount)
```

add in `Player.gd`:
```gdscript
@export_category("Movement Feel")
@export var ground_acceleration := 4000.0
@export var ground_friction := 5000.0
@export var air_acceleration := 2500.0
@export var air_friction := 1200.0
```

then replace current `apply_horizontal_movement()` with this:
```gdscript
func apply_horizontal_movement(input_x: float, movement_speed: float, delta: float) -> void:
        set_facing_from_input(input_x)

        var target_x := movement_speed * input_x
        var accel := ground_acceleration if is_on_floor() else air_acceleration
        var friction := ground_friction if is_on_floor() else air_friction

        if has_move_input(input_x):
                velocity.x = move_toward(velocity.x, target_x, accel * delta)
        else:
                velocity.x = move_toward(velocity.x, 0.0, friction * delta)
```

then update `move_with_input()`:
```gdcript
func move_with_input(delta: float, input_x: float, movement_speed: float) -> void:
        apply_horizontal_movement(input_x, movement_speed, delta)
        apply_gravity(delta)
        move_and_slide()
```

add variable jump height using this from the old script:
```gdcript
if Input.is_action_just_released("jump") and velocity.y < 0:
        velocity.y *= jump_release_decel
```

in `Player.gd` add:
```gdcript
@export_category("Jump Feel")
@export var jump_release_decel := 0.5
```

then add this helper:
```gdcript
func apply_jump_cut() -> void:
        if Input.is_action_just_released("jump") and velocity.y < 0.0:
                velocity.y *= jump_release_decel
```
Call it in your air states

For example, in `Jumping.gd`:
```gdcript
func physics_update(delta: float) -> void:
        player.apply_jump_cut()

        move_player(delta, "jumping")

        if player.velocity.y >= 0.0:
                finished.emit(FALLING)
                return
```
You can also call it in falling.gd, though it mainly matters while moving upward.

Coyote time and jump buffer are also worth incorporating.  
You can do them with Timer nodes like the old scripts, but for your FSM I would keep it inside `Player.gd` with float timers.  

Add to `Player.gd`
```gdcript
@export_category("Jump Assist")
@export var coyote_time := 0.12
@export var jump_buffer_time := 0.12
@export var can_double_jump := false

var coyote_timer := 0.0
var jump_buffer_timer := 0.0
var has_double_jumped := false
```

add these helpers:
```gdcript
func update_jump_assist_timers(delta: float) -> void:
        if is_on_floor():
                coyote_timer = coyote_time
                has_double_jumped = false
        else:
                coyote_timer = maxf(coyote_timer - delta, 0.0)

        jump_buffer_timer = maxf(jump_buffer_timer - delta, 0.0)


func buffer_jump() -> void:
        jump_buffer_timer = jump_buffer_time


func has_buffered_jump() -> bool:
        return jump_buffer_timer > 0.0


func can_ground_jump() -> bool:
        return is_on_floor() or coyote_timer > 0.0


func consume_jump() -> void:
        velocity.y = -jump_impulse
        coyote_timer = 0.0
        jump_buffer_timer = 0.0


func try_jump() -> bool:
        if can_ground_jump():
                consume_jump()
                return true

        if can_double_jump and not has_double_jumped:
                consume_jump()
                has_double_jumped = true
                return true

        buffer_jump()
        return false
```

Then simplify your jump checks. For example, in `idle.gd`, instead of:
```gdcript
if Input.is_action_just_pressed("jump") and player.is_on_floor():
        finished.emit(JUMPING)
        return
```

use:
```gdcript
if Input.is_action_just_pressed("jump"):
        if player.try_jump():
                finished.emit(JUMPING)
        return
```

But then change `jumping.gd`, because currently `enter()` applies the jump impulse:
```gdcript
func enter(_previous_state_path: String, _data := {}) -> void:
        player.velocity.y = -player.jump_impulse
        player.play_directional_animation("jumping")
```

If try_jump() now applies the impulse, change `jumping.gd` to:
```gdcript
func enter(_previous_state_path: String, _data := {}) -> void:
        player.play_directional_animation("jumping")
```

Otherwise you will apply the jump twice.

Also call the timer update in each state’s `physics_update()` before jump checks:
```gdcript
player.update_jump_assist_timers(delta)
```

For example:
```gdcript
func physics_update(delta: float) -> void:
        player.update_jump_assist_timers(delta)

        var input_x := get_input_x()

        if Input.is_action_just_pressed("jump"):
                if player.try_jump():
                        finished.emit(JUMPING)
                return

        # rest of state logic...
```

For buffered jumps when landing, add this to `falling.gd`:
```gdcript
func physics_update(delta: float) -> void:
        player.update_jump_assist_timers(delta)

        var input_x := move_player(delta, "falling")

        if player.is_on_floor():
                if player.has_buffered_jump():
                        player.consume_jump()
                        finished.emit(JUMPING)
                        return

                go_to_grounded_state(input_x)
                return
```

Crouch ceiling checks are useful too, 
but your current scene does not show overhead RayCast2D nodes or separate collision shapes.  
To import that logic, you would need to add two upward RayCast2D nodes to the player scene, for example:
```gdcript
Player
  CrouchRaycastLeft
  CrouchRaycastRight
```

Then, in `Player.gd`:
```gdcript
@onready var overhead_rays := [
        $CrouchRaycastLeft,
        $CrouchRaycastRight,
]

func ceiling_is_clear() -> bool:
        for ray: RayCast2D in overhead_rays:
                if ray.is_colliding():
                        return false
        return true
```

Then in `crouching.gd`, only allow standing if clear:
```gdcript
if not Input.is_action_pressed("crouch") and player.ceiling_is_clear():
        go_to_grounded_state(input_x)
        return
```

If you also want the collision capsule to shrink while crouching, 
use the old script’s idea, but adapt it to your current `CollisionShape2D`. 
You can either preload two shapes or adjust the existing capsule. Preloading is cleaner:
```gdcript
@export var standing_shape: Shape2D
@export var crouching_shape: Shape2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func set_crouch_collision(enabled: bool) -> void:
        collision_shape.shape = crouching_shape if enabled else standing_shape
```

then, call this in states:
```gdcript
# crouching.gd
func enter(_previous_state_path: String, _data := {}) -> void:
        player.stop_horizontal_movement()
        player.set_crouch_collision(true)
        player.play_directional_animation("crouching")

func exit() -> void:
        if player.ceiling_is_clear():
                player.set_crouch_collision(false)
```

Glide is also a good candidate because you already have glide variables in `Player.gd`.  
Add a Gliding state instead of using a boolean-heavy approach.

Add this state constant:
```gdcript
const GLIDING = "Gliding"
```

Add a `Gliding` node under `StateMachine`, with `gliding.gd`:
```gdcript
extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
        player.velocity.y = minf(player.velocity.y, player.glide_jump_impulse)
        player.play_directional_animation("falling")


func physics_update(delta: float) -> void:
        var input_x := get_input_x()

        player.apply_horizontal_movement(input_x, player.glide_max_speed, delta)
        player.apply_gravity(delta, player.glide_gravity)
        player.velocity.y = minf(player.velocity.y, player.glide_max_speed)
        player.move_and_slide()

        player.play_directional_animation("falling")

        if not Input.is_action_pressed("jump"):
                finished.emit(FALLING)
                return

        if player.is_on_floor():
                go_to_grounded_state(input_x)
                return
```

then, in `falling.gd`, add:
```gdcript
if Input.is_action_pressed("jump") and player.velocity.y > 0.0:
        finished.emit(GLIDING)
        return
```

For dash and roll, I would not add their boolean-heavy logic directly into `Player.gd`.  
In your FSM, they should be states:
```gdcript
StateMachine
  Idle
  Walking
  Running
  Jumping
  Falling
  Crouching
  CrouchWalking
  Dashing
  Rolling
  Gliding
```

The old dash logic is useful, especially this part:
```gdcript
travelled >= dash_max_distance || is_on_wall()
```

That means the dash ends by distance, wall collision, or timeout.  
Good mechanic. But implement it as `dashing.gd`, 
not as a pile of is_dashing checks in every state.

The logic I would skip or delay:

The dictionary-based` _gather_input()` is fine, 
but your current FSM does not need it yet. 
It is useful in a monolithic controller, less necessary when each state handles only a small amount of input.

The debug label is useful, but your state machine already knows the current state.  
A simpler debug function would be:
```gdcript
func get_debug_label_text() -> String:
        if fsm == null or fsm.state == null:
                return "Player: none"

        return "State: %s\nVelocity: %.1f, %.1f\nFacing: %s" % [
                fsm.state.name,
                velocity.x,
                velocity.y,
                get_facing_suffix(),
        ]
```

The wall-slide and wall-jump logic is good, but it requires extra raycasts and more animation/state handling. I would add it after your basic movement, crouch, jump, and glide feel solid.

Recommended order:
- First: acceleration/friction, variable jump height, coyote time, jump buffer.
- Second: crouch ceiling check and crouch collision shape.
- Third: glide state.
- Fourth: dash and roll states.
- Fifth: wall slide and wall jump.

The most important thing: keep your current FSM architecture.  
The old scripts are mechanic references, not a better structure.
