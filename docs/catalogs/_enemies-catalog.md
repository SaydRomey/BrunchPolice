# BP2 Enemies Catalog

This file regroups enemy-related content only. It includes regular enemies, enemy-like hazards, variants, and bosses. Each entry is written as an individual design element.

---

## Enemy System Baseline

Regular enemies should inherit from a reusable `BaseEnemy` where possible.

Suggested reusable properties:

- `enemy_id`
- `display_name`
- `level_source`
- `enemy_class`
- `health`
- `speed`
- `damage`
- `detection_range`
- `attack_range`
- `attack_cooldown`
- `patrol_points`
- `movement_behavior`
- `attack_behavior`
- `status_resistances`
- `death_behavior`
- `drops`
- `notes`

Reusable states:

- Idle
- Patrolling
- Chasing
- Attacking
- Retreating
- Stunned
- Summoning
- Fleeing
- Frozen
- Invincible
- Wrapped
- Slowed
- Blinded

Reusable behavior modules:

- Patrol AI
- Chase AI
- Flying AI
- Pathfinding AI
- Hazard-aware movement
- Platform-aware movement
- Trigger-aware behavior
- Destructible-aware behavior
- EnemySpawner wave spawning

---

## Grease Canyon Enemies

### Small Angry Pigs

- **Level Source:** Grease Canyon.
- **Enemy Class:** Ground charger.
- **Movement Behavior:** Patrols platforms, then charges when the player enters detection range.
- **Attack Behavior:** Contact damage and knockback.
- **Primary Threat:** Can knock player off platforms into boiling grease.
- **Weakness / Counterplay:** Jump over charge, attack during recovery, use Bacon Gun or grease-slide stun.
- **Environment Interaction:** Platform-aware; should avoid walking off ledges unless charging.
- **Status:** Canonical.

### Bacon Worms

- **Level Source:** Grease Canyon.
- **Enemy Class:** Rope / vertical crawler.
- **Movement Behavior:** Slithers or moves up and down sausage-link ropes.
- **Attack Behavior:** Contact damage; possible lunge if player gets close.
- **Primary Threat:** Blocks rope traversal and vertical routes.
- **Weakness / Counterplay:** Time climbs between movement cycles or use ranged weapon.
- **Environment Interaction:** Attached to sausage ropes; can fall into grease if dislodged.
- **Status:** Canonical.

### Flying Sausage Links

- **Level Source:** Grease Canyon.
- **Enemy Class:** Flying swooper.
- **Movement Behavior:** Hovers, flaps, then swoops down at the player.
- **Attack Behavior:** Swoop contact damage.
- **Primary Threat:** Pressures jumps over grease pits.
- **Weakness / Counterplay:** Bait swoop, dodge, attack during recovery.
- **Environment Interaction:** Can cross gaps and ignore ground hazards.
- **Status:** Canonical.

### Pig / Bacon Enemy Variants

- **Level Source:** Grease Canyon visual references.
- **Enemy Class:** Variant pool.
- **Movement Behavior:** TBD depending on final sprite.
- **Attack Behavior:** Could reuse pig charge, bacon debris throw, or platform patrol.
- **Primary Threat:** Adds visual variety.
- **Weakness / Counterplay:** Should reuse existing readable behaviors.
- **Environment Interaction:** Bacon platforms and grease hazards.
- **Status:** Variant / visual concept.

### Chef-Pig / Armored Pig Figures

- **Level Source:** Grease Canyon visual references.
- **Enemy Class:** Heavy enemy or mini-boss candidate.
- **Movement Behavior:** Slow patrol or heavy charge.
- **Attack Behavior:** Could slam, throw bacon, or guard platforms.
- **Primary Threat:** Occupies space and forces repositioning.
- **Weakness / Counterplay:** Attack after heavy move cooldown.
- **Environment Interaction:** Can be used as enemy staging on bacon structures.
- **Status:** Variant / mini-boss candidate.

---

