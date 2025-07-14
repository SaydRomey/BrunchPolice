> W.I.P.

# Weapons

[Weapons - Level Specific](./weapons-level-specific.md)  
[Weapons - Level Reward](./weapons-level-reward.md)  
[Weapons - Bacon Gun](./weapons-bacon-gun.md)  
[Damage Calculation](./damage-calculations.md)  
[Health Component](./health-component.md)  
[Invincibility Frames](./invincibility-frames.md)  
[Projectile Manager](./projectile-manager.md)  
[Visual Feedback](./visual-feedback.md)

---

## Ideas

### Enemy categories for level of effect of weapons

ex. with bacon gun (throws a slice of bacon doing damage and wrapping target in bacon, immobilizing the enemy):
- A small enemy would get killed.
- A medium enemy would receive damage and be wrapped (or killed if damage is critical).
-A large enemy or mob enemy (like bats or bees) would receive damage only.
- A boss might be immune or receive damage.

---

## Weapon System

A modular class for equipping and using weapons:

- Weapon attributes: fire rate, damage, ammo capacity.

- Different weapon types (e.g., melee, ranged, area-of-effect).

- Swappable weapon functionality.

---

Weapons manage firing logic, cooldowns, and the spawning of projectiles.  
Each weapon can have unique behaviors by extending the base class.

---

### Weapon Base Class

Header File (Weapon.h)
```cpp
#ifndef WEAPON_H
#define WEAPON_H

#include <godot_cpp/classes/node.hpp>
#include <godot_cpp/classes/packed_scene.hpp>

using namespace godot;

class Weapon : public Node {
    GDCLASS(Weapon, Node);

protected:
    Ref<PackedScene> projectile_scene;
    float cooldown;
    float cooldown_timer;

public:
    void _init();
    void _ready();
    void _process(float delta);

    void fire(Vector2 position, Vector2 direction);
};

#endif // WEAPON_H
```

Implementation File (Weapon.cpp)
```cpp
#include "Weapon.h"

void Weapon::_init() {
    cooldown = 0.5f;
    cooldown_timer = 0.0f;
}

void Weapon::_ready() {
    projectile_scene = ResourceLoader::get_singleton()->load("res://scenes/Projectile.tscn");
}

void Weapon::_process(float delta) {
    if (cooldown_timer > 0) {
        cooldown_timer -= delta;
    }
}

void Weapon::fire(Vector2 position, Vector2 direction) {
    if (cooldown_timer <= 0 && !projectile_scene.is_null()) {
        Node2D *projectile = cast_to<Node2D>(projectile_scene->instantiate());
        if (projectile) {
            get_parent()->add_child(projectile);
            projectile->set_position(position);

            if (projectile->has_method("set_velocity")) {
                projectile->call("set_velocity", direction);
            }
        }
        cooldown_timer = cooldown; // Reset cooldown
    }
}
```

---

## Weapon Categories

1. **Main-Hand Weapons**

   - **Quick Attack**: Light and fast, with lower damage.
   - **Charged Attack**: Slower but deals higher damage or has added effects.

2. **Off-Hand Items**

   - Focused on utility effects like debuffs, shielding, or traps.
   - Can be used alongside the main-hand weapon.

3. **Two-Handed Weapons**

   - Heavy or complex weapons that replace both main-hand and off-hand slots.
   - **Three Attacks**:
     1. Quick Attack: Moderate damage, faster recovery.
     2. Charged Attack: High damage or AoE.
     3. Special Attack: Unique effect or massive damage.

---

## Weapon Examples by Level

### 1. Pastry Palace

- **Main-Hand**: *Croissant Cutter*  
  Quick slices against pastry enemies, charged attack cleaves through multiple foes.

- **Off-Hand**: *Whipped Cream Shield*  
  Absorbs damage and slows nearby enemies with cream splashes.

- **Two-Handed**: *Baguette Maul*  
  A heavy baguette club with:
  1. Quick strikes.
  2. Charged crushing blows.
  3. Special: Creates a shockwave that knocks enemies back.

---

### 2. Sticky Syrup Swamp

- **Main-Hand**: *Butter Knife*  
  Quick slashes to butter enemies, charged attack applies a slippery debuff.

- **Off-Hand**: *Sticky Net*  
  Throws a sticky trap that immobilizes enemies for a short time.

- **Two-Handed**: *Syrup Cannon*  
  Fires syrup globs with:
  1. Small sticky projectiles (quick).
  2. A large syrup pool (charged).
  3. Special: Creates a syrup explosion.

---

### 3. Kitchen Mayhem

- **Main-Hand**: *Chef's Cleaver*  
  Quick swings, charged attacks creates a chopping wave.

- **Off-Hand**: *Hot Lid*  
  Blocks incoming damage and pushes back enemies when hit.

