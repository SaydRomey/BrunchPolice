# Weapon Asset Pipeline

Create four asset types for each weapon:

1. Inventory icon: small UI icon, usually 32x32.
2. Pickup sprite: world object the player can collect.
3. Held sprite: optional weapon overlay attached to Player/WeaponController/HeldWeaponSprite.
4. Projectile/VFX sprites: shots, slash arcs, hit sparks, wrap effects, shield effects.

Recommended names:

- `weapon_id_icon.png`
- `weapon_id_pickup.png`
- `weapon_id_held.png`
- `weapon_id_projectile.png`
- `weapon_id_hit_vfx.png`

For player animation support, add animation bases such as:

- `attack_south`, `attack_east`, `attack_west`, `attack_north`
- `shoot_south`, `shoot_east`, `shoot_west`, `shoot_north`

Platformer levels can omit north if you are not climbing/aiming upward yet. Hub/top-down scenes should eventually include north.
