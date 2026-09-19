# Customization, Debugging, Level Editing, and Objectives

This section converts the remaining higher-level systems into practical Godot 4 scripts.

## Character Customization

`CharacterCustomizer.gd` stores cosmetic options such as skin tone, hair color, outfit, and accessories. It can tint a base sprite and swap textures on layered Sprite2D nodes.

File:

- `godot/components/CharacterCustomizer.gd`

## Debug Tools

`DebugOverlay.gd` displays runtime information such as FPS, memory, player position, velocity, current scene, and any custom values you register.

File:

- `godot/debug/DebugOverlay.gd`

## Level Editor

`LevelEditor.gd` is a runtime editor utility for tile placement, object placement, deletion, and JSON save/load. It is intended as a prototype tool, not a replacement for the Godot editor.

File:

- `godot/editor/LevelEditor.gd`

## Quest/Objectives

`QuestObjectiveManager.gd` tracks active, completed, and failed objectives. It emits signals when progress changes so dialogue, UI, and level logic can respond.

File:

- `godot/autoloads/QuestObjectiveManager.gd`

## Mini-Games

`MiniGameManager.gd` provides a small framework for reusable mini-games such as time trials, puzzles, or fishing-style interactions.

File:

- `godot/autoloads/MiniGameManager.gd`
