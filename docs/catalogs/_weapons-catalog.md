# BP2 Weapons Catalog

This file regroups weapon-related content only. Each entry is written as an individual design element with level source, category, expected use, and implementation notes.

---

## Weapon System Baseline

Weapon entries should support the following reusable attributes:

- `weapon_id`
- `display_name`
- `level_source`
- `slot_type`
- `damage`
- `fire_rate`
- `cooldown`
- `ammo_capacity`
- `projectile_scene`
- `range_type`
- `status_effects`
- `knockback`
- `is_temporary`
- `is_reward`
- `notes`

Common slot types:

- Main-hand
- Off-hand
- Two-handed
- Temporary level weapon
- Level reward weapon
- Power-weapon item

Common status effects:

- Wrapped
- Slowed
- Blinded
- Stunned
- Frozen
- Knocked back
- Pushed
- Debuffed
- Immobilized

---

## Global / Special Weapons

### Bacon Gun

- **Level Source:** Grease Canyon / global candidate.
- **Slot Type:** Main-hand or special signature weapon.
- **Range Type:** Ranged.
- **Primary Use:** Fires bacon-themed projectiles or wraps enemies.
- **Status Effects:** Wrapped, stunned, possible knockback.
- **Enemy Interaction:** Strong against small enemies; can create boss vulnerability windows if used during slowdown.
- **Boss Use:** Counterplay weapon against Bacon Bandit after Bacon Tornado slows.
- **Implementation Notes:** Needs final progression placement: permanent global weapon, Grease Canyon reward, or early signature weapon.
- **Status:** Needs final placement.

### Extra Bacon / Bacon Shield

- **Level Source:** Grease Canyon / global candidate.
- **Slot Type:** Off-hand / shield.
- **Range Type:** Defensive.
- **Primary Use:** Blocks one or more incoming hits.
- **Status Effects:** None by default.
- **Enemy Interaction:** Useful against charging pigs, bacon debris, and projectile-style hazards.
- **Implementation Notes:** Could share shield behavior with Whipped Cream Shield and Muffin Shield.
- **Status:** Canonical concept.

### Syrup Shooter

- **Level Source:** Sticky Syrup Swamp / global candidate.
- **Slot Type:** Ranged.
- **Range Type:** Mid-range projectile.
- **Primary Use:** Shoots syrup to slow or immobilize enemies.
- **Status Effects:** Slowed, sticky, immobilized.
- **Enemy Interaction:** Strong crowd-control against charging enemies.
- **Implementation Notes:** Could use the same slow-zone system as syrup puddles.
- **Status:** Global / special weapon candidate.

### Syrup Boots

- **Level Source:** Pastry Palace / Sticky Syrup Swamp overlap.
- **Slot Type:** Mobility equipment / power-weapon item.
- **Range Type:** Utility.
- **Primary Use:** Allows player to move through sticky areas more easily.
- **Status Effects:** Removes or reduces sticky slowdown on player.
- **Enemy Interaction:** No direct damage.
- **Boss Use:** Useful against Croissant Crook ground obstructions.
- **Implementation Notes:** Treat as movement modifier rather than attack weapon unless finalized otherwise.
- **Status:** Power-weapon item.

### Bacon Grease Slide

- **Level Source:** Grease Canyon.
- **Slot Type:** Mobility power-weapon item.
- **Range Type:** Utility / movement.
- **Primary Use:** Lets the player dash or slide through grease.
- **Status Effects:** Possible knockback on contact.
- **Enemy Interaction:** Can stun or knock back small enemies if collision damage is enabled.
- **Implementation Notes:** Should interact with slippery-surface physics.
- **Status:** Power-weapon item.

---

## Grease Canyon Weapons

### Bacon Gun

- **Slot Type:** Main-hand.
- **Primary Use:** Ranged bacon projectile weapon.
- **Details:** Signature Grease Canyon weapon that can be used against Bacon Bandit during slowdown windows.
- **Status:** Canonical but needs progression placement.

### Extra Bacon / Bacon Shield

