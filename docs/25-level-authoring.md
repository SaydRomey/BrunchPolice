# Level Composition, Reusable Elements and Editor Workflow

## Level scene layout

```text
LevelRoot (Node2D)
├── Background / Parallax
├── Geometry (TileMapLayer / authored platforms)
├── Interactables (valves, switches, pickups, checkpoints)
├── Hazards (crushers, steam, rolling/falling objects)
├── Enemies / Spawners
├── EncounterControllers
├── PlayerSpawn / CheckpointMarkers
├── BossArena
└── CameraVolumes / SceneTriggers
```

`CanvasLayer` gameplay UI is managed by the mode's UI shell and actor adapter, not embedded as many copies inside level props.

## Reusable scene categories

Static/one-way/bounce/moving/collapsing/sinking platforms; slippery/sticky surfaces; conveyors; swing ropes; periodic splash; damage zone; crushers; rolling/falling hazards; pushback or launch jets; explosions; timed spawn; switches and encounter phases; checkpoints; exits and collectables. See the [element reference](reference/level-elements.md).

## Inspector-first design

Every element exposes `element_id`, label, appearance preset, texture, modulation, dimensions, collision enabled, debug label visibility/position and behavior-specific fields. A themed variant should be a Resource preset or inherited scene, not a duplicated behavior script.

## Caffeine specialization

The pressure-cycle controller owns four phase states and broadcasts `phase_changed(phase)` to gauges, vents and sound. Individual vents define `mode` (`damage`, `horizontal_push`, `vertical_launch`), direction, magnitude, safe warning frames and phase gating. A valve may delay a phase, redirect flow or open an optional route. Foam platforms use collapse timing; cup/saucer platforms use wobble/tilt without unpredictable collision changes.

## Authoring passes

1. Graybox collision and player jumps.
2. Place one isolated mechanic tutorial with safe recovery.
3. Compose escalation and optional branch using reusable element scenes.
4. Add enemies only after hazard readability has been verified.
5. Place checkpoints and fail-safe reset triggers.
6. Add themed sprites/animations, cues and boss arena patterns.
7. Run the acceptance matrix and instrument deaths, retries and route completion.

## Optional in-game editor

A runtime level editor may place tiles/scenes, adjust exported properties, save authored layouts and reload them. It must validate IDs/paths and never write arbitrary executable script into player save data. Editing features remain developer tools unless specifically made part of the shipped game.
