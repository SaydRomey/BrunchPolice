# Weapons

[...]

---

## Weapon Categories

1. Main-Hand Weapons

Quick Attack: Light and fast, with lower damage.

Charged Attack: Slower but deals higher damage or has added effects.

2. Off-Hand Items

Focused on utility effects like debuffs, shielding, or traps.

Can be used alongside the main-hand weapon.

3. Two-Handed Weapons

Heavy or complex weapons that replace both main-hand and off-hand slots.

Three Attacks:

1. Quick Attack: Moderate damage, faster recovery.

2. Charged Attack: High damage or AoE.

3. Special Attack: Unique effect or massive damage.

---

Weapon Examples by Level

1. Pastry Palace

Main-Hand: Croissant Cutter

Quick slices against pastry enemies, charged attack cleaves through
multiple foes.

Off-Hand: Whipped Cream Shield

Absorbs damage and slows nearby enemies with cream splashes.

Two-Handed: Baguette Maul

A heavy baguette club with:

1. Quick strikes.

2. Charged crushing blows.

3. Special: Creates a shockwave that knocks enemies back.

---

2. Sticky Syrup Swamp

Main-Hand: Butter Knife

Quick slashes to butter enemies, charged attack applies a slippery
debuff.

Off-Hand: Sticky Net

Throws a sticky trap that immobilizes enemies for a short time.

Two-Handed: Syrup Cannon

Fires syrup globs with:

1. Small sticky projectiles (quick).

2. A large syrup pool (charged).

3. Special: Creates a syrup explosion.

---

3. Kitchen Mayhem

Main-Hand: Chef’s Cleaver

Quick swings, charged attack creates a chopping wave.

Off-Hand: Hot Lid

Blocks incoming damage and pushes back enemies when hit.

Two-Handed: Rolling Pin Roller

Rolls over enemies with:

1. A fast roll.

2. A charged flattening attack.

3. Special: Creates a massive knockback effect.

---

4. Egg Factory Frenzy

Main-Hand: Egg Beater

Quick spinning attacks, charged attack stuns enemies.

Off-Hand: Yolk Bomb

Throws a small bomb that slows and damages enemies on impact.

Two-Handed: Frying Pan

A massive pan with:

1. Quick slams.

2. Charged overhead smash.

3. Special: AoE shockwave.

---

5. Citrus Cascade

Main-Hand: Orange Zester

Fast cuts with acidic damage, charged attack blinds enemies.

Off-Hand: Juice Squeezer

Creates slippery patches on the ground to trip enemies.

Two-Handed: Citrus Blaster

Fires acidic streams:

1. Quick streams for damage.

2. Charged AoE splash.

3. Special: Pushes all enemies back.

---

6. Candy Chaos

Main-Hand: Lollipop Blade

Quick candy slices, charged attack creates sticky traps.

Off-Hand: Sugar Shield

Blocks attacks and releases sugar bursts when struck.

Two-Handed: Candy Floss Launcher

Fires sticky candy clouds:

1. Quick bursts.

2. Charged sticky explosions.

3. Special: Creates a massive candy storm.

---

7. Bakery Bonanza

Main-Hand: Dough Cutter

Fast cuts, charged attack creates flying dough slashes.

Off-Hand: Flour Puff

Creates a flour cloud that blinds and slows enemies.

Two-Handed: Bread Roller

Heavy bread roller with:

1. Quick rolling attacks.

2. Charged flattening rolls.

3. Special: Spins and knocks back enemies.

---

Implementation Plan

---

Weapon Handling System

Weapon Categories:

enum WeaponType {

MAIN_HAND,

OFF_HAND,

TWO_HAND

};

---

Base Weapon Class

Header File (Weapon.h)

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

Implementation File (Weapon.cpp)

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

---

Player Weapon Logic

Equipping Weapons

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

---

Weapon Examples

Croissant Cutter

void CroissantCutter::attack_quick(Vector2 position, Vector2 direction)
{

// Quick slash logic

}

void CroissantCutter::attack_charged(Vector2 position, Vector2
direction) {

// Cleaving slash logic

}

Whipped Cream Shield

void WhippedCreamShield::attack_quick(Vector2 position, Vector2
direction) {

// Slow down enemies nearby

}