## Pastry Palace Enemies

### Flying Éclairs

- **Level Source:** Pastry Palace.
- **Enemy Class:** Flying ranged enemy.
- **Movement Behavior:** Hovers near lanes or patrol points.
- **Attack Behavior:** Shoots whipped cream projectiles.
- **Primary Threat:** Forces player movement during platforming.
- **Weakness / Counterplay:** Dodge projectiles, attack between shots.
- **Environment Interaction:** Works well near rotating mixer platforms and frosting slowdown zones.
- **Status:** Canonical.

### Rolling Baguette

- **Level Source:** Pastry Palace.
- **Enemy Class:** Rolling hazard enemy.
- **Movement Behavior:** Rolls along platforms and slopes.
- **Attack Behavior:** Contact damage.
- **Primary Threat:** Controls horizontal lanes.
- **Weakness / Counterplay:** Jump over, shield, or destroy with heavy weapon.
- **Environment Interaction:** Can be spawned by Croissant Crook or released from shelves.
- **Status:** Canonical.

### Jelly-Filled Donuts

- **Level Source:** Pastry Palace.
- **Enemy Class:** Chaser / explosive enemy.
- **Movement Behavior:** Chases player when nearby.
- **Attack Behavior:** Explodes on contact.
- **Primary Threat:** Denies safe standing spots and punishes slow movement.
- **Weakness / Counterplay:** Kite into safe detonation range or destroy early.
- **Environment Interaction:** Leaves sticky jam puddle if implemented.
- **Status:** Canonical.

### Rolling Croissants

- **Level Source:** Pastry Palace boss-summon concept.
- **Enemy Class:** Summoned rolling minion.
- **Movement Behavior:** Rolls along ground or down slopes.
- **Attack Behavior:** Contact damage and obstruction.
- **Primary Threat:** Clutters arena during Croissant Crook fight.
- **Weakness / Counterplay:** Jump, destroy, or use Syrup Boots if they leave sticky zones.
- **Environment Interaction:** Can become temporary ground obstruction.
- **Status:** Summon candidate.

---

## Sticky Syrup Swamp Enemies

### Angry Bees

- **Level Source:** Sticky Syrup Swamp.
- **Enemy Class:** Flying swarm enemy.
- **Movement Behavior:** Buzzes in circular pattern and attacks when nearby.
- **Attack Behavior:** Swoop or sting.
- **Primary Threat:** Pressures player while movement is slowed by syrup.
- **Weakness / Counterplay:** Use ranged weapons or bait attack path.
- **Environment Interaction:** Can destroy barricades if destructible-aware behavior is enabled.
- **Status:** Canonical.

### Syrup Golems

- **Level Source:** Sticky Syrup Swamp.
- **Enemy Class:** Heavy ground charger.
- **Movement Behavior:** Rises from syrup floor, then charges.
- **Attack Behavior:** Heavy contact damage or slam.
- **Primary Threat:** Forces movement in sticky zones.
- **Weakness / Counterplay:** Attack during emergence or after charge recovery.
- **Environment Interaction:** Emerges from syrup pools; may be healed or hidden by syrup.
- **Status:** Canonical.

### Flying Butter Pats

- **Level Source:** Sticky Syrup Swamp.
- **Enemy Class:** Flying contact enemy.
- **Movement Behavior:** Flies across screen in lanes.
- **Attack Behavior:** Contact damage.
- **Primary Threat:** Cross-screen movement hazard.
- **Weakness / Counterplay:** Duck, jump, or destroy with ranged weapon.
- **Environment Interaction:** Works as timed obstacle over pancake rafts.
- **Status:** Canonical.

---

## Kitchen Mayhem Enemies

### Knife-Throwing Chefs

