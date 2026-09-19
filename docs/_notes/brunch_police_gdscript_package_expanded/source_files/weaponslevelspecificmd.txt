# Weapons - Level Specific

the player usually has a brunch fork in his main hand, but when inside a
level, he can find a specific off hand weapon..

the offhand weapon can be wielded at the same time as the fork if it has
only a shield or debuff effect, but in the off hand

some heavy weapons require both hands,

like the lollipop hammer..

the player can have one main hand weapon,

either default fork or bread knife, rolling pin, etc

(one handed weapons that can be charged for a different attack)

and either none or one off hand weapon/item,

like a dishwasher sprayer)

---

## 1. Pastry Palace - Bread Slicer

Weapon Idea: A high-speed melee weapon that slices through multiple
enemies in a short range. Effective against rolling baguette enemies and
other pastry-based foes.

Counter Logic:

Rolls through bread-themed enemies, instantly defeating them.

Deals heavy damage to non-pastry enemies but with slower attacks.

---

## 2. Sticky Syrup Swamp - Butter Knife

Weapon Idea: A melee weapon that "butters" enemies, making them
slippery. Buttered enemies slide uncontrollably, colliding with other
enemies for additional damage.

Counter Logic:

Prevents syrup golems from charging effectively.

Turns butter pats into hazards for other enemies.

---

## 3. Kitchen Mayhem - Dishwasher Sprayer

Weapon Idea: A ranged weapon that sprays high-pressure water, pushing
enemies back and cleaning up obstacles like thrown knives or spinning
ladles.

Counter Logic:

Neutralizes knife attacks by "washing" them out of the air.

Pushes sponges and ladles away, keeping the player safe.

---

## 4. Egg Factory Frenzy - Egg Whisk

Weapon Idea: A spinning melee weapon that scrambles egg-based enemies
(e.g., drones, yolk bombs). Creates an AoE spin attack when charged.

Counter Logic:

Destroys egg drones and yolk bombs before they can attack.

Deals continuous damage to chickens and frying pans when spun.

---

## 5. Citrus Cascade - Zester Shooter

Weapon Idea: A ranged weapon that fires citrus zest at high speed. The
zest blinds enemies temporarily and neutralizes slippery juice hazards.

Counter Logic:

Blinds lemon bats, preventing them from swooping.

Dries juice hazards, allowing safer movement.

---

## 6. Candy Chaos - Lollipop Hammer

Weapon Idea: A heavy melee weapon that crushes candy enemies (e.g.,
gummy bears) with a single hit. Can stick to cupcake bombs and safely
fling them away.

Counter Logic:

Instantly defeats gummy bears.

Safely moves cupcake bombs without triggering explosions.

---

## 7. Bakery Bonanza - Dough Roller

Weapon Idea: A melee weapon that flattens enemies. Rolls over flour
bags, neutralizing flour puffs, and stuns rolling muffin trays.

Counter Logic:

Prevents flour bag monsters from obscuring vision.

Stops muffin trays from moving temporarily.

---

## Implementation of Temporary Weapons

---

### 1. Bread Slicer

**Header File (BreadSlicer.h)**

```cpp

#ifndef BREAD_SLICER_H

#define BREAD_SLICER_H

#include "Weapon.h"

class BreadSlicer : public Weapon {

GDCLASS(BreadSlicer, Weapon);

public:

void fire(Vector2 position, Vector2 direction) override;

};

#endif // BREAD_SLICER_H

```

**Implementation File (BreadSlicer.cpp)**

```cpp

#include "BreadSlicer.h"

void BreadSlicer::fire(Vector2 position, Vector2 direction) {

Godot::print("Bread Slicer slices through enemies!");

if (cooldown_timer <= 0) {

// Create a short-range hitbox

Node2D *slice_area = Node2D::_new();

slice_area->set_position(position);

// Damage logic for nearby enemies

for (Node *enemy : get_overlapping_bodies()) {

if (enemy->has_method("take_damage")) {

enemy->call("take_damage", 50.0f); // High damage to pastry enemies

}

}

queue_free(); // Temporary effect

cooldown_timer = cooldown;

}

}

```

---

### 2. Butter Knife

**Header File (ButterKnife.h)**

```cpp

#ifndef BUTTER_KNIFE_H

#define BUTTER_KNIFE_H

#include "Weapon.h"

class ButterKnife : public Weapon {

GDCLASS(ButterKnife, Weapon);

public:

void fire(Vector2 position, Vector2 direction) override;

};

#endif // BUTTER_KNIFE_H

```

**Implementation File (ButterKnife.cpp)**

```cpp

#include "ButterKnife.h"

void ButterKnife::fire(Vector2 position, Vector2 direction) {

Godot::print("Butter Knife makes enemies slippery!");

if (cooldown_timer <= 0) {

// Find the enemy at the position

Node *enemy = get_node_at_position(position);

if (enemy && enemy->has_method("apply_slippery_effect")) {

enemy->call("apply_slippery_effect");

}

cooldown_timer = cooldown;

}

}

// Enemy Method Example

void BaseEnemy::apply_slippery_effect() {

Godot::print("Enemy becomes slippery!");

velocity *= 2.0f; // Increase movement unpredictably

}

```

---

### 3. Dishwasher Sprayer

**Header File (DishwasherSprayer.h)**

```cpp

#ifndef DISHWASHER_SPRAYER_H

#define DISHWASHER_SPRAYER_H

#include "Weapon.h"

class DishwasherSprayer : public Weapon {

GDCLASS(DishwasherSprayer, Weapon);

public:

void fire(Vector2 position, Vector2 direction) override;

};

#endif // DISHWASHER_SPRAYER_H

```

**Implementation File (DishwasherSprayer.cpp)**

```cpp

#include "DishwasherSprayer.h"

void DishwasherSprayer::fire(Vector2 position, Vector2 direction) {

Godot::print("Dishwasher Sprayer fires high-pressure water!");

if (cooldown_timer <= 0) {

// Create a water spray effect

Node2D *water_spray = Node2D::_new();

water_spray->set_position(position);

// Push back enemies and neutralize attacks

for (Node *enemy : get_overlapping_bodies()) {

if (enemy->has_method("apply_pushback")) {

enemy->call("apply_pushback", direction);

}

}

cooldown_timer = cooldown;

}

}

```

---

## Rest of the Weapons

The same modular approach can be used to implement the remaining
weapons. Each weapon can:

1. Override fire for unique mechanics.

2. Add custom properties and effects (e.g., blinding, immobilization).

---

## Integration Steps

1. Assign Temporary Weapons:

- Place pickup points for each weapon in the level.

- Replace the player's weapon upon pickup.

2. Testing:

- Test each weapon against level enemies to ensure counter logic works
as intended.

3. Visual Feedback:

- Add unique particle effects and animations for each weapon's attack.
