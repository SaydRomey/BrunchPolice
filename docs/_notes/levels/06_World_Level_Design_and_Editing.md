# World, Level Design, and Editing

## Purpose

This note consolidates world-map structure, level transitions, level scene design, tilemap loading, level editing, minimap design, quest/objective tracking, and modular minigame systems.

## Source files covered

- `gd-world-ajd-level-design.txt`
- `level-editor-system.txt`
- `tilemap-loader.txt`
- `minimap-system.txt`
- `modular-minigame-systems.txt`
- `quest-objective-system.txt`

## World map

The world map connects levels logically and controls progression.

World map features:

- Nodes representing levels.
- Sequential unlocking.
- Completed-level indicators.
- Optional visual icons or animations.

Example level list:

```text
Pastry Palace
Sticky Syrup Swamp
Kitchen Mayhem
Egg Factory Frenzy
Citrus Cascade
Candy Chaos
Bakery Bonanza
```

## Level progression

Each level should support locked/unlocked state, completed state, transition into level, transition back to world map, and unlocking the next level after completion.

Recommended global state:

```text
current_level
completed_levels
unlocked_levels
defeated_bosses
collected_items
```

## Level transitions

Use a shared transition layer for fade in, fade out, scene changes, and level summaries.

The source notes use a `CanvasLayer`, `ColorRect`, and `Tween`.

## Level structure

Each level should include gameplay area, platforms, hazards, enemies, temporary weapon pickup, objective or exit point, camera, and HUD.

Example scene:

```text
Node2D (PastryPalace)
├── TileMap (Platforms)
├── Position2D (PlayerSpawn)
├── Area2D (WeaponPickup)
├── Area2D (LevelEndTrigger)
├── Enemies (Node2D)
│   ├── Enemy1
│   └── Enemy2
├── Camera2D
└── HUD (CanvasLayer)
```

## Level completion logic

On level completion:

1. Mark current level complete.
2. Unlock the next level.
3. Save progress.
4. Return to world map or continue to next scene.

## Player death and reset

The source notes use:

```gdscript
get_tree().reload_current_scene()
```

Recommended future behavior:

- Use checkpoint system where appropriate.
- Restore player state.
- Restore temporary weapon state if intended.
- Trigger respawn effects.
- Avoid hard-resetting global progress.

## Tilemap Loader

The Tilemap Loader supports dynamic tilemap loading, visual and collision layers, parallax background support, and procedural generation as a future extension.

Main pieces:

```cpp
String tilemap_path;
TileMap *visual_layer;
TileMap *collision_layer;
```

Main operations:

- `load_tilemap(tilemap_path)`
- `load_layer(layer_path, layer)`
- `enable_parallax_scrolling(background, parallax_factor)`

Recommended cleanup:

- Confirm Godot version naming for `TileMap` methods.
- Implement the missing `on_player_position_changed` behavior.
- Avoid assuming tilemaps are always split into `_visuals.tres` and `_collision.tres`.

## Level Editor System

The Level Editor supports tile placement, tile removal, object placement, object deletion, save/load level layouts, in-game editing mode, and real-time testing mode.

Main components:

1. Level Editor Manager.
2. Tilemap Editor.
3. Object Editor.

Important properties:

```cpp
Ref<TileMap> tilemap;
std::map<String, Ref<PackedScene>> object_templates;
std::vector<Node2D *> placed_objects;
String current_tool;
int current_tile_id;
Ref<PackedScene> current_object;
```

Main operations:

- `set_tilemap`
- `select_tile`
- `place_tile`
- `remove_tile`
- `preload_object`
- `select_object`
- `place_object`
- `remove_object`
- `save_level`
- `load_level`
- `set_tool`

## Minimap System

The minimap supports a round frame, player-centered display, rotating player arrow, adjustable zoom, toggle on/off, points of interest, and environmental features such as walls and paths.

Main properties:

```cpp
Ref<Viewport> minimap_viewport;
Ref<Sprite> minimap_frame;
Ref<Node2D> minimap_content;
Ref<Sprite> player_arrow;
float zoom_level;
bool is_visible;
```

Main operations:

- `set_frame`
- `set_player_arrow`
- `set_zoom`
- `toggle_minimap`
- `update_player_position`
- `add_point_of_interest`
- `remove_point_of_interest`

Recommended future additions:

- Objective icons.
- Enemy icons.
- Fog-of-war.
- Level boundary display.
- Minimap legend.

## Quest and Objective System

The quest/objective note defines active objectives, completed objectives, failed objectives, dialogue integration, and dynamic quest updates based on player actions.

Recommended quest fields:

```text
id
title
description
status
objectives
rewards
start_condition
completion_condition
failure_condition
```

Recommended events:

- `quest_started`
- `objective_updated`
- `quest_completed`
- `quest_failed`

## Modular Minigame Systems

Reusable side-activity systems include:

- Puzzle System: tile-matching or object rotation.
- Time Trials: timers for race-style challenges.
- Fishing System: simple reusable fishing mechanics for RPG/adventure gameplay.

These should integrate with Timer Manager, Quest System, Score Manager, Resource Manager, and Save/Load.
