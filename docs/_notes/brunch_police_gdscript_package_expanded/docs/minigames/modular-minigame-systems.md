# Modular Mini-Game Systems

Mini-games should share a small common lifecycle so they are easy to start, fail, complete, and reward.

## Shared Lifecycle

| State | Meaning |
|---|---|
| `idle` | Mini-game is available but not running. |
| `running` | Mini-game is active. |
| `completed` | Objective succeeded. |
| `failed` | Objective failed or timer expired. |

## Suggested Mini-Games

### Puzzle System

Use for tile-matching, object rotation, or plate-arrangement puzzles. Track move count, solved state, and hints.

### Time Trial

Use for chase sections or delivery-style challenges. Track elapsed time, best time, and medal thresholds.

### Fishing-Style Timing System

Use for food-catching, syrup-pulling, or timing-based side activities. Track tension, timing window, and reward quality.

## GDScript File

- `godot/autoloads/MiniGameManager.gd`
