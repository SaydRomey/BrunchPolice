# Weapon and Projectile System

## Purpose

The weapon system handles equipping, cooldowns, weapon slots, quick attacks, charged attacks, special attacks, and projectile spawning.

The projectile system handles movement, range, lifespan, collision, direct damage, and optional status effects.

## Converted Scripts

| Script                                       | Purpose                                |
| -------------------------------------------- | -------------------------------------- |
| `godot/weapons/Weapon.gd`                    | Base weapon class                      |
| `godot/projectiles/Projectile.gd`            | Base projectile class                  |
| `godot/projectiles/BaconProjectile.gd`       | Bacon-specific projectile behavior     |
| `godot/components/PlayerWeaponController.gd` | Player equipment and attack controller |
| `godot/components/BaseEnemyStatusEffects.gd` | Enemy-side status effect examples      |

## Key Improvements Over the C++ Notes

- Replaced placeholder C++ helper calls with actual Godot 4 shape queries and scene instantiation.
- Added slot compatibility rules for main-hand, off-hand, and two-hand weapons.
- Added reusable projectile status effects through `effect_data` dictionaries.
- Added signals for attack, equip, cooldown, and blocked attack feedback.
