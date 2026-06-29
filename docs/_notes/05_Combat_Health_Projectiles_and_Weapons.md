# Combat, Health, Projectiles, and Weapons

## Purpose

This note consolidates damage, health, invincibility frames, projectiles, weapon categories, weapon rewards, level-specific weapon logic, and the Bacon Gun.

## Source files covered

- `healthcomponentmd.txt`
- `damagecalculationsmd.txt`
- `invincibilityframesmd.txt`
- `projectilemanagermd.txt`
- `weaponsystemmd.txt`
- `weaponsmd.txt`
- `_weapon-categories-and-ideas.txt`
- `weapon-categories-and-ideas.txt`
- `weapons-level-specific.txt`
- `weaponslevelspecificmd.txt`
- `weaponslevelrewardmd.txt`
- `weapon-bacongunmd.txt`
- `combat-brainstorm.txt`

## Combat system map

| System | Role |
|---|---|
| Health Component | Health, healing, damage, and death. |
| Damage Calculation | Damage modified by source data such as weapon type and critical hits. |
| Invincibility Frames | Prevent repeated damage in a short time. |
| Visual Feedback | Communicates damage and invincibility through blinking. |
| Projectile Manager | Handles projectile movement, collisions, and damage calls. |
| Weapon System | Handles weapon cooldowns, attacks, and projectile spawning. |
| Weapon Categories | Main-hand, off-hand, and two-handed equipment rules. |
| Level-Specific Weapons | Weapons that counter specific level hazards and enemies. |
| Bacon Gun | Special immobilizing projectile behavior. |

## Health Component

The HealthComponent applies to player, enemies, bosses, and other damageable entities.

Main properties:

```cpp
float max_health;
float current_health;
```

Main operations:

- `set_max_health(health)`
- `get_current_health()`
- `take_damage(damage)`
- `heal(amount)`
- `is_dead()`

Current death behavior:

```cpp
queue_free();
```

Recommended cleanup:

- Use a signal such as `died` before freeing.
- Let boss, enemy, and player systems respond before removal.
- Avoid freeing the HealthComponent if it is attached as a child rather than the entity root.

## Damage calculation

Damage can be based on weapon stats, weapon type, critical hit status, player/enemy attributes, defense, resistances, buffs, and debuffs.

The source material proposes a `Dictionary damage_source`:

```cpp
damage_source["weapon_type"] = "bacon_gun";
damage_source["critical_hit"] = true;
```

Recommended final rule: use one canonical Bacon Gun behavior. Based on the weapon-specific file, the cleaner identity is lower or zero damage, but immobilizes or wraps enemies.

## Invincibility Frames

I-frames prevent repeated damage during a short window.

Properties:

```cpp
bool is_invincible;
float invincibility_duration;
float invincibility_timer;
```

Main operations:

- `trigger_invincibility(duration)`
- `update_invincibility(delta)`
- `take_damage(base_damage, damage_source)`

Recommended integration:

- HealthComponent owns invincibility state.
- The entity or visual feedback component listens for damage/invincibility events.
- Blinking and audio feedback should not be hardcoded directly into damage calculation.

## Projectile system

Projectile responsibilities:

- Store velocity.
- Store damage.
- Move each physics frame.
- Free itself off-screen.
- Call `take_damage` on collision.
- Destroy itself after hit.

Main properties:

```cpp
Vector2 velocity;
float damage;
float speed;
```

Main operations:

- `set_velocity(dir)`
- `set_damage(dmg)`
- `on_body_entered(body)`

Recommended future additions:

- Lifespan timer.
- Range.
- Owner/faction to prevent self-damage.
- Status-effect payload.
- Piercing or bouncing behavior.
- Object pooling.

## Base Weapon System

The weapon system handles firing logic, cooldowns, projectile spawning, and unique behavior through derived classes.

Basic properties:

```cpp
Ref<PackedScene> projectile_scene;
float cooldown;
float cooldown_timer;
```

Basic operation:

```cpp
fire(position, direction)
```

Expanded weapon category system:

```cpp
enum WeaponType {
    MAIN_HAND,
    OFF_HAND,
    TWO_HAND
};
```

Expanded attacks:

- `attack_quick`
- `attack_charged`
- `attack_special`

## Equipment rules

The weapon notes define these rules:

- The player usually has a brunch fork in the main hand.
- The player can have one main-hand weapon.
- The player can have either no off-hand item or one off-hand item.
- Off-hand items are usually utility, shield, trap, or debuff tools.
- Some heavy weapons require both hands.
- Two-handed weapons replace both main-hand and off-hand slots.
- One-handed weapons can support charged attacks.
- Two-handed weapons can support quick, charged, and special attacks.

## Weapon categories

### Main-hand weapons

- Light and fast.
- Lower damage.
- Can have charged attacks.
- Examples: Croissant Cutter, Butter Knife, Chef's Cleaver, Egg Beater, Orange Zester, Lollipop Blade, Dough Cutter.

### Off-hand items

- Utility-focused.
- Debuffs, shielding, traps, or support.
- Used alongside a main-hand weapon when compatible.
- Examples: Whipped Cream Shield, Sticky Net, Hot Lid, Yolk Bomb, Juice Squeezer, Sugar Shield, Flour Puff.

