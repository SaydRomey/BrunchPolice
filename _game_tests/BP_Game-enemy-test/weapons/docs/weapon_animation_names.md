# Weapon Animation Names

The WeaponController calls:

`player.play_directional_animation(weapon.attack_animation_base)`

So if a weapon has `attack_animation_base = "attack"`, your AnimatedSprite2D should contain:

- `attack_south`
- `attack_east`
- `attack_west`
- `attack_north` for hub/top-down

If a weapon has `attack_animation_base = "shoot"`, add:

- `shoot_south`
- `shoot_east`
- `shoot_west`
- `shoot_north` for hub/top-down

If an animation is missing, your Player script may fall back or print a missing animation warning depending on the version you use.
