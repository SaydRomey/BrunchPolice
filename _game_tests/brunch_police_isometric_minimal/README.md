# Brunch Police — Isometric Minimal Start

Godot version: **4.4.1**

This is a minimal playable isometric brunch-area prototype. It uses generated isometric placeholder versions of your uploaded player sprites, keeping the same color-block character identity while fitting a top-down/isometric presentation.

## Included

- `project.godot`
- `scenes/Main.tscn` playable scene
- `scenes/PlayerIso.tscn` top-down/isometric player controller
- `scripts/IsoLevel.gd` procedural diamond brunch floor and props
- 5 clue pickups
- 3 syrup hazards that respawn the player
- Generated iso sprite sheets:
  - `assets/player/Iso_Idle.png`
  - `assets/player/Iso_Walk.png`
  - `assets/player/Iso_Sprint.png`
  - `assets/player/Iso_Jump.png`
  - `assets/player/Iso_Land.png`

## Controls

- Move: `WASD` or arrow keys
- Sprint: `Shift`

## Notes

The level is intentionally greybox-plus: the floor, brunch props, syrup spills, and clue pickups are generated in scripts so you can iterate quickly without importing a full tile set. Replace `IsoLevel.gd` drawing code with real isometric tiles later.
