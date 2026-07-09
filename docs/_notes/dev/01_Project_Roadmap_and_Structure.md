# Project Roadmap and Structure

## Purpose

These notes establish the overall direction for Brunch Police: a Godot-based game using C++/C++98-style systems for reusable game logic, with a hub, platformer levels, combat, dialogue, inventory, save/load, and themed level mechanics.

## Source files covered

- `development.txt`
- `file-structure.txt`
- `integration-steps.txt`
- `using-c-and-c.txt`
- `godot-c-noob-guide.txt`
- `getting-started-with-brunch-police-using-godot-and-c-on-linux.txt`

## Development phases

### Phase 1: Pre-production

Define the project scope before implementation.

Core planning items:

- Write or maintain a concise Game Design Document.
- List all major features: hub area, platformer levels, dialogue system, boss fights, level-specific weapons, inventory, save/load, UI, audio, and visual effects.
- Prioritize the Minimum Viable Product.
- Set up Godot, GitHub/version control, asset tools, audio tools, and project management.
- Identify placeholder assets for characters, levels, props, sounds, and UI.
- Plan core programming systems before building them.

### Phase 2: Development

Build the game in modular layers.

Recommended sequence:

1. Set up the Godot project and folder structure.
2. Implement hub world movement and NPC interaction.
3. Implement dialogue and plate inspection interactions.
4. Add scene transitions from hub to platformer levels.
5. Build basic platformer movement.
6. Add enemies, hazards, pickups, and power-ups.
7. Add boss fight logic.
8. Add persistent progression through singleton/global game data.
9. Integrate inventory, resources, and save/load.

### Phase 3: Testing and polishing

Focus testing on:

- Movement feel.
- Platforming difficulty.
- Dialogue triggers.
- Level transitions.
- Boss fights.
- Resource and inventory persistence.
- Performance issues in scenes with many active nodes.

Use Godot's profiler to identify slow areas.

### Phase 4: Packaging and launch

Export builds for Linux, Windows, and macOS. Later launch planning includes a trailer and publishing on platforms such as Steam or itch.io.

## Suggested project structure

The source material proposes this general structure:

```text
brunch_police/
├── src/
│   ├── core/
│   ├── utils/
│   ├── levels/
│   └── main.cpp
├── inc/
│   ├── core/
│   ├── utils/
│   └── levels/
├── obj/
├── build/
├── gdnative/
├── assets/
│   ├── sprites/
│   ├── audio/
│   └── backgrounds/
├── scenes/
│   ├── levels/
│   └── characters/
├── helpers/
├── shaders/
├── Makefile
├── README.md
└── LICENSE
```

## Core directories

`src/` stores C++ source files. Suggested subdivisions include:

- `core/` for Game, Player, Enemy, Boss, Weapon, Inventory, DialogueSystem, and SaveSystem.
- `utils/` for Timer, ResourceManager, AudioManager, and VisualEffects.
- `levels/` for level-specific logic such as GreaseCanyon, PastryPalace, StickySyrupSwamp, KitchenMayhem, CandyChaos, EggFactoryFrenzy, CitrusCascade, and BakeryBonanza.

`inc/` mirrors the source layout with headers.

`build/` contains platform outputs such as `.so`, `.dylib`, or `.dll`.

`gdnative/` contains Godot-specific native script configuration.

`assets/` contains sprites, audio, backgrounds, and other game assets.

`scenes/` contains Godot scene files.

`helpers/` contains platform-specific Makefile helpers.

`shaders/` contains visual-effect shaders.

## Godot and C++ integration

The notes mention GDNative and Godot C++ bindings. The general workflow is:

1. Install Godot.
2. Install build tools such as `build-essential`, `python3-pip`, `scons`, and `clang` on Linux.
3. Clone `godot-cpp`.
4. Initialize submodules.
5. Build C++ bindings.
6. Write C++ classes.
7. Compile them into a shared library.
8. Create `.gdnlib` and `.gdns` configuration files.
9. Attach the native script to nodes in Godot.

## Beginner Godot concepts

Key concepts from the source notes:

- Nodes are the building blocks of a Godot project.
- Scenes are collections of nodes.
- Resources are reusable assets such as textures, audio, and scripts.
- C++ can be integrated through GDNative or custom engine modules.
- GDNative avoids recompiling the Godot engine itself.

## Integration guidelines

The source material recommends:

- Use abstract base classes for shared interfaces such as `IDamageable` and `IInteractable`.
- Use JSON or text configuration files for enemy stats, quest details, and tunable parameters.
- Expose configurable variables to Godot through GDNative or script bindings.
- Keep systems modular so they can be reused across Brunch Police or future projects.