- **Level Source:** Kitchen Mayhem.
- **Enemy Class:** Ground ranged enemy.
- **Movement Behavior:** Holds position or patrols short range.
- **Attack Behavior:** Throws knives in arcs.
- **Primary Threat:** Forces dodging while traversing counters and carts.
- **Weakness / Counterplay:** Close distance, block with Hot Lid, attack during throw cooldown.
- **Environment Interaction:** Can stand behind kitchen clutter or destructible cover.
- **Status:** Canonical.

### Dishwashing Sponges

- **Level Source:** Kitchen Mayhem.
- **Enemy Class:** Jumper.
- **Movement Behavior:** Hops toward the player.
- **Attack Behavior:** Jump contact damage.
- **Primary Threat:** Unpredictable vertical pressure.
- **Weakness / Counterplay:** Attack after landing or knock back mid-hop.
- **Environment Interaction:** Can interact with wet floors and dishwater.
- **Status:** Canonical.

### Spinning Ladles

- **Level Source:** Kitchen Mayhem.
- **Enemy Class:** Stationary hazard enemy.
- **Movement Behavior:** Spins in place or along a fixed track.
- **Attack Behavior:** Contact damage.
- **Primary Threat:** Controls tight passages.
- **Weakness / Counterplay:** Time movement or disable with switch.
- **Environment Interaction:** Blends with kitchen utensil hazard language.
- **Status:** Canonical.

### Chef / Cutlery Variants

- **Level Source:** Kitchen Mayhem visual references.
- **Enemy Class:** Variant pool.
- **Movement Behavior:** Can reuse chef throw, patrol, or rush behavior.
- **Attack Behavior:** Cutlery projectiles or melee swings.
- **Primary Threat:** Adds variety to kitchen enemy encounters.
- **Weakness / Counterplay:** Should follow visible windups.
- **Environment Interaction:** Uses dish piles, counters, and utensil racks.
- **Status:** Variant.

---

## Candy Chaos Enemies

### Gummy Bear Brutes

- **Level Source:** Candy Chaos.
- **Enemy Class:** Heavy charger.
- **Movement Behavior:** Charges in straight lines.
- **Attack Behavior:** Contact damage and knockback.
- **Primary Threat:** Forces vertical dodging or lane changes.
- **Weakness / Counterplay:** Bait charge, jump over, attack from behind.
- **Environment Interaction:** Can bounce slightly off candy walls or gumdrops.
- **Status:** Canonical.

### Cupcake Bombs

- **Level Source:** Candy Chaos.
- **Enemy Class:** Chaser / explosive enemy.
- **Movement Behavior:** Chases player.
- **Attack Behavior:** Explodes into frosting.
- **Primary Threat:** Denies space and creates temporary sticky areas.
- **Weakness / Counterplay:** Trigger safely, destroy at range.
- **Environment Interaction:** Explosion can leave frosting puddles.
- **Status:** Canonical.

### Jellybean Snipers

- **Level Source:** Candy Chaos.
- **Enemy Class:** Ranged enemy.
- **Movement Behavior:** Holds position or perches on platforms.
- **Attack Behavior:** Fires candy projectiles.
- **Primary Threat:** Controls lanes from distance.
- **Weakness / Counterplay:** Use cover, close distance, interrupt shots.
- **Environment Interaction:** Good on hard-candy discs or upper platforms.
- **Status:** Canonical.

### Cupcake / Dessert Character Variant

- **Level Source:** Candy Chaos visual references.
- **Enemy Class:** Variant or mini-boss candidate.
- **Movement Behavior:** TBD.
- **Attack Behavior:** Could throw frosting, bounce, or explode.
- **Primary Threat:** Visual variety or special encounter.
- **Weakness / Counterplay:** Should reuse established candy mechanics.
- **Status:** Variant / possible mini-boss.

---

## Egg Factory Frenzy Enemies

### Angry Chickens

- **Level Source:** Egg Factory Frenzy.
- **Enemy Class:** Ground chaser.
- **Movement Behavior:** Chases player.
- **Attack Behavior:** Peck attack.
- **Primary Threat:** Pressures player on conveyors.
- **Weakness / Counterplay:** Jump over, stun, or knock into machinery.
- **Environment Interaction:** Conveyor-aware movement recommended.
- **Status:** Canonical.

