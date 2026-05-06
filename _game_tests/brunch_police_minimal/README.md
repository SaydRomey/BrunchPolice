# Brunch Police - Minimal Playable Start

Godot version: 4.4.1

## What is included

- A Godot 4.4.1 project file.
- A basic side-scrolling player controller using the provided temporary sprites.
- Idle, walk, sprint, jump, and land animations sliced from 128x128 frames at runtime.
- One small greybox Brunch Zone test level.
- Five clue pickups.
- Syrup hazards that respawn the player.
- A simple HUD with clue count and controls.

## Controls

- Move: A/D or left/right arrows
- Jump: Space or W
- Sprint: Shift

## How to run

1. Unzip this folder.
2. Open Godot 4.4.1.
3. Import `project.godot` from the unzipped folder.
4. Press Play.

## Main files

- `scenes/Main.tscn` - playable test scene
- `scenes/Player.tscn` - player node setup
- `scripts/Player.gd` - movement and animation logic
- `scripts/Main.gd` - level, pickups, hazards, and HUD setup
- `assets/player/*.png` - temporary player sprite sheets

## Next recommended step

Replace the greybox platforms with a proper Starting Brunch Zone tileset, then add the first enemy archetype and a basic bacon-gun projectile.
