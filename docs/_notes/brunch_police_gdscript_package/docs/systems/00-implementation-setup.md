# Implementation Setup

## Autoloads

Add these scripts as autoloads if you want global access:

| Autoload               | Script                                    |
| ---------------------- | ----------------------------------------- |
| `Inventory`            | `godot/autoloads/Inventory.gd`            |
| `GameResourceManager`  | `godot/autoloads/GameResourceManager.gd`  |
| `ResourceManager`      | `godot/autoloads/ResourceManager.gd`      |
| `SaveManager`          | `godot/autoloads/SaveManager.gd`          |
| `SoundManager`         | `godot/autoloads/SoundManager.gd`         |
| `TimerManager`         | `godot/autoloads/TimerManager.gd`         |
| `ScoreManager`         | `godot/autoloads/ScoreManager.gd`         |
| `VisualEffectsManager` | `godot/autoloads/VisualEffectsManager.gd` |

## Input Map

Recommended input actions:

| Action                | Use                        |
| --------------------- | -------------------------- |
| `attack_main`         | Main-hand quick attack     |
| `attack_main_charged` | Main-hand charged attack   |
| `attack_offhand`      | Off-hand attack or utility |
| `attack_special`      | Two-handed special attack  |

`PlayerWeaponController.gd` exposes callable methods, so you can also trigger attacks from your existing player script instead of relying directly on input actions.

## Collision Groups

Recommended groups:

| Group               | Use                                                  |
| ------------------- | ---------------------------------------------------- |
| `player`            | Player body                                          |
| `enemy`             | All enemy bodies and enemy hurtboxes                 |
| `pastry_enemy`      | Pastry-specific bonus damage checks                  |
| `bread_enemy`       | Bread-specific instant defeat or bonus damage checks |
| `hazard_projectile` | Cleanable enemy projectiles                          |

## Weapon Scene Pattern

A weapon can be a `Node2D` child of the player or a separate scene instantiated by a pickup. Attach a weapon script such as `BaconGun.gd`, set its exported values, then assign it to `PlayerWeaponController.gd`.
