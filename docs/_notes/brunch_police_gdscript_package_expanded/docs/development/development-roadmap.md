# Brunch Police Development Roadmap

## Phase 1: Pre-Production

Define the MVP and keep the scope controlled. The first playable target should prove the loop:

1. Explore the brunch hub.
2. Inspect plates and talk to NPCs.
3. Identify a culprit.
4. Trigger a platformer chase level.
5. Defeat a boss.
6. Return to the hub with progression saved.

Set up the Godot project with a consistent folder structure:

```text
res://
  assets/
  audio/
  scenes/
  scripts/
    autoloads/
    components/
    weapons/
    projectiles/
    ui/
  levels/
  data/
```

## Phase 2: Core Gameplay

Build the core loop in this order:

1. Player movement for hub and platformer modes.
2. Interaction system and dialogue box.
3. Plate inspection scene.
4. Scene transition from hub to platformer level.
5. Platformer movement, hazards, and basic enemies.
6. Weapon, projectile, health, and damage systems.
7. Boss encounter prototype.
8. Save/load and checkpoint integration.

## Phase 3: Content Production

Once the systems work, build one complete vertical slice level before producing every level. Recommended vertical slice:

- Hub interaction.
- Pastry Palace or Grease Canyon platformer segment.
- One level-specific weapon.
- One boss.
- One reward or unlock.

## Phase 4: Polish and Testing

Use the debug overlay, event system, and level editor utilities to test quickly. Replace placeholder art and sound only after controls, combat, and level pacing are stable.

## Phase 5: Packaging

Create builds through Godot export presets. Test on each target platform with clean save data, old save data, controller input, and keyboard input.
