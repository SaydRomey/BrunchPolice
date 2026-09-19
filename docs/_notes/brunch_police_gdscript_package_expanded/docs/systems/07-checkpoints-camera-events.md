# Checkpoints, Camera, and Events

This section converts the checkpoint/respawn, dynamic camera, event system, and event queue notes into Godot 4 scripts.

## Checkpoint and Respawn

Use `CheckpointSystem.gd` as an autoload or scene-level manager. Checkpoints call `set_checkpoint()` when activated. When the player dies, call `respawn_player(player)`.

Files:

- `godot/autoloads/CheckpointSystem.gd`
- `godot/pickups/Checkpoint.gd`

## Dynamic Camera

Use `DynamicCamera.gd` on a `Camera2D`. It supports:

- Smooth player follow.
- Follow offset.
- Tweened zoom.
- Temporary screen shake.
- Optional bounds through normal Camera2D limit properties.

File:

- `godot/camera/DynamicCamera.gd`

## Event System

Use `EventSystem.gd` for publisher/subscriber style events. It allows multiple listeners per event, unlike the original single-callback sketch.

Use `EventQueue.gd` for ordered cutscene or scripted gameplay events.

Files:

- `godot/autoloads/EventSystem.gd`
- `godot/autoloads/EventQueue.gd`
