# Bacon Gun

## Concept

The Bacon Gun fires a bacon projectile that wraps enemies instead of dealing heavy direct damage. Its main value is crowd control.

## Behavior

1. Player fires a bacon projectile.
2. Projectile collides with an enemy.
3. Enemy receives `apply_bacon_wrap(duration)`.
4. Enemy movement stops for the duration.
5. Optional visual feedback can tint the enemy or swap to a wrapped sprite.
6. The wrap expires and normal movement returns.

## GDScript Files

- Weapon: `godot/weapons/BaconGun.gd`
- Projectile: `godot/projectiles/BaconProjectile.gd`
- Enemy status methods: `godot/components/BaseEnemyStatusEffects.gd`

## Scene Setup

Create a `BaconProjectile.tscn` scene:

- Root: `Area2D`
- Child: `CollisionShape2D`
- Optional child: `Sprite2D` or `AnimatedSprite2D`
- Script: `BaconProjectile.gd`

Assign that scene to the `projectile_scene` export on a `BaconGun` node or scene.