Baguette Maul

void BaguetteMaul::attack_quick(Vector2 position, Vector2 direction) {

// Quick swing logic

}

void BaguetteMaul::attack_charged(Vector2 position, Vector2 direction) {

// Heavy swing with knockback

}

void BaguetteMaul::attack_special(Vector2 position, Vector2 direction) {

// Shockwave logic

}

---

Here are two new suggestions for each weapon category (main-hand,
off-hand, two-hand) in each level. These weapons are designed to counter
the enemies and mechanics of the level, providing varied gameplay rather
than mirroring enemy attacks.

---

1. Pastry Palace

Main-Hand Weapons

1. Cake Cutter Dagger

A quick blade designed to slice through rolling pastries.

Quick Attack: Light slices.

Charged Attack: Multi-hit combo for rolling enemies.

2. Frost Edge Knife

A cold knife that slows pastry enemies on hit.

Quick Attack: Deals damage and slows.

Charged Attack: Freezes a single enemy briefly.

---

Off-Hand Items

1. Jam Jar Grenade

Throws jam grenades that slow enemies in a small AoE.

Debuff: Slows enemies’ movement.

2. Butter Spray Can

Sprays butter on nearby enemies, making them slip and lose balance.

Debuff: Temporarily disables attacks.

---

Two-Handed Weapons

1. Bakery Mixer Staff

A staff that spins to blend enemies into oblivion.

Quick Attack: Swings the mixer.

Charged Attack: Spins to pull enemies in.

Special: Launches a doughy projectile.

2. Layer Cake Greatsword

A heavy sword that crushes pastry enemies in one hit.

Quick Attack: Heavy swing.

Charged Attack: Cleaving blow that destroys multiple enemies.

Special: Slams the sword, creating a shockwave.

---

2. Sticky Syrup Swamp

Main-Hand Weapons

1. Honey Comb Blade

A serrated blade that applies sticky honey to enemies, slowing them.

Quick Attack: Fast stab.

Charged Attack: Coats the enemy in honey for a longer slow.

2. Maple Saber

A glowing saber that cuts through sticky golems.

Quick Attack: Quick slashes.

Charged Attack: Creates a slicing arc to cut through syrup golems.

---

Off-Hand Items

1. Sugar Cube Bomb

Throws a cube that hardens syrup, freezing enemies in place.

Debuff: Immobilizes enemies in syrup puddles.

2. Sticky Syrup Globe

A throwable ball that explodes into sticky traps.

Debuff: Enemies stuck in place for several seconds.

---

Two-Handed Weapons

1. Molasses Mallet

A massive mallet that smashes syrup golems.

Quick Attack: Overhead smash.

Charged Attack: Creates a syrup pool on the ground.

Special: Explosive impact that traps enemies in syrup.

2. Caramel Whip

A long-range whip for sticky combat.

Quick Attack: Sweeps enemies.

Charged Attack: Pulls enemies toward the player.

Special: Creates a caramel wave that knocks back enemies.

---

3. Kitchen Mayhem

Main-Hand Weapons

1. Paring Knife

A small knife perfect for close combat.

Quick Attack: Quick slices.

Charged Attack: Precise stab that deals double damage.

2. Chef’s Skewer

A long skewer for stabbing from a safe distance.

Quick Attack: Stabs enemies.

Charged Attack: Throws the skewer, impaling enemies.

---

Off-Hand Items

1. Pepper Grinder

Creates a pepper cloud to blind enemies temporarily.

Debuff: Blinds enemies.

2. Hot Sauce Flask

Throws a small firebomb that burns enemies over time.

Debuff: Damage over time.

---

Two-Handed Weapons

1. Stock Pot Shield

A heavy shield used for defense and offense.

Quick Attack: Shield bash.

Charged Attack: Spins the pot to knock enemies back.

Special: Slams the pot down, stunning enemies.

2. Chopping Board Axe

A repurposed chopping board as a large axe.

Quick Attack: Chopping strike.

Charged Attack: Cleaves through multiple enemies.

Special: Creates a shockwave.

---

4. Egg Factory Frenzy

Main-Hand Weapons

1. Eggshell Knife

A light knife for cracking through eggshells.

Quick Attack: Stab.