- **Slot Type:** Off-hand.
- **Primary Use:** Defensive shield.
- **Details:** Blocks incoming hazards such as flying bacon debris or charging pig attacks.
- **Status:** Canonical concept.

---

## Pastry Palace Weapons

### Croissant Cutter

- **Slot Type:** Main-hand.
- **Primary Use:** Pastry-themed melee blade.
- **Details:** Fast cutting weapon suited to close-range combat against pastries and small enemies.
- **Status:** Canonical.

### Whipped Cream Shield

- **Slot Type:** Off-hand.
- **Primary Use:** Defensive shield.
- **Details:** Blocks or absorbs attacks, possibly with soft projectile absorption.
- **Status Effects:** Possible blind or slow if converted into active burst.
- **Implementation Notes:** Appears as both off-hand weapon and power-up. Define equipment and pickup versions separately.
- **Status:** Needs split-definition.

### Baguette Maul

- **Slot Type:** Two-handed.
- **Primary Use:** Heavy melee impact weapon.
- **Details:** Slow swing, high damage, strong knockback.
- **Enemy Interaction:** Effective against medium enemies and destructible pastry barriers.
- **Status:** Canonical.

### Cake Cutter Dagger

- **Slot Type:** Additional main-hand.
- **Primary Use:** Fast short-range blade.
- **Details:** Lower damage than Croissant Cutter but faster attack rate.
- **Status:** Additional weapon candidate.

### Frost Edge Knife

- **Slot Type:** Additional main-hand.
- **Primary Use:** Blade with cold/frost theming.
- **Status Effects:** Possible slow or frozen.
- **Details:** Good candidate for slowing fast pastry enemies.
- **Status:** Additional weapon candidate.

### Jam Jar Grenade

- **Slot Type:** Additional off-hand.
- **Primary Use:** Throwable area-of-effect explosive.
- **Status Effects:** Sticky slowdown.
- **Details:** Creates a jam puddle or splash zone after impact.
- **Status:** Additional weapon candidate.

### Butter Spray Can

- **Slot Type:** Additional off-hand.
- **Primary Use:** Spray weapon or surface modifier.
- **Status Effects:** Slippery surface, pushed, debuffed.
- **Details:** Could make enemies slide or lose traction.
- **Status:** Additional weapon candidate.

### Bakery Mixer Staff

- **Slot Type:** Additional two-handed.
- **Primary Use:** Heavy staff / spinning melee weapon.
- **Details:** Could create circular hitboxes that match Pastry Palace mixer hazards.
- **Status:** Additional weapon candidate.

### Layer Cake Greatsword

- **Slot Type:** Additional two-handed.
- **Primary Use:** Slow heavy blade.
- **Details:** Large arc, heavy damage, possible crumb burst on hit.
- **Status:** Additional weapon candidate.

### Bread Slicer

- **Slot Type:** Temporary level weapon.
- **Primary Use:** Level-specific cutting tool.
- **Details:** Can cut pastry barriers or deal bonus damage to bread-based enemies.
- **Status:** Temporary weapon.

### Whipped Cream Cannon

- **Slot Type:** Level reward weapon.
- **Primary Use:** Ranged cream projectile weapon.
- **Status Effects:** Blinded, slowed, pushed.
- **Details:** Could fire cream blobs that obscure enemy vision or create temporary soft cover.
- **Status:** Reward weapon.

---

## Sticky Syrup Swamp Weapons

### Butter Knife

- **Slot Type:** Main-hand / temporary overlap.
- **Primary Use:** Simple melee blade.
- **Details:** Appears as both main-hand and temporary level weapon.
- **Implementation Notes:** Decide whether canonical version is permanent or temporary.
- **Status:** Needs merge.

### Sticky Net

- **Slot Type:** Off-hand.
- **Primary Use:** Throwable immobilization tool.
- **Status Effects:** Wrapped, immobilized, slowed.
- **Details:** Strong against charging enemies and flying butter pats if aimed upward.
- **Status:** Canonical.

### Syrup Cannon

