# Brunch Police Organized GDScript Package

This package reorganizes the supplied Brunch Police notes into cleaner Markdown files and converts the embedded C++/Godot C++ system examples into usable Godot 4 GDScript.

## Folder Structure

- `docs/` contains organized design and implementation notes.
- `docs/weapons/` consolidates duplicate weapon notes into readable weapon design documents.
- `docs/systems/` explains each gameplay system and links it to the matching GDScript file.
- `docs/levels/` contains normalized level documents copied from the supplied level design files.
- `godot/` contains ready-to-copy GDScript files, grouped by intended use.
- `source_files/` preserves the original uploaded `.md` and `.txt` files for reference.

## Godot Assumptions

The scripts target Godot 4.x. They use `Node2D`, `Area2D`, `CharacterBody2D`, `AnimatedSprite2D`, `AudioStreamPlayer`, `FileAccess`, and JSON-based save files.

Recommended autoload names:

| Autoload Name | Script |
|---|---|
| `Inventory` | `godot/autoloads/Inventory.gd` |
| `GameResourceManager` | `godot/autoloads/GameResourceManager.gd` |
| `ResourceManager` | `godot/autoloads/ResourceManager.gd` |
| `SaveManager` | `godot/autoloads/SaveManager.gd` |
| `SoundManager` | `godot/autoloads/SoundManager.gd` |
| `TimerManager` | `godot/autoloads/TimerManager.gd` |
| `ScoreManager` | `godot/autoloads/ScoreManager.gd` |
| `VisualEffectsManager` | `godot/autoloads/VisualEffectsManager.gd` |

## Quick Setup

1. Copy the `godot/` scripts into your Godot project, keeping the same folder structure if possible.
2. Add the autoload scripts listed above in **Project Settings > Autoload**.
3. Add `PlayerWeaponController.gd` to the player or to a child node of the player.
4. Create projectile scenes with `Area2D` roots and attach `Projectile.gd` or `BaconProjectile.gd`.
5. Create weapon scenes or child nodes using scripts from `godot/weapons/`.
6. Add enemy status methods by using or adapting `BaseEnemyStatusEffects.gd`.

## Main Conversion Decisions

The C++ examples were converted into idiomatic GDScript rather than direct one-to-one translations. Several original examples referenced unavailable helper calls such as `get_node_at_position()` or `get_overlapping_bodies()` from non-area weapon nodes. Those are replaced with usable Godot 4 physics shape queries, projectile scenes, signals, dictionaries, and autoload managers.

## Expanded Pass

This expanded version adds the remaining uploaded system notes as organized Markdown and Godot 4 GDScript. The new scripts cover ambiance, character customization, checkpoints, camera, dynamic sound, event dispatching, event queues, health/damage/i-frames, debug tools, level editing, minimap behavior, quest objectives, and mini-game lifecycle management.

Recommended autoload additions:

- `AmbianceManager.gd`
- `CheckpointSystem.gd`
- `EventSystem.gd`
- `EventQueue.gd`
- `MiniGameManager.gd`
- `QuestObjectiveManager.gd`

Recommended component additions:

- Add `HealthComponent.gd` to players, enemies, bosses, destructible props, and hazards that need health.
- Add `InvincibilityBlinker.gd` to entities that need I-frame blinking.
- Add `DynamicCamera.gd` to the active Camera2D.
- Add `DebugOverlay.gd` to a debug-only CanvasLayer scene.