### Two-handed weapons

- Heavy or complex.
- Replace both hands.
- Support quick, charged, and special attacks.
- Examples: Baguette Maul, Syrup Cannon, Rolling Pin Roller, Frying Pan, Citrus Blaster, Candy Floss Launcher, Bread Roller.

## Enemy-size effect scaling

The combat brainstorm proposes size-based weapon effects.

Example: Bacon Gun

- Small enemy: killed.
- Medium enemy: damaged and wrapped, or killed on critical damage.
- Large or mob enemy: damaged only.
- Boss: immune or receives damage only.

This can become a general `EffectResistance` or `EnemyCategory` system.

## Level-specific temporary weapons

### 1. Pastry Palace — Bread Slicer

High-speed melee weapon that slices multiple enemies at short range.

Counter logic:

- Rolls through bread-themed enemies.
- Instantly defeats pastry enemies.
- Heavy damage to non-pastry enemies with slower attacks.

### 2. Sticky Syrup Swamp — Butter Knife

Melee weapon that makes enemies slippery.

Counter logic:

- Prevents syrup golems from charging effectively.
- Turns butter pats into hazards for other enemies.

### 3. Kitchen Mayhem — Dishwasher Sprayer

Ranged water weapon.

Counter logic:

- Washes knife attacks out of the air.
- Pushes sponges and ladles away.
- Cleans obstacles.

### 4. Egg Factory Frenzy — Egg Whisk

Spinning melee weapon.

Counter logic:

- Destroys egg drones and yolk bombs.
- Deals continuous damage during spin.

### 5. Citrus Cascade — Zester Shooter

Ranged citrus-zest weapon.

Counter logic:

- Blinds lemon bats.
- Dries juice hazards.

### 6. Candy Chaos — Lollipop Hammer

Heavy two-handed weapon.

Counter logic:

- Crushes gummy bears.
- Can safely move cupcake bombs.

### 7. Bakery Bonanza — Dough Roller

Flattening melee weapon.

Counter logic:

- Neutralizes flour puffs.
- Stuns rolling muffin trays.

## Level reward weapons

The reward-weapons notes propose these boss reward weapons:

1. Pastry Palace — Whipped Cream Cannon.
2. Sticky Syrup Swamp — Syrup Launcher.
3. Kitchen Mayhem — Rolling Pin.
4. Egg Factory Frenzy — Egg Launcher.
5. Citrus Cascade — Citrus Blaster.
6. Candy Chaos — Gummy Bear Grenade.
7. Bakery Bonanza — Flour Blaster.

These can be stored in inventory and reused in later levels.

## Bacon Gun

The Bacon Gun is a special weapon that fires bacon projectiles.

Primary behavior:

- Projectile collides with enemies.
- If the enemy supports `apply_bacon_wrap`, call it.
- Enemy becomes wrapped.
- Enemy is immobilized.
- Enemy sprite changes to a bacon-wrap texture.
- A timer removes the effect after a duration.

Important design note from the source:

- The Bacon Gun may do less damage because immobilization is powerful.
- One implementation sets projectile damage to `0.0f`.

## Additional weapon ideas

The source files include expanded weapon lists by level and category. Consolidated examples:

### Pastry Palace

Main-hand: Cake Cutter Dagger, Frost Edge Knife.

Off-hand: Jam Jar Grenade, Butter Spray Can.

Two-handed: Bakery Mixer Staff, Layer Cake Greatsword.

### Sticky Syrup Swamp

Main-hand: Honey Comb Blade, Maple Saber.

Off-hand: Sugar Cube Bomb, Sticky Syrup Globe.

Two-handed: Molasses Mallet, Caramel Whip.

### Kitchen Mayhem

Main-hand: Paring Knife, Chef's Skewer.

Off-hand: Pepper Grinder, Hot Sauce Flask.

Two-handed: Stock Pot Shield, Chopping Board Axe.

### Egg Factory Frenzy

Main-hand: Eggshell Knife, Egg Scrambler Blade.

Off-hand: Salt Shaker, Egg Yolk Grenade.

Two-handed: Omelet Spatula, Egg Beater Staff.

### Citrus Cascade

Main-hand: Citrus Saber, Peeler Knife.

Off-hand: Zest Grenade, Lime Shield.

Two-handed: Juicer Staff, Orange Flail.

### Candy Chaos

Main-hand: Gum Blade, Candy Cane Dagger.

Off-hand: Chocolate Bomb, Sugar Rush Injector.

Two-handed: Marshmallow Launcher, Candy Floss Hammer.

### Bakery Bonanza

Main-hand: Rolling Pin Blade, Dough Hook.

Off-hand: Flour Cloud Bomb, Dough Ball Trap.

Two-handed: Oven Door Shield, Dough Roller Staff.

## Recommended combat implementation order

1. HealthComponent.
2. Damage source dictionary.
3. I-frames.
4. Projectile base class.
5. Weapon base class.
6. Main-hand/off-hand/two-hand equipment logic.
7. Level-specific weapon behavior.
8. Enemy status effects.
9. Visual feedback and audio feedback.
10. Boss reward inventory integration.