- **Slot Type:** Two-handed.
- **Primary Use:** Heavy ranged syrup weapon.
- **Status Effects:** Slowed, sticky, immobilized.
- **Details:** Larger version of syrup shooter; likely slower but stronger.
- **Status:** Canonical.

### Honey Comb Blade

- **Slot Type:** Additional main-hand.
- **Primary Use:** Melee blade with bee/honey theme.
- **Status Effects:** Sticky or damage-over-time candidate.
- **Details:** Could synergize with swamp bee enemies.
- **Status:** Additional weapon candidate.

### Maple Saber

- **Slot Type:** Additional main-hand.
- **Primary Use:** Syrup-themed sword.
- **Status Effects:** Slowed.
- **Details:** Mid-speed melee option with sticky hit effect.
- **Status:** Additional weapon candidate.

### Sugar Cube Bomb

- **Slot Type:** Additional off-hand.
- **Primary Use:** Throwable explosive.
- **Status Effects:** Knockback, slowed if sugar shards remain.
- **Details:** Area damage tool.
- **Status:** Additional weapon candidate.

### Sticky Syrup Globe

- **Slot Type:** Additional off-hand.
- **Primary Use:** Throwable crowd-control orb.
- **Status Effects:** Sticky, immobilized, slowed.
- **Details:** Creates temporary syrup zone on impact.
- **Status:** Additional weapon candidate.

### Molasses Mallet

- **Slot Type:** Additional two-handed.
- **Primary Use:** Heavy blunt weapon.
- **Status Effects:** Stunned, slowed.
- **Details:** High knockback and low attack speed.
- **Status:** Additional weapon candidate.

### Caramel Whip

- **Slot Type:** Additional two-handed.
- **Primary Use:** Long-range melee / lash weapon.
- **Status Effects:** Wrapped, pulled, slowed.
- **Details:** Can pull enemies or interact with distant switches.
- **Status:** Additional weapon candidate.

### Syrup Launcher

- **Slot Type:** Level reward weapon.
- **Primary Use:** Arc-firing syrup projectile.
- **Status Effects:** Slowed, sticky.
- **Details:** Could create temporary sticky puddles on the ground.
- **Status:** Reward weapon.

---

## Kitchen Mayhem Weapons

### Chef’s Cleaver

- **Slot Type:** Main-hand.
- **Primary Use:** Heavy kitchen blade.
- **Details:** Strong melee weapon with medium speed and high damage.
- **Status:** Canonical.

### Hot Lid

- **Slot Type:** Off-hand.
- **Primary Use:** Defensive shield.
- **Details:** Blocks projectiles; may reflect small cutlery throws.
- **Status:** Canonical.

### Rolling Pin Roller

- **Slot Type:** Two-handed.
- **Primary Use:** Rolling impact weapon.
- **Details:** Could send a rolling hitbox forward along the ground.
- **Status:** Canonical.

### Paring Knife

- **Slot Type:** Additional main-hand.
- **Primary Use:** Fast small blade.
- **Details:** Quick attacks, low damage, good for close enemies.
- **Status:** Additional weapon candidate.

### Chef’s Skewer

- **Slot Type:** Additional main-hand.
- **Primary Use:** Thrust weapon.
- **Details:** Longer reach than knife weapons.
- **Status:** Additional weapon candidate.

### Pepper Grinder

- **Slot Type:** Additional off-hand.
- **Primary Use:** Debuff spray.
- **Status Effects:** Blinded, stunned, debuffed.
- **Details:** Short-range cone attack.
- **Status:** Additional weapon candidate.

### Hot Sauce Flask

- **Slot Type:** Additional off-hand.
- **Primary Use:** Throwable or splash damage item.
- **Status Effects:** Burn / damage-over-time candidate.
- **Details:** Creates a short-lived spicy hazard.
- **Status:** Additional weapon candidate.

### Stock Pot Shield

- **Slot Type:** Additional two-handed.
- **Primary Use:** Heavy shield.
- **Details:** Slower movement but stronger defense than Hot Lid.
- **Status:** Additional weapon candidate.

