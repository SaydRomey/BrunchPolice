# Implementation Backlog

## Purpose

This file turns the organized notes into a practical build order and cleanup checklist.

## Suggested MVP order

### 1. Project foundation

- Create Godot project.
- Set up `src/`, `inc/`, `assets/`, `scenes/`, `gdnative/`, `helpers/`, `build/`, and `obj/`.
- Establish the Makefile.
- Confirm Godot C++ binding setup.
- Add initial player scene.

### 2. Player and camera

- Implement basic player movement.
- Add gravity, jump, and acceleration tuning.
- Add coyote time and jump buffering.
- Add double jump.
- Add dash.
- Add DynamicCamera follow.
- Add checkpoint and respawn.

### 3. Core systems

- Add ResourceManager.
- Add EventSystem.
- Add EventQueue.
- Add TimerManager.
- Add ScoreManager.
- Add GameResourceManager.
- Add Inventory.
- Add SaveManager.

### 4. Combat base

- Add HealthComponent.
- Add damage source dictionary.
- Add invincibility frames.
- Add projectile base.
- Add weapon base.
- Add main-hand/off-hand/two-hand equipment rules.

### 5. First playable level

- Build Pastry Palace test level.
- Add temporary weapon pickup.
- Add enemies.
- Add hazards.
- Add end trigger.
- Add world-map unlock flow.

### 6. Audio and visual feedback

- Add SoundManager.
- Add VisualEffectsManager.
- Add SpriteAnimationController.
- Add VisualFeedbackComponent.
- Add AmbianceManager.
- Add basic debug overlay.

### 7. Progression

- Add world map.
- Add level-completion tracking.
- Add save/load.
- Add boss reward weapon flow.
- Add quest/objective tracking.

### 8. Tools and polish

- Add LevelEditor.
- Add TilemapLoader improvements.
- Add Minimap.
- Add character customization.
- Add modular minigames.

## Cleanup items found in the source notes

### Naming cleanup

Potential typos or inconsistent names:

- `imventory-system.txt` should likely be `inventory-system`.
- `ressource-management-in-game.txt` should likely be `resource-management-in-game`.
- `GD World ajd Level Design` should likely be `GD World and Level Design`.
- `atrack` should likely be `attack`.
- `usualy` should likely be `usually`.
- `mouvement` should likely be `movement`.
- `cayote time` should likely be `coyote time`.
- `iver ledge` should likely be `over ledge`.

### Duplicate or overlapping files

The weapons files overlap heavily.

Exact duplicate detected:

- `_weapon-categories-and-ideas.txt`
- `weapon-categories-and-ideas.txt`

Near-duplicate or overlapping weapon files:

- `weaponsmd.txt`
- `weapons-level-specific.txt`
- `weaponslevelspecificmd.txt`
- `weaponslevelrewardmd.txt`
- `weaponsystemmd.txt`
- `weapon-bacongunmd.txt`

Recommendation: keep one canonical weapon design note and split code-specific implementations into individual weapon class notes.

### Godot API consistency

Several files mix Godot versions or API styles.

Examples to verify before implementation:

- `KinematicBody2D` versus `CharacterBody2D`.
- `Sprite` versus `Sprite2D`.
- `AnimatedSprite2D`.
- `Particle2D` versus `GPUParticles2D` or `CPUParticles2D`.
- `TileMap` method signatures.
- `move_and_slide` signatures.
- `ResourceLoader` return typing.
- `Ref<Node>` usage versus raw pointers.
- `connect` syntax.
- Lambda usage in C++98 examples, because C++98 does not support lambdas.
- `std::to_string`, because it is not C++98.

### C++98 compatibility risks

Some source examples use features not compatible with C++98:

- Lambdas.
- `nullptr`.
- Range-based `for`.
- `std::to_string`.
- Some Godot 4 API examples may require newer compiler support.

Recommendation: decide whether the project truly needs strict C++98. If yes, replace modern constructs with C++98-compatible alternatives.

### Architecture risks

- HealthComponent currently calls `queue_free` directly on death; this may remove the wrong node if the component is a child.
- TimerManager repeat timer reset logic needs original duration.
- Resource managers need careful type casting.
- Weapon files define overlapping Bacon Gun damage behavior.
- Level-specific weapon counter logic needs enemy taxonomy.
- Save/load should store versioned data.
- Visual feedback should be component-based rather than duplicated across enemies.

## Suggested canonical docs to maintain after this cleanup

- `Project_Roadmap.md`
- `Build_System.md`
- `Architecture_Overview.md`
- `Player_Controller.md`
- `Combat_And_Weapons.md`
- `Level_And_World_Design.md`
- `Audio_Visual_Feedback.md`
- `Save_Load_Inventory_Resources.md`
- `Source_Archive.md`