- **Two-Handed**: *Rolling Pin Roller*  
  Rolls over enemies with:
  1. A fast roll.
  2. A charged flattening attack.
  3. Special: Creates a massive knockback effect.

---

### 4. Egg Factory Frenzy

- **Main-Hand**: *Egg Beater*  
  Quick spinning attacks, charged attacks stuns enemies.

- **Off-Hand**: *Yolk Bomb*  
  Throws a small bomb that slows and damages enemies on impact.

- **Two-Handed**: *Frying Pan*  
  A massive pan with:
  1. Quick slams.
  2. Charged overhead smash.
  3. Special: AoE shockwave.

---

### 5. Citrus Cascade

- **Main-Hand**: *Orange Zester*  
  Fast cuts with acidic damage, charged attack blinds enemies.

- **Off-Hand**: *Juice Squeezer*  
  Creates slippery patches on the ground to trip enemies.

- **Two-Handed**: *Citrus Blaster*  
  Fires acidic streams:
  1. Quick streams for damage.
  2. Charged AoE splash.
  3. Special: Pushes all enemies back.

---

### 6. Candy Chaos

- **Main-Hand**: *Lollipop Blade*  
  Quick candy slices, charged attacks, create sticky traps.

- **Off-Hand**: *Sugar Shield*  
  Blocks attack and releases sugar bursts when struck.

- **Two-Handed**: *Candy Floss Launcher*  
  Fires sticky candy clouds:
  1. Quick bursts.
  2. Charged sticky explosions.
  3. Special: Creates a massive candy storm.

---

### 7. Bakery Bonanza

- **Main-Hand**: *Dough Cutter*  
  Fast cuts, charged attacks creates flying dough slashes.

- **Off-Hand**: *Flour Puff*  
  Creates a flour cloud that blinds and slows enemies.

- **Two-Handed**: *Bread Roller*  
  Heavy bread roller with:
  1. Quick rolling attacks.
  2. Charged flattening rolls.
  3. Special: Spins and knocks back enemies.

---

## Implementation Plan

### Weapon Handling System

**Weapon Categories:**

```cpp
enum WeaponType {
    MAIN_HAND,
    OFF_HAND,
    TWO_HAND
};
```

---

### Base Weapon Class

**Header File (Weapon.h)**

```cpp
#ifndef WEAPON_H
#define WEAPON_H

#include <godot_cpp/classes/node.hpp>

using namespace godot;

class Weapon : public Node {
    GDCLASS(Weapon, Node);

protected:
    WeaponType weapon_type;
    float cooldown;
    float cooldown_timer;

public:
    void _init();
    void _process(float delta);
    virtual void attack_quick(Vector2 position, Vector2 direction);
    virtual void attack_charged(Vector2 position, Vector2 direction);
    virtual void attack_special(Vector2 position, Vector2 direction);
    WeaponType get_weapon_type() const;
};

#endif // WEAPON_H
```

**Implementation File (Weapon.cpp)**

```cpp
#include "Weapon.h"

void Weapon::_init() {
    cooldown = 0.5f;
    cooldown_timer = 0.0f;
}

void Weapon::_process(float delta) {
    if (cooldown_timer > 0) {
        cooldown_timer -= delta;
    }
}

void Weapon::attack_quick(Vector2 position, Vector2 direction) {
    // Default quick attack logic
}

void Weapon::attack_charged(Vector2 position, Vector2 direction) {
    // Default charged attack logic
}

void Weapon::attack_special(Vector2 position, Vector2 direction) {
    // Only for two-handed weapons
}

WeaponType Weapon::get_weapon_type() const {
    return weapon_type;
}
```

---

### Player Weapon Logic

**Equipping Weapons**

```cpp
void Player::equip_weapon(Ref<Weapon> new_weapon) {
    if (new_weapon->get_weapon_type() == TWO_HAND) {
        equipped_main_hand = new_weapon;
        equipped_off_hand = nullptr; // Two-handed weapons replace off-hand
    } else if (new_weapon->get_weapon_type() == MAIN_HAND) {
        equipped_main_hand = new_weapon;
    } else if (new_weapon->get_weapon_type() == OFF_HAND) {
        equipped_off_hand = new_weapon;
    }
}
```

---

### Weapon Examples

**Croissant Cutter**

```cpp
void CroissantCutter::attack_quick(Vector2 position, Vector2 direction) {
    // Quick slash logic
}

void CroissantCutter::attack_charged(Vector2 position, Vector2 direction) {
    // Cleaving slash logic
}
```

**Whipped Cream Shield**

```cpp
void WhippedCreamShield::attack_quick(Vector2 position, Vector2 direction) {
    // Slow down enemies nearby
}
```

**Baguette Maul**