### Chopping Board Axe

- **Slot Type:** Additional two-handed.
- **Primary Use:** Heavy melee weapon.
- **Details:** Strong overhead chop; may break destructibles.
- **Status:** Additional weapon candidate.

### Dishwasher Sprayer

- **Slot Type:** Temporary level weapon.
- **Primary Use:** Ranged water spray.
- **Status Effects:** Pushed, blinded.
- **Details:** Can push enemies away or clear steam/flour-like visibility blockers.
- **Status:** Temporary weapon.

### Rolling Pin

- **Slot Type:** Level reward weapon.
- **Primary Use:** Melee or rolling projectile weapon.
- **Details:** Similar naming to Rolling Pin Roller; separate as reward version if needed.
- **Status:** Reward weapon / needs taxonomy clarity.

---

## Candy Chaos Weapons

### Lollipop Blade

- **Slot Type:** Main-hand.
- **Primary Use:** Candy sword.
- **Details:** Bright, readable melee weapon for Candy Chaos.
- **Status:** Canonical.

### Sugar Shield

- **Slot Type:** Off-hand.
- **Primary Use:** Defensive shield.
- **Details:** Could crack after absorbing enough damage.
- **Status:** Canonical.

### Candy Floss Launcher

- **Slot Type:** Two-handed.
- **Primary Use:** Ranged cotton-candy launcher.
- **Status Effects:** Wrapped, slowed.
- **Details:** Fires sticky fluff to trap enemies.
- **Status:** Canonical.

### Gum Blade

- **Slot Type:** Additional main-hand.
- **Primary Use:** Flexible melee blade.
- **Status Effects:** Sticky, slowed.
- **Details:** Could extend slightly or rebound.
- **Status:** Additional weapon candidate.

### Candy Cane Dagger

- **Slot Type:** Additional main-hand.
- **Primary Use:** Fast short blade.
- **Details:** Low range, quick strikes.
- **Status:** Additional weapon candidate.

### Chocolate Bomb

- **Slot Type:** Additional off-hand.
- **Primary Use:** AoE throwable.
- **Status Effects:** Slowed, sticky.
- **Details:** Leaves chocolate hazard or puddle after explosion.
- **Status:** Additional weapon candidate.

### Sugar Rush Injector

- **Slot Type:** Additional off-hand.
- **Primary Use:** Buff item.
- **Status Effects:** Player speed or attack-rate boost.
- **Details:** Temporary self-enhancement rather than direct attack.
- **Status:** Additional weapon candidate.

### Marshmallow Launcher

- **Slot Type:** Additional two-handed.
- **Primary Use:** Ranged soft projectile.
- **Status Effects:** Knockback, wrapped.
- **Details:** Launches large marshmallow projectiles.
- **Status:** Additional weapon candidate.

### Candy Floss Hammer

- **Slot Type:** Additional two-handed.
- **Primary Use:** Heavy sticky hammer.
- **Status Effects:** Slowed, stunned.
- **Details:** Large impact, possible sticky ground residue.
- **Status:** Additional weapon candidate.

### Lollipop Hammer

- **Slot Type:** Temporary level weapon.
- **Primary Use:** Heavy melee weapon.
- **Details:** Temporary high-impact candy weapon.
- **Status:** Temporary weapon.

### Gummy Bear Grenade

- **Slot Type:** Level reward weapon.
- **Primary Use:** Throwable explosive.
- **Status Effects:** Sticky, knockback.
- **Details:** Explodes into gummy fragments or sticky splash.
- **Status:** Reward weapon.

---

## Egg Factory Frenzy Weapons

### Egg Beater

- **Slot Type:** Main-hand.
- **Primary Use:** Melee tool weapon.
- **Details:** Could use rapid spinning hits.
- **Status:** Canonical.

### Yolk Bomb

- **Slot Type:** Off-hand.
- **Primary Use:** Throwable sticky bomb.
- **Status Effects:** Slowed, slippery, blinded.
- **Details:** Creates yolk splash zone.
- **Status:** Canonical.

### Frying Pan