### Eggshell Drones

- **Level Source:** Egg Factory Frenzy.
- **Enemy Class:** Flying bomber.
- **Movement Behavior:** Flies above player or patrols overhead.
- **Attack Behavior:** Drops yolk bombs.
- **Primary Threat:** Creates slippery or damaging zones below.
- **Weakness / Counterplay:** Attack from range or bait drops away from route.
- **Environment Interaction:** Strong near conveyor belts and factory platforms.
- **Status:** Canonical.

### Frying Pans

- **Level Source:** Egg Factory Frenzy.
- **Enemy Class:** Hazard enemy / animated trap.
- **Movement Behavior:** Slams down on platforms.
- **Attack Behavior:** Timed slam damage.
- **Primary Threat:** Forces movement timing and platform awareness.
- **Weakness / Counterplay:** Wait for slam, pass during recovery.
- **Environment Interaction:** Also appears as weapon concept; keep enemy/hazard version separate.
- **Status:** Canonical hazard/enemy.

### Chicken / Egg Variants

- **Level Source:** Egg Factory Frenzy visual references.
- **Enemy Class:** Variant pool.
- **Movement Behavior:** Could reuse chase, fly, or shell-crack behavior.
- **Attack Behavior:** Peck, yolk drop, shell burst.
- **Primary Threat:** Visual and behavior variety.
- **Weakness / Counterplay:** Should use readable telegraphs.
- **Environment Interaction:** Factory belts, yolk spills, egg chutes.
- **Status:** Variant.

### Cracked Egg Creatures

- **Level Source:** Egg Factory Frenzy visual references.
- **Enemy Class:** Ground or hatching enemy.
- **Movement Behavior:** Emerges from cracked eggs.
- **Attack Behavior:** Contact damage or short hop.
- **Primary Threat:** Surprise spawn from environmental props.
- **Weakness / Counterplay:** Attack shell before hatch, or stomp/strike after emergence.
- **Environment Interaction:** Can be spawned by egg chutes.
- **Status:** Variant.

---

## Citrus Cascade Enemies

### Squeezing Machines

- **Level Source:** Citrus Cascade.
- **Enemy Class:** Stationary turret / machine enemy.
- **Movement Behavior:** Usually stationary.
- **Attack Behavior:** Shoots or spits juice jets.
- **Primary Threat:** Pushes player into hazards or off platforms.
- **Weakness / Counterplay:** Time shots, disable with switch, attack during cooldown.
- **Environment Interaction:** Can be linked to juice pipe systems.
- **Status:** Canonical.

### Lemon Bats

- **Level Source:** Citrus Cascade.
- **Enemy Class:** Flying swooper.
- **Movement Behavior:** Zigzags, then swoops down to attack.
- **Attack Behavior:** Swoop contact damage.
- **Primary Threat:** Pressures airborne movement near launchers.
- **Weakness / Counterplay:** Bait swoop, attack after missed dive.
- **Environment Interaction:** Moves over juice streams and citrus platforms.
- **Status:** Canonical.

### Orange Peel Traps

- **Level Source:** Citrus Cascade.
- **Enemy Class:** Rolling trap enemy.
- **Movement Behavior:** Rolls across platforms or slopes.
- **Attack Behavior:** Contact damage or trip effect.
- **Primary Threat:** Controls ground lanes.
- **Weakness / Counterplay:** Jump, block, or destroy.
- **Environment Interaction:** Works with slippery juice streams.
- **Status:** Canonical.

### Citrus Bat Variants

- **Level Source:** Citrus Cascade visual references.
- **Enemy Class:** Flying variant.
- **Movement Behavior:** Similar to Lemon Bats with possible alternate speed.
- **Attack Behavior:** Swoop or spit citrus drops.
- **Primary Threat:** Adds air-pattern variety.
- **Weakness / Counterplay:** Ranged attacks and baited swoops.
- **Environment Interaction:** Citrus canopy and juice cascade sections.
- **Status:** Variant.

