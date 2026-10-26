# Checkpoints, Retries and Difficulty Policy

## Checkpoint scope

`CheckpointDefinition` stores stable `checkpoint_id`, `world_id`, trusted spawn anchor, facing, eligible starting equipment, local hazard reset groups, optional camera target and activation VFX. A checkpoint is activated by an explicit interaction or clearly communicated automatic trigger.

## Snapshot layers

| Layer | Examples | On retry |
|---|---|---|
| Campaign permanent | Solved cases, permanent equipment, unlocks, banked evidence | Preserve |
| Level confirmed | Activated checkpoint, confirmed quest stage, protected evidence | Preserve per world policy |
| Level transient | Enemy positions, hazard phase, expendable temporary pickups | Reset to authored checkpoint state |
| Player transient | Knockback, airborne/rope state, status timers, active projectiles | Clear or restore explicitly |

## Retry flow

On lethal damage: end attack/input → show defeat feedback → select activated checkpoint or entry spawn → reset local encounter groups → reconstruct player in safe coordinates → restore permitted HP/equipment → grant brief safe arrival state → resume gameplay. Respawn may not occur inside a crushing collision or active damaging steam jet.

## Difficulty boundaries

Baseline difficulty comes from timing windows and hazard combinations, not unavoidable damage. Optional assists can widen parry windows, increase platforming forgiveness, reduce damage or offer checkpoint recovery without changing the identity of evidence puzzles. The game may track each world as `cleared` independently from optional mastery medals.

## Caffeine checkpoint rules

Pressure cycles restart at a known safe phase following a retry. Vertical vents return to an identifiable state, and any mandatory valve state resets in a way that cannot soft-lock the route. Foam platforms reappear at their initial rest position. The Grand Percolator has a safe pre-boss checkpoint with no immediately active lethal steam.

## Validation

Test checkpoints before and after evidence pickups, during timed hazards, with depleted consumables, on boss defeat, on game load and during pause. Confirm no duplicate rewards or stranded camera after a retry.
