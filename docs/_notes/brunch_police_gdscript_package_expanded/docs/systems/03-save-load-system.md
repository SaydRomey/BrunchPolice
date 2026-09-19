# Save and Load System

## Purpose

`SaveManager.gd` saves and loads player progress, including:

- Global resources
- Inventory items
- Equipped weapons
- Unlocked levels
- Settings

## Format

The converted script uses JSON files in `user://`, which is easier to extend and safer than manually parsing custom text sections.

Default file path pattern:

```text
user://slot_1.json
```

## Basic Use

```gdscript
SaveManager.capture_from_autoloads()
SaveManager.save_game("slot_1")

SaveManager.load_game("slot_1")
SaveManager.apply_to_autoloads()
```

## Converted Script

- `godot/autoloads/SaveManager.gd`