```cpp
void BaguetteMaul::attack_quick(Vector2 position, Vector2 direction) {
    // Quick swing logic
}

void BaguetteMaul::attack_charged(Vector2 position, Vector2 direction) {
    // Heavy swing with knockback
}

void BaguetteMaul::attack_special(Vector2 position, Vector2 direction) {
    // Shockwave logic
}
```

---

## Additional Weapon Suggestions by Level

These weapons are designed to counter the enemies and mechanics of each level, providing varied gameplay rather than mirroring enemy attacks.

---

### 1. Pastry Palace

#### Main-Hand Weapons

- **Cake Cutter Dagger**  
  A quick blade designed to slice through rolling pastries.  
  - *Quick Attack*: Light slices.  
  - *Charged Attack*: Multi-hit combo for rolling enemies.

- **Frost Edge Knife**  
  A cold knife that slows pastry enemies on hit.  
  - *Quick Attack*: Deals damage and slows.  
  - *Charged Attack*: Freezes a single enemy briefly.

#### Off-Hand Items

- **Jam Jar Grenade**  
  Throws jam grenades that slow enemies in a small AoE.  
  - *Debuff*: Slows enemies' movement.

- **Butter Spray Can**  
  Sprays butter on nearby enemies, making them slip and lose balance.  
  - *Debuff*: Temporarily disables attacks.

#### Two-Handed Weapons

- **Bakery Mixer Staff**  
  A staff that spins to blend enemies into oblivion.  
  - *Quick Attack*: Swings the mixer.  
  - *Charged Attack*: Spins to pull enemies in.  
  - *Special*: Launches a doughy projectile.

- **Layer Cake Greatsword**  
  A heavy sword that crushes pastry enemies in one hit.  
  - *Quick Attack*: Heavy swing.  
  - *Charged Attack*: Cleaving blow that destroys multiple enemies.  
  - *Special*: Slams the sword, creating a shockwave.

---

### 2. Sticky Syrup Swamp

#### Main-Hand Weapons

- **Honey Comb Blade**  
  A serrated blade that applies sticky honey to enemies, slowing them.  
  - *Quick Attack*: Fast stab.  
  - *Charged Attack*: Coats the enemy in honey for a longer slowdown.

- **Maple Saber**  
  A glowing saber that cuts through sticky golems.  
  - *Quick Attack*: Quick slashes.  
  - *Charged Attack*: Creates a slicing arc to cut through syrup golems.

#### Off-Hand Items

- **Sugar Cube Bomb**  
  Throws a cube that hardens syrup, freezing enemies in place.  
  - *Debuff*: Immobilizes enemies in syrup puddles.

- **Sticky Syrup Globe**  
  A throwable ball that explodes into sticky traps.  
  - *Debuff*: Enemies stuck in place for several seconds.

#### Two-Handed Weapons

- **Molasses Mallet**  
  A massive mallet that smashes syrup golems.  
  - *Quick Attack*: Overhead smash.  
  - *Charged Attack*: Creates a syrup pool on the ground.  
  - *Special*: Explosive impact that traps enemies in syrup.

- **Caramel Whip**  
  A long-range whip for sticky combat.  
  - *Quick Attack*: Sweeps enemies.  
  - *Charged Attack*: Pulls enemies toward the player.  
  - *Special*: Creates a caramel wave that knocks back enemies.

---

### 3. Kitchen Mayhem

#### Main-Hand Weapons

- **Paring Knife**  
  A small knife perfect for close combat.  
  - *Quick Attack*: Quick slices.  
  - *Charged Attack*: Precise stab that deals double damage.

- **Chefâ€™s Skewer**  
  A long skewer for stabbing from a safe distance.  
  - *Quick Attack*: Stabs enemies.  
  - *Charged Attack*: Throws the skewer, impaling enemies.

#### Off-Hand Items

- **Pepper Grinder**  
  Creates a pepper cloud to blind enemies temporarily.  
  - *Debuff*: Blinds enemies.

- **Hot Sauce Flask**  
  Throws a small fire bomb that burns enemies over time.  
  - *Debuff*: Damage over time.

#### Two-Handed Weapons

- **Stock Pot Shield**  
  A heavy shield used for defense and offense.  
  - *Quick Attack*: Shield bash.  
  - *Charged Attack*: Spins the pot to knock enemies back.  
  - *Special*: Slams the pot down, stunning enemies.

- **Chopping Board Axe**  
  A repurposed chopping board as a large axe.  
  - *Quick Attack*: Chopping strike.  
  - *Charged Attack*: Cleaves through multiple enemies.  
  - *Special*: Creates a shockwave.

---

### 4. Egg Factory Frenzy

#### Main-Hand Weapons

- **Eggshell Knife**  
  A light knife for cracking through eggshells.  
  - *Quick Attack*: Stab.  
  - *Charged Attack*: Cracks eggs open, stunning enemies.