### Juice Machine Hazards

- **Level Source:** Citrus Cascade visual references.
- **Enemy Class:** Environmental hazard / turret variant.
- **Movement Behavior:** Stationary or rotating.
- **Attack Behavior:** Sprays juice, squeezes, or launches projectiles.
- **Primary Threat:** Pushback and lane denial.
- **Weakness / Counterplay:** Disable by switch or timed opening.
- **Environment Interaction:** Integrated into pipe and juicer systems.
- **Status:** Variant / environmental hazard.

---

## Bakery Bonanza Enemies

### Flour Bag Monsters

- **Level Source:** Bakery Bonanza.
- **Enemy Class:** Visibility-control enemy.
- **Movement Behavior:** Slow patrol or stationary puff cycles.
- **Attack Behavior:** Puffs flour clouds that obscure visibility.
- **Primary Threat:** Reduces player visibility and platform readability.
- **Weakness / Counterplay:** Attack between puffs; use wind/spray/clear mechanic if implemented.
- **Environment Interaction:** Flour clouds can exist as both enemy attack and ambient hazard.
- **Status:** Canonical.

### Rolling Muffin Trays

- **Level Source:** Bakery Bonanza.
- **Enemy Class:** Rolling hazard enemy.
- **Movement Behavior:** Rolls across platforms.
- **Attack Behavior:** Contact damage.
- **Primary Threat:** Controls lanes and interrupts movement.
- **Weakness / Counterplay:** Jump over, block, or destroy with heavy attack.
- **Environment Interaction:** Works on conveyors and sloped bakery ramps.
- **Status:** Canonical.

### Burning Muffins

- **Level Source:** Bakery Bonanza.
- **Enemy Class:** Charging fire enemy.
- **Movement Behavior:** Charges at player.
- **Attack Behavior:** Contact fire damage.
- **Primary Threat:** Forces fast dodging in hot zones.
- **Weakness / Counterplay:** Attack after charge or use cooling/water effect.
- **Environment Interaction:** Near ovens and hot racks.
- **Status:** Canonical.

### Muffin Enemy Variants

- **Level Source:** Bakery Bonanza visual references.
- **Enemy Class:** Variant pool.
- **Movement Behavior:** Could hop, roll, or charge.
- **Attack Behavior:** Contact, crumb burst, or explosive muffin.
- **Primary Threat:** Adds variety to bakery encounters.
- **Weakness / Counterplay:** Use existing muffin behavior rules.
- **Environment Interaction:** Conveyor belts, ovens, flour clouds.
- **Status:** Variant.

### Oven / Muffin Machine Hazards

- **Level Source:** Bakery Bonanza visual references.
- **Enemy Class:** Environmental hazard / machine enemy.
- **Movement Behavior:** Stationary or timed.
- **Attack Behavior:** Heat bursts, tray launches, muffin launches.
- **Primary Threat:** Area denial.
- **Weakness / Counterplay:** Timed movement or oven mitt protection.
- **Environment Interaction:** Integrated into bakery machinery.
- **Status:** Variant / environmental hazard.

---

## Bosses / Culprits

Bosses should use separate boss classes rather than inheriting directly from regular enemy AI, because each boss has unique phases, vulnerability windows, and arena mechanics.

### Bailey “Bacon Bandit” Brown

- **Level Source:** Grease Canyon.
- **Culprit Title:** Bacon Bandit.
- **Crime:** Takes an entire plate of bacon.
- **Boss Class:** Spinning arena boss.
- **Main Attack:** Bacon Tornado.
- **Arena Mechanic:** Flying bacon debris, bacon spiral columns, grease floor pressure.
- **Counterplay:** Jump between platforms, avoid debris, attack with Bacon Gun when boss slows.
- **Possible States:** Spinning, slowed, stunned, fleeing.
- **Status:** Canonical.

