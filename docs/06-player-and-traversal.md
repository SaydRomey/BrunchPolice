# Player Movement, Traversal and Camera

## Two movement modes

**Hub controller:** top-down/isometric walk, facing direction, NPC interaction, inspection and evidence collection. **Chase controller:** `CharacterBody2D` with horizontal acceleration, controlled deceleration, gravity, variable-height jump, coyote time, input buffering, fast-fall, optional double jump, wall jump, dash and rope traversal. The controllers share inventory, health and narrative state but not their movement implementation.

## Platformer controller settings

| Export field | Intended behavior | Starting value (tuning) |
|---|---|---|
| `run_speed` | Maximum horizontal speed | 225 px/s |
| `accel` / `decel` | Ground response | 1400 / 1600 px/s² |
| `gravity` | Downward acceleration | 1100 px/s² |
| `jump_velocity` | First upward impulse | -390 px/s |
| `coyote_time` | Jump grace after leaving ledge | 0.10 s |
| `jump_buffer_time` | Jump shortly before landing | 0.12 s |
| `jump_cut_multiplier` | Short hop on release | 0.5 |
| `dash_duration` | Sustained dash state | 0.17 s |
| `dash_cooldown` | Time before another dash | 0.65 s |

These are editable prototyping defaults, not final balance. For 2D physics, preserve constant gravity acceleration and let `move_and_slide()` resolve surfaces; grounded velocity is clamped to zero as necessary rather than disabling the entire gravity model globally.

## Update order

1. Read input actions and accessibility remapping.
2. Update timers/buffers, status multipliers and available movement actions.
3. Handle dash/rope overrides or ground/air control.
4. Resolve gravity, jump, fast-fall and moving-platform velocity.
5. Call `move_and_slide()` exactly once per physics tick.
6. Update facing, animation state and camera targets.

## Specialized traversal

- **Swing rope:** explicit grab/release interface; conserve release momentum; ignore repeated grab input while attached.
- **Conveyors:** apply surface transfer speed without teleporting the player; clamp at edges.
- **Steam lift:** upward push is clearly distinct from horizontal damaging steam, both governed by pressure phase.
- **Slippery/sticky surfaces:** surface modifiers modify acceleration and traction; status controllers combine effects through predictable precedence.
- **Collapsing/sinking platforms:** warn, trigger when occupied, reset after delay or checkpoint reload.

## Camera

Camera2D smooth follow with constrained lookahead, dead zones and bounded zoom. Allow camera volumes for vertical climbs, boss arenas and cutscenes; never reveal large dead zones or off-level art. Camera shake and flash can be reduced or disabled independently.

## Death and checkpoints

Checkpoint data stores `level_id`, `checkpoint_id`, position, facing and allowed transient state. Respawn clears incapacitating states and active projectiles; permanent evidence/unlocks remain. Fall recovery never places the player inside an active crusher or damage volume.
