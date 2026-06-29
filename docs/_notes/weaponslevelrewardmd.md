# Weapons - Level Reward

ideas of weapons obtained after defeating a boss, to put in inventory
and use in other levels

Here's a detailed plan for implementing level-specific weapons and their
effects in each level of the Brunch Police game. Each weapon will have
unique mechanics and wacky effects tailored to the level theme.

---

## Weapon System Overview

### Weapon Base Class

The Weapon base class handles general weapon functionality:

Firing mechanics

Cooldown logic

Projectile instantiation

Each level-specific weapon will inherit from this base class and
override behaviors as needed.

---

## Level-Specific Weapons

Here are thematic weapon ideas for each level, along with their
mechanics and implementation details:

---

### 1. Pastry Palace - Whipped Cream Cannon

Weapon Idea: A cannon that shoots whipped cream blobs. On contact, the
blobs stick to enemies, reducing their visibility (and accuracy, if
applicable).

Effect on Enemy:

Slows down movement.

Covers the enemy with whipped cream (visual change).

#### Header File (WhippedCreamCannon.h)

```cpp

#ifndef WHIPPED_CREAM_CANNON_H

#define WHIPPED_CREAM_CANNON_H

#include "Weapon.h"

class WhippedCreamCannon : public Weapon {

GDCLASS(WhippedCreamCannon, Weapon);

public:

void fire(Vector2 position, Vector2 direction) override;

};

#endif // WHIPPED_CREAM_CANNON_H

```

#### Implementation File (WhippedCreamCannon.cpp)

```cpp

#include "WhippedCreamCannon.h"

void WhippedCreamCannon::fire(Vector2 position, Vector2 direction) {

Godot::print("Whipped Cream Cannon fires!");

if (cooldown_timer <= 0 && !projectile_scene.is_null()) {

Node2D *cream_projectile =
cast_to<Node2D>(projectile_scene->instantiate());

if (cream_projectile) {

get_parent()->add_child(cream_projectile);

cream_projectile->set_position(position);

if (cream_projectile->has_method("set_velocity")) {

cream_projectile->call("set_velocity", direction);

}

// Set specific properties

cream_projectile->set("effect", "slow");

}

cooldown_timer = cooldown;

}

}

```

---

### 2. Sticky Syrup Swamp - Syrup Launcher

Weapon Idea: A launcher that fires syrup globs. On contact, these globs
create sticky pools that trap enemies.

Effect on Enemy:

Immobilizes the enemy in a sticky syrup pool.

Enemies take periodic damage while stuck.

---

### 3. Kitchen Mayhem - Rolling Pin

Weapon Idea: A melee weapon with a charged attack. The player can swing
the rolling pin for a quick attack or hold down the button to charge a
powerful spinning attack that knocks enemies back.

Effect on Enemy:

Quick attack deals light damage.

Charged attack knocks back enemies.

---

### 4. Egg Factory Frenzy - Egg Launcher

Weapon Idea: A launcher that shoots exploding eggs. When they hit an
enemy or the ground, they release yolk bombs that splatter and deal AoE
damage.

Effect on Enemy:

Direct hit deals significant damage.

Splash damage affects nearby enemies.

---

### 5. Citrus Cascade - Citrus Blaster

Weapon Idea: A rapid-fire blaster that shoots orange juice streams.
Enemies hit by the streams are pushed back.

Effect on Enemy:

Pushback on hit.

Deals minor damage over time (like acidic juice).

---

### 6. Candy Chaos - Gummy Bear Grenade

Weapon Idea: A throwable grenade that spawns sticky gummy bears upon
explosion. Gummy bears latch onto enemies and slow them down.

Effect on Enemy:

Latches on to enemies and reduces movement speed.

Explodes after a few seconds, dealing damage.

---

### 7. Bakery Bonanza - Flour Blaster

Weapon Idea: A blaster that shoots puffs of flour. Enemies hit by the
flour are blinded temporarily.

Effect on Enemy:

Reduces vision (blinds the enemy).

Stuns the enemy briefly.

---

## Implementation Details

### Weapon-Specific Classes

Each weapon overrides the fire method in the base Weapon class and
applies its specific mechanics.

---

### Projectile Updates

Each weapon can use unique projectiles with specific logic for effects.

**Example: Sticky Syrup Pool**

For the Syrup Launcher, the projectile would create a sticky pool upon
collision.

#### Syrup Projectile

```cpp

void SyrupProjectile::on_body_entered(Node *body) {

if (body->has_method("apply_syrup_effect")) {

body->call("apply_syrup_effect");

}

// Create sticky pool

Node2D *syrup_pool = cast_to<Node2D>(syrup_pool_scene->instantiate());

if (syrup_pool) {

get_parent()->add_child(syrup_pool);

syrup_pool->set_position(get_position());

}

queue_free();

}

```

---

### Enemy States

To handle the effects on enemies, extend the BaseEnemy class to include
state management. For example:

#### Header File (BaseEnemy.h)

```cpp

void apply_syrup_effect();

void apply_blind_effect();

void apply_gummy_bear_effect();

```

#### Implementation Example

```cpp

void BaseEnemy::apply_syrup_effect() {

is_immobilized = true;

Timer *effect_timer = Timer::_new();

effect_timer->set_wait_time(3.0f); // Effect duration

add_child(effect_timer);

effect_timer->connect("timeout", this, "remove_syrup_effect");

effect_timer->start();

}

void BaseEnemy::remove_syrup_effect() {

is_immobilized = false;

}

```

---

## Integration Steps

1. Weapon Assignment:

Assign the basic weapon (KnifeAndFork) at the start of each level.

Replace it with the level-specific weapon at a designated pickup point.

2. Testing:

Verify each weaponâ€™s effect logic on different enemy types.

Balance damage, cooldown, and special effects.

3. Visuals and Sounds:

Add custom particle effects and sounds for each weapon and its
projectiles.

---

This modular design ensures that each weapon is unique and easy to
extend for future levels or projects.
