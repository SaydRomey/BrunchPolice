# Enemy Roster — Behavior and Counterplay

This catalog specifies regular enemies and mechanical enemy-like threats. They use an `EnemyDefinition`, a movement/attack strategy and a shared hit receiver/status adapter. Bosses remain distinct encounter controllers; use the [boss document](../11-bosses-and-encounters.md) for their phases.


## Enemy System Baseline

Regular enemies use a reusable `BaseEnemy` behavior framework where appropriate.

Suggested reusable properties:

- `enemy_id`
- `display_name`
- `world_id`
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

- **World:** Grease Canyon.
- **Enemy Class:** Ground charger.
- **Movement Behavior:** Patrols platforms, then charges when the player enters detection range.
- **Attack Behavior:** Contact damage and knockback.
- **Primary Threat:** Can knock player off platforms into boiling grease.
- **Weakness / Counterplay:** Jump over charge, attack during recovery, use Bacon Gun or grease-slide stun.
- **Environment Interaction:** Platform-aware; should avoid walking off ledges unless charging.
- **Status:** Canonical.

### Bacon Worms

- **World:** Grease Canyon.
- **Enemy Class:** Rope / vertical crawler.
- **Movement Behavior:** Slithers or moves up and down sausage-link ropes.
- **Attack Behavior:** Contact damage; possible lunge if player gets close.
- **Primary Threat:** Blocks rope traversal and vertical routes.
- **Weakness / Counterplay:** Time climbs between movement cycles or use ranged weapon.
- **Environment Interaction:** Attached to sausage ropes; can fall into grease if dislodged.
- **Status:** Canonical.

### Flying Sausage Links

- **World:** Grease Canyon.
- **Enemy Class:** Flying swooper.
- **Movement Behavior:** Hovers, flaps, then swoops down at the player.
- **Attack Behavior:** Swoop contact damage.
- **Primary Threat:** Pressures jumps over grease pits.
- **Weakness / Counterplay:** Bait swoop, dodge, attack during recovery.
- **Environment Interaction:** Can cross gaps and ignore ground hazards.
- **Status:** Canonical.

### Pig / Bacon Enemy Variants

- **World:** Grease Canyon visual references.
- **Enemy Class:** Variant pool.
- **Movement Behavior:** Select a supported movement archetype for the finished sprite.
- **Attack Behavior:** Could reuse pig charge, bacon debris throw, or platform patrol.
- **Primary Threat:** Adds visual variety.
- **Weakness / Counterplay:** Should reuse existing readable behaviors.
- **Environment Interaction:** Bacon platforms and grease hazards.
- **Status:** Variant / visual concept.

### Chef-Pig / Armored Pig Figures

- **World:** Grease Canyon visual references.
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

- **World:** Pastry Palace.
- **Enemy Class:** Flying ranged enemy.
- **Movement Behavior:** Hovers near lanes or patrol points.
- **Attack Behavior:** Shoots whipped cream projectiles.
- **Primary Threat:** Forces player movement during platforming.
- **Weakness / Counterplay:** Dodge projectiles, attack between shots.
- **Environment Interaction:** Works well near rotating mixer platforms and frosting slowdown zones.
- **Status:** Canonical.

### Rolling Baguette

- **World:** Pastry Palace.
- **Enemy Class:** Rolling hazard enemy.
- **Movement Behavior:** Rolls along platforms and slopes.
- **Attack Behavior:** Contact damage.
- **Primary Threat:** Controls horizontal lanes.
- **Weakness / Counterplay:** Jump over, shield, or destroy with heavy weapon.
- **Environment Interaction:** Can be spawned by Croissant Crook or released from shelves.
- **Status:** Canonical.

### Jelly-Filled Donuts

- **World:** Pastry Palace.
- **Enemy Class:** Chaser / explosive enemy.
- **Movement Behavior:** Chases player when nearby.
- **Attack Behavior:** Explodes on contact.
- **Primary Threat:** Denies safe standing spots and punishes slow movement.
- **Weakness / Counterplay:** Kite into safe detonation range or destroy early.
- **Environment Interaction:** Leaves sticky jam puddle if implemented.
- **Status:** Canonical.

### Rolling Croissants

- **World:** Pastry Palace boss-summon concept.
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

- **World:** Sticky Syrup Swamp.
- **Enemy Class:** Flying swarm enemy.
- **Movement Behavior:** Buzzes in circular pattern and attacks when nearby.
- **Attack Behavior:** Swoop or sting.
- **Primary Threat:** Pressures player while movement is slowed by syrup.
- **Weakness / Counterplay:** Use ranged weapons or bait attack path.
- **Environment Interaction:** Can destroy barricades if destructible-aware behavior is enabled.
- **Status:** Canonical.

### Syrup Golems

