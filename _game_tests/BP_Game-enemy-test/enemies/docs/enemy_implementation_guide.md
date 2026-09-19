# Enemy Implementation Guide

## Class stack

```text
BaseEnemy
├── PlatformerPatrolEnemy
│   ├── SmallAngryPig
│   └── RangedPlatformerEnemy
└── FlyingEnemy
    └── FlyingSausageLink
```

## Add a new ground enemy

1. Create a new script extending `PlatformerPatrolEnemy`.
2. Override `_ready()` to set identity defaults.
3. Override `update_chasing()` or `update_attacking()` only if behavior differs.
4. Create a scene using `CharacterBody2D`.
5. Add:
   - CollisionShape2D
   - AnimatedSprite2D
   - ContactDamageArea
   - FloorRayLeft
   - FloorRayRight
   - WallRayLeft
   - WallRayRight

## Add a new flying enemy

1. Extend `FlyingEnemy`.
2. Set `apply_gravity = false`.
3. Tune:
   - hover_amplitude
   - hover_frequency
   - swoop_speed
   - return_speed

## Add a ranged enemy

Use `RangedPlatformerEnemy`.

Required export:

```text
projectile_scene
```

Use:

```text
res://enemies/scenes/enemy_projectile.tscn
```

as a starting point.

## EnemyData resources

`EnemyData` resources are optional. You can tune enemies directly on scenes first.

Later, create resources for consistent balancing:

```text
enemies/data/small_angry_pig.tres
enemies/data/flying_sausage_link.tres
enemies/data/knife_throwing_chef.tres
```

## Bosses

Do not build bosses as simple `BaseEnemy` children unless they are temporary placeholders.

Bosses need:
- phase logic
- custom arena triggers
- invulnerability windows
- unique attacks
- cutscene/flee behavior

Use this package for regular enemies and mini-enemy variants.
