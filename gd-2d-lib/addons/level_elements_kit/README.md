# Reusable Level Elements Kit

Portable Godot 4.x `PackedScene` library. 

Drag templates from `scenes/` into your levels, 
configure metadata/appearance/labels in the root Inspector, 
and use scenes' signals or optional actor methods to connect gameplay.

- Core: `scripts/le_element_2d.gd` + `scripts/le_platform_base.gd`.
- Settings: `display_name`, `element_id`, `category`, `element_size`, `visual_preset`, `fill_color`, `art_texture`, and Debug Label group.
- Game integration: World layer bit 1; Player bit 2 for trigger masks in the starter. Adjust in other host games.
- Sources: relative to `res://addons/level_elements_kit/`; can copy the entire folder to another Godot project.
- No editor plugin installation required. `@tool` controls live Inspector/editor updates.
- Provided as a starter; validate run-time physics and other scene interactions in your host version.
