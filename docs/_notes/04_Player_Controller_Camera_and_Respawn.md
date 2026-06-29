# Player Controller, Camera, and Respawn

## Purpose

This note consolidates player movement, advanced platforming mechanics, camera behavior, checkpoints, and respawn logic.

## Source files covered

- `player-controller.txt`
- `player-movement-basic.txt`
- `misc.txt`
- `dynamic-camera-system.txt`
- `checkpoint-and-respawn.txt`

## Player movement goals

The movement documents define a modular 2D platformer controller with:

- Horizontal movement.
- Acceleration and deceleration.
- Gravity.
- Jumping.
- Variable jump height.
- Coyote time.
- Jump buffering.
- Double jump.
- Wall jumping.
- Dash.
- Ledge grab.
- Slopes, moving platforms, and one-way platform support as future extensions.

## Basic movement tuning notes

The `misc.txt` file includes movement feel notes:

- Keep the player from feeling too heavy.
- Set gravity to `0` when the player is on the ground.
- Apply gravity only when the player is in the air.
- Add coyote time for jump forgiveness after leaving a ledge.
- Add jump cut by reducing vertical speed when the button is released.
- Add fast fall by increasing gravity while falling.

## Core controller parameters

Movement:

```cpp
float speed;
float acceleration;
float deceleration;
```

Jumping:

```cpp
float gravity;
float jump_force;
int max_jumps;
int jumps_left;
```

Coyote time and buffering:

```cpp
float coyote_time;
float coyote_timer;
float jump_buffer;
float jump_buffer_timer;
```

Wall jump:

```cpp
bool is_wall_touching;
Vector2 wall_jump_force;
```

Dash:

```cpp
bool can_dash;
float dash_speed;
float dash_cooldown;
float dash_timer;
```

## Recommended final movement loop

A clean final loop should separate:

1. Input collection.
2. Horizontal movement.
3. Jump buffering.
4. Coyote timer updates.
5. Jump execution.
6. Gravity and fast fall.
7. Dash handling.
8. Wall handling.
9. `move_and_slide`.
10. Animation state updates.

## Advanced movement behavior

### Coyote time

Allow the player to jump shortly after leaving the ground.

### Jump buffering

Store a jump input for a short time so the player still jumps if they pressed the button just before landing.

### Double jump

Reset jumps when grounded. Consume one jump on each successful jump.

### Wall jump

When touching a wall, apply a directional force away from the wall.

### Dash

Dash in the player's input direction. Use a cooldown timer and optionally reset dash when grounded.

### Ledge grab

The source notes list ledge grab as a planned mechanic, but the implementation should still be designed.

## Dynamic Camera System

The Dynamic Camera provides smooth follow, adjustable target, adjustable follow speed, zooming for specific scenes or events, and contextual framing.

Main properties:

```cpp
Node2D *target;
float follow_speed;
```

Main operations:

- `set_target(target)`
- `set_follow_speed(speed)`
- `_process(delta)`
- `zoom_to(factor, duration)`

Recommended future additions:

- Screen shake.
- Look-ahead offset.
- Camera bounds per level.
- Cutscene panning.
- Boss-arena framing.

## Checkpoint and Respawn System

The checkpoint system stores:

```cpp
Vector2 last_checkpoint_position;
```

Main operations:

- `set_checkpoint(position)`
- `get_last_checkpoint()`
- `respawn(player)`

Current behavior:

- Default spawn position is `(0, 0)`.
- Respawn moves the player to the last checkpoint.

Recommended future additions:

- Save player health.
- Save inventory snapshot.
- Save current level.
- Save temporary level state.
- Restore camera position.
- Trigger respawn effects or invincibility frames.