- **Slot Type:** Two-handed.
- **Primary Use:** Heavy melee weapon.
- **Details:** Also appears as enemy/hazard; keep weapon version mechanically separate.
- **Status:** Canonical / multi-role item.

### Eggshell Knife

- **Slot Type:** Additional main-hand.
- **Primary Use:** Fragile sharp blade.
- **Details:** Fast blade; could have brittle crit behavior.
- **Status:** Additional weapon candidate.

### Egg Scrambler Blade

- **Slot Type:** Additional main-hand.
- **Primary Use:** Spinning or chopping blade.
- **Details:** Stronger variant of Egg Beater-style combat.
- **Status:** Additional weapon candidate.

### Salt Shaker

- **Slot Type:** Additional off-hand.
- **Primary Use:** Debuff item.
- **Status Effects:** Blinded, slowed, stunned candidate.
- **Details:** Cone or sprinkle projectile.
- **Status:** Additional weapon candidate.

### Egg Yolk Grenade

- **Slot Type:** Additional off-hand.
- **Primary Use:** Area sticky explosive.
- **Status Effects:** Slippery, slowed.
- **Details:** Similar to Yolk Bomb but larger AoE.
- **Status:** Additional weapon candidate.

### Omelet Spatula

- **Slot Type:** Additional two-handed.
- **Primary Use:** Heavy flipper weapon.
- **Status Effects:** Knockback, launched.
- **Details:** Mirrors Omelet Overlord boss behavior.
- **Status:** Additional weapon candidate.

### Egg Beater Staff

- **Slot Type:** Additional two-handed.
- **Primary Use:** Staff with spinning attachment.
- **Details:** Medium-range spinning attacks.
- **Status:** Additional weapon candidate.

### Egg Whisk

- **Slot Type:** Temporary level weapon.
- **Primary Use:** Rapid melee tool.
- **Details:** Could clear small egg hazards or stun chickens.
- **Status:** Temporary weapon.

### Egg Launcher

- **Slot Type:** Level reward weapon.
- **Primary Use:** Ranged launcher.
- **Status Effects:** Knockback, cracked-defense state.
- **Boss Use:** Cracks Omelet Overlord defenses.
- **Status:** Reward weapon / boss counter.

---

## Citrus Cascade Weapons

### Orange Zester

- **Slot Type:** Main-hand.
- **Primary Use:** Citrus blade/tool.
- **Details:** Quick slicing weapon.
- **Status:** Canonical.

### Juice Squeezer

- **Slot Type:** Off-hand.
- **Primary Use:** Utility or close-range squeeze attack.
- **Status Effects:** Pushed, slowed.
- **Details:** Could spray juice in a short arc.
- **Status:** Canonical.

### Citrus Blaster

- **Slot Type:** Two-handed / reward overlap.
- **Primary Use:** Ranged citrus projectile weapon.
- **Status Effects:** Sticky pulp, pushed.
- **Details:** Appears as both two-handed weapon and reward weapon.
- **Status:** Needs merge or split-definition.

### Citrus Saber

- **Slot Type:** Additional main-hand.
- **Primary Use:** Sword weapon.
- **Details:** Mid-speed citrus melee.
- **Status:** Additional weapon candidate.

### Peeler Knife

- **Slot Type:** Additional main-hand.
- **Primary Use:** Small blade.
- **Details:** Quick, precise melee weapon.
- **Status:** Additional weapon candidate.

### Zest Grenade

- **Slot Type:** Additional off-hand.
- **Primary Use:** Throwable explosive.
- **Status Effects:** Blinded, sticky pulp.
- **Details:** AoE citrus burst.
- **Status:** Additional weapon candidate.

### Lime Shield

- **Slot Type:** Additional off-hand.
- **Primary Use:** Defensive shield.
- **Details:** Blocks juice jets or projectile attacks.
- **Status:** Additional weapon candidate.

### Juicer Staff

- **Slot Type:** Additional two-handed.
- **Primary Use:** Staff weapon.
- **Details:** Could fire or channel juice streams.
- **Status:** Additional weapon candidate.