### Cameron “Croissant Crook” Cline

- **Level Source:** Pastry Palace.
- **Culprit Title:** Croissant Crook.
- **Crime:** Sneaks croissants into their purse.
- **Boss Class:** Ranged / dash boss.
- **Main Attacks:** Throws oversized croissants, dashes around arena.
- **Arena Mechanic:** Croissants stick to ground and block movement.
- **Counterplay:** Use Syrup Boots to move through sticky areas; attack during throwing windows.
- **Possible States:** Throwing, dashing, summoning, vulnerable.
- **Status:** Canonical.

### Skyler “Syrup Scoundrel” Sugars

- **Level Source:** Sticky Syrup Swamp.
- **Culprit Title:** Syrup Scoundrel.
- **Crime:** Dumps syrup all over the buffet.
- **Boss Class:** Area-denial ranged boss.
- **Main Attack:** Syrup cannon.
- **Arena Mechanic:** Covers parts of arena with syrup.
- **Counterplay:** Avoid syrup pools and attack during reload.
- **Possible States:** Spraying, reloading, vulnerable, fleeing.
- **Status:** Canonical.

### Casey “Cutlery Thief” Canes

- **Level Source:** Kitchen Mayhem.
- **Culprit Title:** Cutlery Thief.
- **Crime:** Steals forks, spoons, and knives.
- **Boss Class:** Ranged projectile / cover boss.
- **Main Attacks:** Throws stolen cutlery.
- **Arena Mechanic:** Hides behind piles of dishes.
- **Counterplay:** Break dishes to expose boss; dodge flying cutlery.
- **Possible States:** Hiding, throwing, exposed, fleeing.
- **Status:** Canonical.

### Drew “Dessert Hoarder” Sweet

- **Level Source:** Candy Chaos.
- **Culprit Title:** Dessert Hoarder.
- **Crime:** Hoards all the desserts at the buffet.
- **Boss Class:** Vehicle boss.
- **Main Attack:** Throws explosive candy from giant rolling cake.
- **Arena Mechanic:** Sprinkler switches wash cake away.
- **Counterplay:** Jump on switches, wash cake away, knock boss off cake.
- **Possible States:** Riding, throwing, washed, vulnerable.
- **Status:** Canonical.

### Morgan “Omelet Overlord” Eggman

- **Level Source:** Egg Factory Frenzy.
- **Culprit Title:** Omelet Overlord.
- **Crime:** Takes all eggs to make a giant omelet.
- **Boss Class:** Platform-control boss.
- **Main Attack:** Spatula flip.
- **Arena Mechanic:** Flips player off platforms and uses egg machinery.
- **Counterplay:** Use Egg Launcher to crack defenses; avoid platform flips.
- **Possible States:** Guarded, flipping, cracked, vulnerable.
- **Status:** Canonical.

### Jordan “Juice Jacker” Squeeze

- **Level Source:** Citrus Cascade.
- **Culprit Title:** Juice Jacker.
- **Crime:** Steals all orange juice in bottles.
- **Boss Class:** Ranged stream boss.
- **Main Attack:** Juicer gun sprays juice streams.
- **Arena Mechanic:** Juice streams push player and control lanes.
- **Counterplay:** Dodge streams, attack when boss pauses to reload.
- **Possible States:** Spraying, reloading, vulnerable, fleeing.
- **Status:** Canonical.

### Quinn “Muffin Mastermind” Munch

- **Level Source:** Bakery Bonanza.
- **Culprit Title:** Muffin Mastermind.
- **Crime:** Hides muffins in their hat.
- **Boss Class:** Projectile / cover boss.
- **Main Attack:** Throws explosive muffins.
- **Arena Mechanic:** Hides behind piles of baking trays.
- **Counterplay:** Clear trays to expose boss and attack.
- **Possible States:** Covered, throwing, exposed, vulnerable.
- **Status:** Canonical.
