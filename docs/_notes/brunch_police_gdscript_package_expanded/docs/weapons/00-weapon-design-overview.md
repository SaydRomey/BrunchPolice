# Weapon Design Overview

## Equipment Rules

The player normally starts with a brunch fork in the main hand. Inside levels, the player can find temporary or level-specific weapons.

The equipment model has three slot types:

| Slot Type | Role | Restrictions |
|---|---|---|
| Main hand | Primary attacks such as fork, bread slicer, knife, rolling pin, zester | One equipped at a time |
| Off hand | Utility, shield, debuff, trap, or short ranged tool | Can be used with a main-hand weapon unless a two-handed weapon is equipped |
| Two hand | Heavy or complex weapon such as lollipop hammer or syrup cannon | Replaces both main hand and off hand |

## Attack Types

Main-hand weapons usually support a quick attack and a charged attack. Off-hand items usually provide utility, shielding, traps, or debuffs. Two-handed weapons support three attacks:

| Attack | Intended Feel |
|---|---|
| Quick | Reliable attack with moderate damage and faster recovery |
| Charged | Higher damage, stronger debuff, or area effect |
| Special | Unique high-impact effect, usually reserved for two-handed weapons |

## Implementation Model

Use `godot/weapons/Weapon.gd` as the base script. It tracks cooldown, slot type, damage, projectile scene, and shared attack methods. Specific weapons extend it and override `attack_quick`, `attack_charged`, or `attack_special`.

Recommended supporting scripts:

- `godot/projectiles/Projectile.gd` for standard projectile movement, damage, and status effects.
- `godot/projectiles/BaconProjectile.gd` for bacon wrap behavior.
- `godot/components/BaseEnemyStatusEffects.gd` for enemy-side status methods.
- `godot/components/PlayerWeaponController.gd` for equipping and firing main, off-hand, or two-handed weapons.