- **World:** Sticky Syrup Swamp.
- **Enemy Class:** Heavy ground charger.
- **Movement Behavior:** Rises from syrup floor, then charges.
- **Attack Behavior:** Heavy contact damage or slam.
- **Primary Threat:** Forces movement in sticky zones.
- **Weakness / Counterplay:** Attack during emergence or after charge recovery.
- **Environment Interaction:** Emerges from syrup pools; may be healed or hidden by syrup.
- **Status:** Canonical.

### Flying Butter Pats

- **World:** Sticky Syrup Swamp.
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

- **World:** Kitchen Mayhem.
- **Enemy Class:** Ground ranged enemy.
- **Movement Behavior:** Holds position or patrols short range.
- **Attack Behavior:** Throws knives in arcs.
- **Primary Threat:** Forces dodging while traversing counters and carts.
- **Weakness / Counterplay:** Close distance, block with Hot Lid, attack during throw cooldown.
- **Environment Interaction:** Can stand behind kitchen clutter or destructible cover.
- **Status:** Canonical.

### Dishwashing Sponges

- **World:** Kitchen Mayhem.
- **Enemy Class:** Jumper.
- **Movement Behavior:** Hops toward the player.
- **Attack Behavior:** Jump contact damage.
- **Primary Threat:** Unpredictable vertical pressure.
- **Weakness / Counterplay:** Attack after landing or knock back mid-hop.
- **Environment Interaction:** Can interact with wet floors and dishwater.
- **Status:** Canonical.

### Spinning Ladles

- **World:** Kitchen Mayhem.
- **Enemy Class:** Stationary hazard enemy.
- **Movement Behavior:** Spins in place or along a fixed track.
- **Attack Behavior:** Contact damage.
- **Primary Threat:** Controls tight passages.
- **Weakness / Counterplay:** Time movement or disable with switch.
- **Environment Interaction:** Blends with kitchen utensil hazard language.
- **Status:** Canonical.

### Chef / Cutlery Variants

- **World:** Kitchen Mayhem visual references.
- **Enemy Class:** Variant pool.
- **Movement Behavior:** Can reuse chef throw, patrol, or rush behavior.
- **Attack Behavior:** Cutlery projectiles or melee swings.
- **Primary Threat:** Adds variety to kitchen enemy encounters.
- **Weakness / Counterplay:** Should follow visible windups.
- **Environment Interaction:** Uses dish piles, counters, and utensil racks.
- **Status:** Variant.

---

## Caffeine Craze Enemies

### Bean Bouncers

- **Role:** Fast ground hopper.
- **Movement:** A short anticipatory squash precedes each bounce. Repeated hops can accelerate but have a maximum speed.
- **Attack:** Jump contact damage with a recovery landing frame.
- **Counterplay:** Read the squash, jump over, punish the landing or intercept at range.
- **Environment:** Introduced away from steam, then paired with low-pressure windows.

### Grinder Gremlins

- **Role:** Armored short-range machine gunner.
- **Movement:** Anchored position or brief guarded patrol.
- **Attack:** Telegraph a grinding windup, fire short bursts of grounds; grinder teeth have contact damage.
- **Counterplay:** Approach between bursts, use heavy stun or pressure-valve machinery.
- **Environment:** Roasting Room and mechanical perches.

### Froth Flyers

- **Role:** Flying control enemy.
- **Movement:** Hover/patrol above approach lanes.
- **Attack:** Launch foam bubbles which briefly wrap or slow on hit.
- **Counterplay:** Dodge between launch cycles, destroy at range or break status by defined escape input.
- **Environment:** Espresso Engine vertical lifts and foam platforms.
## Egg Factory Frenzy Enemies

### Angry Chickens

- **World:** Egg Factory Frenzy.
- **Enemy Class:** Ground chaser.
- **Movement Behavior:** Chases player.
- **Attack Behavior:** Peck attack.
- **Primary Threat:** Pressures player on conveyors.
- **Weakness / Counterplay:** Jump over, stun, or knock into machinery.
- **Environment Interaction:** Conveyor-aware movement recommended.
- **Status:** Canonical.

### Eggshell Drones

- **World:** Egg Factory Frenzy.
- **Enemy Class:** Flying bomber.
- **Movement Behavior:** Flies above player or patrols overhead.
- **Attack Behavior:** Drops yolk bombs.
- **Primary Threat:** Creates slippery or damaging zones below.
- **Weakness / Counterplay:** Attack from range or bait drops away from route.
- **Environment Interaction:** Strong near conveyor belts and factory platforms.
- **Status:** Canonical.

### Frying Pans

- **World:** Egg Factory Frenzy.
- **Enemy Class:** Hazard enemy / animated trap.
- **Movement Behavior:** Slams down on platforms.
- **Attack Behavior:** Timed slam damage.
- **Primary Threat:** Forces movement timing and platform awareness.
- **Weakness / Counterplay:** Wait for slam, pass during recovery.
- **Environment Interaction:** Also appears as weapon concept; keep enemy/hazard version separate.
- **Status:** Canonical hazard/enemy.

### Chicken / Egg Variants