### Orange Flail

- **Slot Type:** Additional two-handed.
- **Primary Use:** Heavy swinging weapon.
- **Status Effects:** Knockback.
- **Details:** Arc-based melee with citrus head.
- **Status:** Additional weapon candidate.

### Zester Shooter

- **Slot Type:** Temporary level weapon.
- **Primary Use:** Temporary ranged weapon.
- **Details:** Shoots zest shards or citrus pellets.
- **Status:** Temporary weapon.

---

## Bakery Bonanza Weapons

### Dough Cutter

- **Slot Type:** Main-hand.
- **Primary Use:** Dough slicing blade.
- **Details:** Duplicated in source notes; canonical main-hand version recommended.
- **Status:** Canonical / duplicate noted.

### Flour Puff

- **Slot Type:** Off-hand.
- **Primary Use:** Visibility/status item.
- **Status Effects:** Blinded.
- **Details:** Creates a flour cloud that affects enemies or hides player movement.
- **Status:** Canonical / duplicate noted.

### Bread Roller

- **Slot Type:** Two-handed.
- **Primary Use:** Heavy rolling weapon.
- **Details:** Duplicated in source notes; canonical two-handed version recommended.
- **Status:** Canonical / duplicate noted.

### Rolling Pin Blade

- **Slot Type:** Additional main-hand.
- **Primary Use:** Blade variant.
- **Details:** Hybrid rolling pin and sword.
- **Status:** Additional weapon candidate.

### Dough Hook

- **Slot Type:** Additional main-hand.
- **Primary Use:** Hook weapon.
- **Status Effects:** Pull, wrapped candidate.
- **Details:** Could pull enemies or latch onto objects.
- **Status:** Additional weapon candidate.

### Flour Cloud Bomb

- **Slot Type:** Additional off-hand.
- **Primary Use:** Throwable visibility bomb.
- **Status Effects:** Blinded.
- **Details:** Creates a temporary obscuring flour cloud.
- **Status:** Additional weapon candidate.

### Dough Ball Trap

- **Slot Type:** Additional off-hand.
- **Primary Use:** Deployable trap.
- **Status Effects:** Immobilized, slowed.
- **Details:** Placed on ground to trap enemies.
- **Status:** Additional weapon candidate.

### Oven Door Shield

- **Slot Type:** Additional two-handed.
- **Primary Use:** Heavy shield.
- **Details:** Strong defense against hot hazards and projectiles.
- **Status:** Additional weapon candidate.

### Dough Roller Staff

- **Slot Type:** Additional two-handed.
- **Primary Use:** Staff variant.
- **Details:** Longer reach, dough impact effects.
- **Status:** Additional weapon candidate.

### Dough Roller

- **Slot Type:** Temporary level weapon.
- **Primary Use:** Temporary rolling impact weapon.
- **Details:** Could clear dough obstacles or knock enemies back.
- **Status:** Temporary weapon.

### Flour Blaster

- **Slot Type:** Level reward weapon.
- **Primary Use:** Ranged flour weapon.
- **Status Effects:** Blinded, pushed.
- **Details:** Shoots flour bursts; can obscure or disable enemies.
- **Status:** Reward weapon.

---

## Merge / Cleanup Notes

| Item | Issue | Proposed Handling |
|---|---|---|
| Whipped Cream Shield | Appears as off-hand weapon and power-up. | Keep both, but define equipment version and pickup version separately. |
| Butter Knife | Appears as main-hand and temporary level weapon. | Decide whether permanent or temporary; mark duplicate until resolved. |
| Citrus Blaster | Appears as two-handed and reward weapon. | Split into standard Citrus Blaster and upgraded reward version, or merge. |
| Dough Cutter / Flour Puff / Bread Roller | Repeated in Bakery list. | Keep first listing canonical. |
| Rolling Pin / Rolling Pin Roller | Similar names, different categories. | Keep separate until weapon taxonomy is finalized. |
| Bacon Gun | Global weapon, level signature, boss counter. | Needs final progression placement. |
