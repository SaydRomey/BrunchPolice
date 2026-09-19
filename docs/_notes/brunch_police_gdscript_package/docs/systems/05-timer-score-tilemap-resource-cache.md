# Timer, Score, Tilemap, and Asset Resource Cache

## Timer Manager

`TimerManager.gd` schedules one-shot or repeating callbacks. The original reset bug in the C++ concept was fixed by storing both `duration` and `remaining` time.

## Score Manager

`ScoreManager.gd` stores the current score and emits a signal when it changes.

## Tilemap Loader

`TilemapLoader.gd` supports loading level scenes, clearing current level content, assigning tilesets to TileMap nodes, and basic parallax tracking.

## Resource Manager

`ResourceManager.gd` loads and caches assets by path so textures, sounds, scenes, tilemaps, and UI resources are not repeatedly loaded.

## Converted Scripts

| Script                               | Purpose                                  |
| ------------------------------------ | ---------------------------------------- |
| `godot/autoloads/TimerManager.gd`    | Delayed and repeating callbacks          |
| `godot/autoloads/ScoreManager.gd`    | Score tracking                           |
| `godot/components/TilemapLoader.gd`  | Level scene/tilemap loading and parallax |
| `godot/autoloads/ResourceManager.gd` | Asset cache                              |
