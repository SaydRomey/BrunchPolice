# Level Elements Kit — Godot 4

Reusable 2D platform, trigger, hazard and gameplay interaction scenes for Brunch Police.  
The addon can be copied into other Godot projects without an EditorPlugin.

## Contents

- `scenes/`: 16 reusable `.tscn` elements.
- `scripts/`: 16 GDScript classes with `##` hover/help documentation.
- `presets/`: 9 reusable `.tres` appearance resources.
- `docs/Level_Elements_API_Reference.md`: all classes, exported Inspector properties, methods and signals.
- `docs/Hover_Documentation_Guide.md`: how to find and maintain documentation comments.

The full implementation guide lives at the project's `docs/Godot_Reusable_Platformer_Elements_Guide.md`.  

If copying only this addon to a second project, 
the two documents under `addons/level_elements_kit/docs/` remain portable with it.

## Quick start

1. Drag an element scene from `scenes/` into a level.
2. Set its root `element_id`, `display_name`, `element_size`, visual preset and debug label preferences in the Inspector.
3. Configure element-specific behavior properties and connect its signals to the host project.
4. Use F1/Search Help in Godot to inspect public class documentation and hover exported properties for descriptions.
5. Verify the player's collision layers and optional actor methods before testing in gameplay.

## Important behavior boundaries

- `LE_Switch.toggle()` emits `toggled(is_on)` and refreshes its ON/OFF debug suffix.
- `LE_ConveyorPlatform.set_enabled()` starts/stops surface movement but does not change collision.
- `LE_PlatformBase.one_way` controls one-way collision independently.
- `LE_DamageZone` applies damage on entry; it does not implement continuous timed damage.
- `LE_MovingPlatform` moves its child physics Body; `LE_ElementVisual` is available for child-local visuals.
