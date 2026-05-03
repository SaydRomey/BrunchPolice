# Player Combat, Health, Damage, Projectiles, and Feedback

# 11. Combat, Damage, Health, Projectile, and Feedback Systems

## 11.1 Health Component

Current HealthComponent responsibility:

- Handles health, damage, and death for player, enemies, and bosses.
- Stores max health and current health.
- Allows setting max health.
- Returns current health.
- Takes damage.
- Heals.
- Checks whether entity is dead.
- On zero health, current code calls `queue_free()`.

## 11.2 Damage Calculation

Current damage system direction:

- Damage can be calculated based on weapon stats.
- Damage can use weapon damage values, modifiers, critical hits.
- Damage can include player/enemy attributes such as defense, resistance, and buffs.
- HealthComponent should accept source-based damage via:
  - `base_damage`
  - `damage_source` dictionary
- Example damage source fields:
  - `weapon_type`
  - `critical_hit`
- Example specific modifier:
  - `weapon_type == bacon_gun` can modify final damage.

## 11.3 Invincibility Frames

Current i-frame purpose:

- Prevent repeated damage in a short time.
- Provide visual/audio feedback.
- Can be implemented directly in HealthComponent or a separate state system.
- Uses:
  - `is_invincible`
  - `invincibility_duration`
  - `invincibility_timer`
  - `trigger_invincibility(duration)`
  - `update_invincibility(delta)`
- Example default duration: 1.0 second.

## 11.4 Visual Feedback / Blinking

Current visual feedback purpose:

- Notify player or user that entity is invincible.
- Provide immediate feedback when damage is taken.
- Implement in entity main script or Sprite node.
- Trigger through HealthComponent.
- Blinking example:
  - Toggle Sprite visibility every 0.1 seconds.
  - Stop after invincibility duration.
  - Ensure visibility is restored after blinking.

## 11.5 Projectile Manager

Current Projectile system:

- Projectiles handle their own movement, collisions, and damage.
- Supports multiple projectile types, e.g. bullets, rockets, magic spells, food projectiles.
- Tracks:
  - Velocity.
  - Damage.
  - Speed.
  - Range / lifespan concept.
- Functions:
  - `_physics_process(delta)` moves projectile.
  - `set_velocity(dir)` normalizes direction.
  - `set_damage(dmg)` sets damage.
  - `on_body_entered(body)` calls `take_damage` if available.
  - Projectile destroys itself after hit.
  - Projectile destroys itself when off-screen.

### Existing / Implied Projectile Types

- Bacon Gun strip projectile.
- Whipped cream projectile.
- Knife projectile.
- Jellybean projectile.
- Yolk bomb.
- Juice jet.
- Orange grenade / citrus blast.
- Syrup projectile.
- Flour cloud projectile / puff.
- Explosive candy.
- Explosive muffin.

---
