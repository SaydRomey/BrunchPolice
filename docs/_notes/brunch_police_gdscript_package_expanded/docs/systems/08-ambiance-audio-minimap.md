# Ambiance, Dynamic Audio, and Minimap

This section converts ambiance overlays, dynamic lighting, distance-aware sound effects, and minimap notes into Godot 4 scripts.

## Ambiance

`AmbianceManager.gd` can be used as an autoload or scene node. It controls:

- Full-screen color filter overlay.
- Fog, toxic gas, night tint, or other ambiance layers.
- Dynamic light registration.
- Simple day/night tint interpolation.

File:

- `godot/autoloads/AmbianceManager.gd`

## Dynamic Sound Effects

`DynamicSoundEffect.gd` should be attached to sound-emitting nodes. It adjusts volume based on distance to the listener and can randomize pitch for variation.

`FootstepSurfaceAudio.gd` maps surface types to footstep sound pools.

Files:

- `godot/audio/DynamicSoundEffect.gd`
- `godot/audio/FootstepSurfaceAudio.gd`

## Minimap

`MinimapSystem.gd` implements a practical minimap controller with:

- Player marker.
- Zoom.
- Rotation toggle.
- POI icons.
- Show/hide toggle.

The script expects UI nodes to be assigned through exported `NodePath`s.

File:

- `godot/minimap/MinimapSystem.gd`