Charged Attack: Cracks eggs open, stunning enemies.

2. Egg Scrambler Blade

A spinning blade for egg enemies.

Quick Attack: Spins for damage.

Charged Attack: Spins rapidly, creating AoE damage.

---

Off-Hand Items

1. Salt Shaker

Throws salt at enemies to dry out yolk bombs.

Debuff: Drains enemy health over time.

2. Egg Yolk Grenade

Creates a slippery area that causes enemies to fall.

Debuff: Knocks enemies down.

---

Two-Handed Weapons

1. Omelet Spatula

A large spatula for flipping enemies.

Quick Attack: Flips a single enemy.

Charged Attack: Flips multiple enemies.

Special: Creates a shockwave that knocks all enemies back.

2. Egg Beater Staff

A long staff with spinning blades.

Quick Attack: Spins to deal damage.

Charged Attack: Creates an egg yolk explosion.

Special: Creates an AoE scramble.

---

5. Citrus Cascade

Main-Hand Weapons

1. Citrus Saber

A saber that deals acidic damage.

Quick Attack: Slashes enemies.

Charged Attack: Creates an acid spray.

2. Peeler Knife

A knife that "peels" enemies, dealing extra damage over time.

Quick Attack: Quick slices.

Charged Attack: Applies a peeling debuff.

---

Off-Hand Items

1. Zest Grenade

Blinds and damages enemies with citrus spray.

Debuff: Reduces vision.

2. Lime Shield

A shield that absorbs damage and sprays lime juice when struck.

Debuff: Reduces enemy attack speed.

---

Two-Handed Weapons

1. Juicer Staff

A staff that crushes citrus.

Quick Attack: Crushes enemies.

Charged Attack: Creates a juice wave.

Special: Sprays acidic juice in all directions.

2. Orange Flail

A flail with spiked oranges.

Quick Attack: Swings to deal damage.

Charged Attack: Launches an orange projectile.

Special: Spreads citrus pulp, slowing enemies.

---

6. Candy Chaos

Main-Hand Weapons

1. Gum Blade

A sticky blade that immobilizes enemies.

Quick Attack: Slashes.

Charged Attack: Sticks enemies in place.

2. Candy Cane Dagger

A sharp candy blade.

Quick Attack: Quick stabs.

Charged Attack: Spins to hit nearby enemies.

---

Off-Hand Items

1. Chocolate Bomb

Creates a chocolate explosion that slows enemies.

Debuff: Slows movement.

2. Sugar Rush Injector

Boosts the player’s speed temporarily.

Buff: Increases player attack speed.

---

Two-Handed Weapons

1. Marshmallow Launcher

Launches marshmallow projectiles that stick to enemies.

Quick Attack: Fires a marshmallow.

Charged Attack: Fires multiple marshmallows.

Special: Explodes all stuck marshmallows.

2. Candy Floss Hammer

A large hammer for crushing candy enemies.

Quick Attack: Heavy smash.

Charged Attack: AoE swing.

Special: Sticky explosion.

---

7. Bakery Bonanza

Main-Hand Weapons

1. Rolling Pin Blade

A light rolling pin for quick attacks.

Quick Attack: Spins the rolling pin.

Charged Attack: Stuns enemies.

2. Dough Hook

A hooked weapon for pulling enemies.

Quick Attack: Hooks and damages.

Charged Attack: Pulls enemies toward the player.

---

Off-Hand Items

1. Flour Cloud Bomb

Creates a flour cloud that blinds enemies.

Debuff: Reduces enemy accuracy.

2. Dough Ball Trap

Throws a sticky dough ball that immobilizes enemies.

Debuff: Stops movement.

---

Two-Handed Weapons

1. Oven Door Shield

A large shield for blocking attacks.

Quick Attack: Shield bash.

Charged Attack: Knocks back multiple enemies.

Special: Creates a fire shockwave.

2. Dough Roller Staff

A large roller for flattening enemies.

Quick Attack: Rolls over enemies.

Charged Attack: Flattens multiple enemies.

Special: Spins to deal AoE damage.

---

These weapons are designed to counter the level’s theme, making gameplay
feel unique and satisfying while maintaining logical restrictions for
equipping. Let me know if you'd like detailed implementations for
specific weapons!