- **World:** Egg Factory Frenzy visual references.
- **Enemy Class:** Variant pool.
- **Movement Behavior:** Could reuse chase, fly, or shell-crack behavior.
- **Attack Behavior:** Peck, yolk drop, shell burst.
- **Primary Threat:** Visual and behavior variety.
- **Weakness / Counterplay:** Should use readable telegraphs.
- **Environment Interaction:** Factory belts, yolk spills, egg chutes.
- **Status:** Variant.

### Cracked Egg Creatures

- **World:** Egg Factory Frenzy visual references.
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

- **World:** Citrus Cascade.
- **Enemy Class:** Stationary turret / machine enemy.
- **Movement Behavior:** Usually stationary.
- **Attack Behavior:** Shoots or spits juice jets.
- **Primary Threat:** Pushes player into hazards or off platforms.
- **Weakness / Counterplay:** Time shots, disable with switch, attack during cooldown.
- **Environment Interaction:** Can be linked to juice pipe systems.
- **Status:** Canonical.

### Lemon Bats

- **World:** Citrus Cascade.
- **Enemy Class:** Flying swooper.
- **Movement Behavior:** Zigzags, then swoops down to attack.
- **Attack Behavior:** Swoop contact damage.
- **Primary Threat:** Pressures airborne movement near launchers.
- **Weakness / Counterplay:** Bait swoop, attack after missed dive.
- **Environment Interaction:** Moves over juice streams and citrus platforms.
- **Status:** Canonical.

### Orange Peel Traps

- **World:** Citrus Cascade.
- **Enemy Class:** Rolling trap enemy.
- **Movement Behavior:** Rolls across platforms or slopes.
- **Attack Behavior:** Contact damage or trip effect.
- **Primary Threat:** Controls ground lanes.
- **Weakness / Counterplay:** Jump, block, or destroy.
- **Environment Interaction:** Works with slippery juice streams.
- **Status:** Canonical.

### Citrus Bat Variants

- **World:** Citrus Cascade visual references.
- **Enemy Class:** Flying variant.
- **Movement Behavior:** Similar to Lemon Bats with possible alternate speed.
- **Attack Behavior:** Swoop or spit citrus drops.
- **Primary Threat:** Adds air-pattern variety.
- **Weakness / Counterplay:** Ranged attacks and baited swoops.
- **Environment Interaction:** Citrus canopy and juice cascade sections.
- **Status:** Variant.

### Juice Machine Hazards

- **World:** Citrus Cascade visual references.
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

- **World:** Bakery Bonanza.
- **Enemy Class:** Visibility-control enemy.
- **Movement Behavior:** Slow patrol or stationary puff cycles.
- **Attack Behavior:** Puffs flour clouds that obscure visibility.
- **Primary Threat:** Reduces player visibility and platform readability.
- **Weakness / Counterplay:** Attack between puffs; use wind/spray/clear mechanic if implemented.
- **Environment Interaction:** Flour clouds can exist as both enemy attack and ambient hazard.
- **Status:** Canonical.

### Rolling Muffin Trays

- **World:** Bakery Bonanza.
- **Enemy Class:** Rolling hazard enemy.
- **Movement Behavior:** Rolls across platforms.
- **Attack Behavior:** Contact damage.
- **Primary Threat:** Controls lanes and interrupts movement.
- **Weakness / Counterplay:** Jump over, block, or destroy with heavy attack.
- **Environment Interaction:** Works on conveyors and sloped bakery ramps.
- **Status:** Canonical.

### Burning Muffins

- **World:** Bakery Bonanza.
- **Enemy Class:** Charging fire enemy.
- **Movement Behavior:** Charges at player.
- **Attack Behavior:** Contact fire damage.
- **Primary Threat:** Forces fast dodging in hot zones.
- **Weakness / Counterplay:** Attack after charge or use cooling/water effect.
- **Environment Interaction:** Near ovens and hot racks.
- **Status:** Canonical.

### Muffin Enemy Variants

- **World:** Bakery Bonanza visual references.
- **Enemy Class:** Variant pool.
- **Movement Behavior:** Could hop, roll, or charge.
- **Attack Behavior:** Contact, crumb burst, or explosive muffin.
- **Primary Threat:** Adds variety to bakery encounters.
- **Weakness / Counterplay:** Use existing muffin behavior rules.
- **Environment Interaction:** Conveyor belts, ovens, flour clouds.
- **Status:** Variant.

### Oven / Muffin Machine Hazards

- **World:** Bakery Bonanza visual references.
- **Enemy Class:** Environmental hazard / machine enemy.
- **Movement Behavior:** Stationary or timed.
- **Attack Behavior:** Heat bursts, tray launches, muffin launches.
- **Primary Threat:** Area denial.
- **Weakness / Counterplay:** Timed movement or oven mitt protection.
- **Environment Interaction:** Integrated into bakery machinery.
- **Status:** Variant / environmental hazard.

---