- **Egg Scrambler Blade**  
  A spinning blade for egg enemies.  
  - *Quick Attack*: Spins for damage.  
  - *Charged Attack*: Spins rapidly, creating AoE damage.

#### Off-Hand Items

- **Salt Shaker**  
  Throws salt at enemies to dry out yolk bombs.  
  - *Debuff*: Drains enemy health over time.

- **Egg Yolk Grenade**  
  Creates a slippery area that causes enemies to fall.  
  - *Debuff*: Knocks enemies down.

#### Two-Handed Weapons

- **Omelet Spatula**  
  A large spatula for flipping enemies.  
  - *Quick Attack*: Flips a single enemy.  
  - *Charged Attack*: Flips multiple enemies.  
  - *Special*: Creates a shockwave that knocks all enemies back.

- **Egg Beater Staff**  
  A long staff with spinning blades.  
  - *Quick Attack*: Spins to deal damage.  
  - *Charged Attack*: Creates an egg yolk explosion.  
  - *Special*: Creates an AoE scramble.

---

### 5. Citrus Cascade

#### Main-Hand Weapons

- **Citrus Saber**  
  A saber that deals acidic damage.  
  - *Quick Attack*: Slashes enemies.  
  - *Charged Attack*: Creates an acid spray.

- **Peeler Knife**  
  A knife that "peels" enemies, dealing extra damage over time.  
  - *Quick Attack*: Quick slices.  
  - *Charged Attack*: Applies a peeling debuff.

#### Off-Hand Items

- **Zest Grenade**  
  Blinds and damages enemies with citrus spray.  
  - *Debuff*: Reduces vision.

- **Lime Shield**  
  A shield that absorbs damage and sprays lime juice when struck.  
  - *Debuff*: Reduces enemy attack speed.

#### Two-Handed Weapons

- **Juicer Staff**  
  A staff that crushes citrus.  
  - *Quick Attack*: Crushes enemies.  
  - *Charged Attack*: Creates a juice wave.  
  - *Special*: Sprays acidic juice in all directions.

- **Orange Flail**  
  A flail with spiked oranges.  
  - *Quick Attack*: Swings to deal damage.  
  - *Charged Attack*: Launches an orange projectile.  
  - *Special*: Spreads citrus pulp, slowing enemies.

---

### 6. Candy Chaos

#### Main-Hand Weapons

- **Gum Blade**  
  A sticky blade that immobilizes enemies.  
  - *Quick Attack*: Slashes.  
  - *Charged Attack*: Sticks enemies in place.

- **Candy Cane Dagger**  
  A sharp candy blade.  
  - *Quick Attack*: Quick stabs.  
  - *Charged Attack*: Spins to hit nearby enemies.

#### Off-Hand Items

- **Chocolate Bomb**  
  Creates a chocolate explosion that slows enemies.  
  - *Debuff*: Slows movement.

- **Sugar Rush Injector**  
  Boosts the player's speed temporarily.  
  - *Buff*: Increases player attack speed.

#### Two-Handed Weapons

- **Marshmallow Launcher**  
  Launches marshmallow projectiles that stick to enemies.  
  - *Quick Attack*: Fires a marshmallow.  
  - *Charged Attack*: Fires multiple marshmallows.  
  - *Special*: Explodes all stuck marshmallows.

- **Candy Floss Hammer**  
  A large hammer for crushing candy enemies.  
  - *Quick Attack*: Heavy smash.  
  - *Charged Attack*: AoE swing.  
  - *Special*: Sticky explosion.

---

### 7. Bakery Bonanza

#### Main-Hand Weapons

- **Rolling Pin Blade**  
  A light rolling pin for quick attacks.  
  - *Quick Attack*: Spins the rolling pin.  
  - *Charged Attack*: Stuns enemies.

- **Dough Hook**  
  A hooked weapon for pulling enemies.  
  - *Quick Attack*: Hooks and damages.  
  - *Charged Attack*: Pulls enemies toward the player.

#### Off-Hand Items

- **Flour Cloud Bomb**  
  Creates a flour cloud that blinds enemies.  
  - *Debuff*: Reduces enemy accuracy.

- **Dough Ball Trap**  
  Throws a sticky dough ball that immobilizes enemies.  
  - *Debuff*: Stops movement.

#### Two-Handed Weapons

- **Oven Door Shield**  
  A large shield for blocking attacks.  
  - *Quick Attack*: Shield bash.  
  - *Charged Attack*: Knocks back multiple enemies.  
  - *Special*: Creates a fire shockwave.

- **Dough Roller Staff**  
  A large roller for flattening enemies.  
  - *Quick Attack*: Rolls over enemies.  
  - *Charged Attack*: Flattens multiple enemies.  
  - *Special*: Spins to deal AoE damage.

---

