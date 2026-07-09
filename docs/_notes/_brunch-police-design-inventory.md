# Master Brunch Police Design Inventory

**Status:** Consolidated current-design inventory  
**Purpose:** Preserve every current design element, enemy, weapon, mechanic, system, inclusive naming note, and implementation concept before reorganizing or adding new material.  
**Rule:** Nothing in this file is deleted because it is duplicated or unresolved. Duplicates are marked as `Variant`, `Legacy`, `Canonical`, `TBD`, or `Needs merge`.

---

## 0. Source Coverage

This inventory consolidates material from the current project files and newly added implementation files:

### Core Design Files
- `README.md`
- `game-design-doc.md`
- `character-and-level-design.md`
- `interaction-system.md`
- `dialogue-system.md`
- `lgbtq+.md`

### Level Files
- `grease-canyon.md`
- `pastry-palace.md`
- `sticky-syrup-swamp.md`
- `kitchen-mayhem.md`
- `candy-chaos.md`
- `egg-factory-frenzy.md`
- `citrus-cascade.md`
- `bakery-bonanza.md`

### Weapon Files
- `weapons.md`
- `weapons-bacon-gun.md`
- `weapons-level-reward.md`
- `weapons-level-specific.md`

### Combat / AI / Implementation Files
- `visual-feedback.md`
- `projectile-manager.md`
- `invincibility-frames.md`
- `health-component.md`
- `damage-calculation.md`
- `enemy-states.md`
- `enemy-spawner.md`
- `enemy-ai-specific-examples.md`
- `enemy-ai-movement.md`
- `enemy-ai-environment-interactions.md`

### Visual Reference Inputs From Conversation
The concept images supplied in the chat are treated as current visual reference material. They are assigned below by level.

---

## 1. Canonical Game Identity

| Field                 | Current Canonical Value                                                                               |
| --------------------- | ----------------------------------------------------------------------------------------------------- |
| Game Title            | **Brunch Police**                                                                                     |
| Genre                 | Action-adventure with platforming and investigative elements                                          |
| Hub Style             | Isometric / top-down brunch buffet hub                                                                |
| Level Style           | 2D side-scrolling platformer levels                                                                   |
| Engine                | Godot                                                                                                 |
| Programming Direction | Godot + C++ / GDNative-style architecture from current docs                                           |
| Tone                  | Quirky, humorous, lighthearted, food-themed                                                           |
| Visual Direction      | Bright cartoon/pixel hybrid, exaggerated food props, wacky platform environments                      |
| Audio Direction       | Relaxing brunch hub music; faster quirky level music; food splats, sizzling grease, dialogue snippets |

---

## 2. Core Gameplay Loop

### 2.1 Investigation Hub Loop

1. Player acts as the unofficial **Brunch Police**.
2. Player roams a brunch buffet hub.
3. Player interacts with NPCs.
4. Player inspects plates and suspicious buffet behavior.
5. Player gathers clues through dialogue and inspection.
6. Player accuses NPCs.
7. Incorrect accusations produce humorous NPC responses.
8. Correct accusations trigger a culprit fleeing sequence.
9. Culprit escapes through a themed transition area.
10. Player enters a themed 2D platforming level.
11. Player defeats enemies, avoids hazards, collects evidence, and uses weapons/power-ups.
12. Player confronts and defeats the culprit boss.
13. Player returns to the brunch hub to continue investigating.

### 2.2 Existing Culprit Fleeing Exit Concepts

| Exit Area | Current Concept                        |
| --------- | -------------------------------------- |
| Main Exit | Street-themed platformer levels        |
| Bathroom  | Toilet/pipes-themed platformer levels  |
| Kitchen   | Staff-only / kitchen platformer levels |

### 2.3 Existing Hub Areas

- Buffet tables
- Seating areas
- Drinks station
- Dessert bar
- General brunch crowd space
- Inspection targets: plates, suspicious food stacks, hidden items, buffet messes

---

## 3. Inclusive Naming Canon

The `lgbtq+.md` file provides inclusive names. These are now the **canonical active names** for culprits. Old names remain as legacy references only.

| Level              | Culprit Title                | Legacy Name                     | Canonical Inclusive Name            | Status                                         |
| ------------------ | ---------------------------- | ------------------------------- | ----------------------------------- | ---------------------------------------------- |
| Grease Canyon      | Bacon Bandit                 | Barry “Bacon Bandit” Brown      | **Bailey “Bacon Bandit” Brown**     | Canonical replacement                          |
| Pastry Palace      | Croissant Crook              | Clara “Croissant Crook” Cline   | **Cameron “Croissant Crook” Cline** | Canonical replacement                          |
| Sticky Syrup Swamp | Syrup Scoundrel              | Simon “Syrup Scoundrel” Sugars  | **Skyler “Syrup Scoundrel” Sugars** | Canonical replacement                          |
| Kitchen Mayhem     | Cutlery Thief / Cutlery Carl | Carl “Cutlery Carl” Canes       | **Casey “Cutlery Thief” Canes**     | Canonical replacement; title needs consistency |
| Candy Chaos        | Dessert Hoarder              | Debbie “Dessert Hoarder” Sweet  | **Drew “Dessert Hoarder” Sweet**    | Canonical replacement                          |
| Egg Factory Frenzy | Omelet Overlord              | Oliver “Omelet Overlord” Eggman | **Morgan “Omelet Overlord” Eggman** | Canonical replacement                          |
| Citrus Cascade     | Juice Jacker                 | Julie “Juice Jacker” Squeeze    | **Jordan “Juice Jacker” Squeeze**   | Canonical replacement                          |
| Bakery Bonanza     | Muffin Mastermind            | Marty “Muffin Mastermind” Munch | **Quinn “Muffin Mastermind” Munch** | Canonical replacement                          |

### 3.1 Inclusive Name Bank

The available inclusive name bank includes:

Adrian, Alex, Ash, Avery, Bailey, Blake, Cameron, Casey, Charlie, Devon, Drew, Ellis, Harper, Jamie, Jordan, Jules, Kai, Logan, Morgan, Parker, Peyton, Quinn, Reese, Remy, Riley, Rowan, Sage, Sam, Skyler, Taylor.

### 3.2 Inclusion Systems To Preserve

- Diverse NPC body types, gender expressions, clothing styles.
- Same-sex couples, non-binary couples, and diverse couples in brunch crowd scenes.
- Player customization with appearance, pronouns, and non-binary options.
- Casual partner mentions in dialogue.
- Pride/rainbow decor as environmental storytelling.
- “All Are Welcome” signage.
- Rainbow Pancakes.
- Pride Smoothie.
- Framed photos of diverse couples.
- Proposal side quest between NPCs.
- Rainbow Boosts.
- Inclusive achievement: **Everyone’s Welcome!**
- Level-specific pride details:
  - Grease Canyon: rainbow-tinted bacon flag.
  - Candy Chaos: pride cupcake.
  - Sticky Syrup Swamp: rainbow syrup bottle labels.
  - Citrus Cascade: pride-colored citrus decorations.

---

## 4. Current Level Roster Overview

| Order | Level              | Canonical Culprit               | Crime                                 | Primary Fantasy                                           |
| ----: | ------------------ | ------------------------------- | ------------------------------------- | --------------------------------------------------------- |
|     1 | Grease Canyon      | Bailey “Bacon Bandit” Brown     | Takes an entire plate of bacon        | Bacon platforms, grease pits, pig enemies, bacon tornado  |
|     2 | Pastry Palace      | Cameron “Croissant Crook” Cline | Sneaks croissants into their purse    | Croissant platforms, dough mixers, pastries, sticky syrup |
|     3 | Sticky Syrup Swamp | Skyler “Syrup Scoundrel” Sugars | Dumps syrup all over the buffet       | Syrup waterfalls, pancake rafts, bees, syrup cannon       |
|     4 | Kitchen Mayhem     | Casey “Cutlery Thief” Canes     | Steals forks, spoons, and knives      | Back-kitchen chaos, knives, pots, pans, chefs             |
|     5 | Candy Chaos        | Drew “Dessert Hoarder” Sweet    | Hoards all desserts at the buffet     | Candy bridges, chocolate lava, gumdrops, rolling cake     |
|     6 | Egg Factory Frenzy | Morgan “Omelet Overlord” Eggman | Takes all the eggs for a giant omelet | Conveyors, yolk traps, chickens, egg machines             |
|     7 | Citrus Cascade     | Jordan “Juice Jacker” Squeeze   | Steals all orange juice bottles       | Juice waterfalls, citrus platforms, juicers, lemon bats   |
|     8 | Bakery Bonanza     | Quinn “Muffin Mastermind” Munch | Hides muffins in their hat            | Ovens, dough platforms, flour clouds, muffin enemies      |

---

# 5. Level Inventories

---

## 5.1 Grease Canyon

### Identity

| Field             | Value                                                      |
| ----------------- | ---------------------------------------------------------- |
| Level             | Grease Canyon                                              |
| Culprit Title     | Bacon Bandit                                               |
| Canonical Culprit | Bailey “Bacon Bandit” Brown                                |
| Legacy Culprit    | Barry “Bacon Bandit” Brown                                 |
| Crime             | Takes an entire plate of bacon                             |
| Palette           | Warm reds, oranges, golds, browns, breakfast-food textures |
| Core Feel         | Hot, greasy, slippery, smoky, sizzling                     |

### Level Elements

- Platforms made of sizzling bacon strips.
- Animated bacon strips in warm reds and browns.
- Bacon platforms with slight wiggle animation to show heat and grease.
- Fat dripping from platform edges with looping pixel shimmer.
- Pits of boiling grease bubbling below.
- Boiling grease pits with golden-yellow bubbling animation.
- Occasional grease splashes from pits.
- Dripping grease from ceilings and edges.
- Ropes made of hanging sausage links.
- Sausage-link ropes animated to sway slightly.
- Ropes attached to bacon ceilings with glistening fat at the joints.
- Sizzling griddles.
- Huge cracked eggs floating in the sky.
- Pixel clouds shaped like bacon grease blobs.
- Bacon comets / parallax objects zipping by.
- Bacon spiral columns.
- Bacon tornado boss-arena effect loop.
- Wooden/bacon platform structures from visual references.
- Lava-like grease floor from visual references.
- Hanging bacon-strip hazards from visual references.
- Pig platforms/enemy staging areas from visual references.

### Background / Environmental Storytelling

- Sizzling griddles.
- Fat clouds.
- Giant cracked eggs in the sky.
- Bacon grease blob clouds.
- Bacon comets for parallax.
- Rainbow-tinted bacon flag as inclusive environmental detail.

### Hazards

- Boiling grease pits.
- Grease splashes.
- Slippery grease-covered surfaces.
- Hot bacon platforms.
- Flying bacon debris during boss fight.
- Bacon tornado hazard.
- Hanging bacon strips and swinging sausage ropes.

### Mechanics

- Slippery movement on grease.
- Bacon platform timing / wiggle readability.
- Rope traversal using sausage links.
- Jump timing over grease pits.
- Dash / slide movement through **Grease Slide** power-up.
- Boss vulnerability window after Bacon Tornado slows.
- Bacon Gun attacks usable against boss during slowdown.

### Enemies

| Enemy                          | Current Behavior                            | Status                          |
| ------------------------------ | ------------------------------------------- | ------------------------------- |
| Small Angry Pigs               | Patrol / charge; knock player off platforms | Canonical                       |
| Bacon Worms                    | Slither or move up/down sausage ropes       | Canonical                       |
| Flying Sausage Links           | Hover/flap and swoop down at player         | Canonical                       |
| Pig/Bacon enemy variants       | Seen in visual references                   | Variant / visual concept        |
| Chef-pig / armored pig figures | Seen in visual references                   | Variant / boss-minion candidate |

### Boss Fight

| Field              | Current Design                                                                           |
| ------------------ | ---------------------------------------------------------------------------------------- |
| Boss               | Bailey “Bacon Bandit” Brown                                                              |
| Legacy boss visual | Pixel shades, apron, bacon-whip arm                                                      |
| Main attack        | Bacon Tornado: spins wildly with bacon flying everywhere                                 |
| Arena              | Center platform, wider than normal, bacon spiral columns, tornado FX loop                |
| Counterplay        | Jump between platforms, avoid flying bacon debris, attack with Bacon Gun when boss slows |
| Possible states    | Stunned after grease-trail or Bacon Gun counter; fleeing below health threshold          |

### Power-Ups

- Grease Slide: dash move / quick-dash streak / leaves grease trail.
- Extra Bacon: golden bacon shield; absorbs one hit from flying bacon debris.
- Bacon Grease Slide: dash move that leaves a slowing trail.
- Extra Bacon shield: temporary bacon shield.

### Evidence

- Bacon Strips.
- Animated bacon strips glimmer when untouched.

### Weapons Connected To Level

| Weapon               | Type               | Source Category      | Notes                                                             |
| -------------------- | ------------------ | -------------------- | ----------------------------------------------------------------- |
| Bacon Gun            | Ranged             | Global / special     | Fires strips of bacon to immobilize or wrap enemies               |
| Bacon Gun projectile | Projectile         | Special              | Bacon strips can damage, wrap, or immobilize based on enemy class |
| Grease/slide trail   | Utility / movement | Power-up interaction | Slows enemies and may stun Bacon Bandit                           |

### Bacon Gun Effect Rules

| Target Category | Effect                                                      |
| --------------- | ----------------------------------------------------------- |
| Small enemy     | Killed                                                      |
| Medium enemy    | Damaged and wrapped; may be killed on critical damage       |
| Large mob       | Damaged only or partial immobilization                      |
| Boss            | Immune or damaged only, with specific vulnerability windows |

### Visual References Assigned

- First image batch: large croissant/donut machine image is more Pastry Palace, not Grease Canyon.
- First image batch: bacon level overview with hanging bacon, pigs, grease, sausage ropes.
- First image batch: bacon boss-arena image with pig chefs, bacon strips, grease floor.

### Open / TBD

- Decide whether the chef-pig visual becomes a boss redesign, mini-boss, or regular enemy.
- Decide whether Bacon Gun is a permanent global weapon, Grease Canyon-specific weapon, or early signature weapon.

---

## 5.2 Pastry Palace

### Identity

| Field             | Value                                                                       |
| ----------------- | --------------------------------------------------------------------------- |
| Level             | Pastry Palace                                                               |
| Culprit Title     | Croissant Crook                                                             |
| Canonical Culprit | Cameron “Croissant Crook” Cline                                             |
| Legacy Culprit    | Clara “Croissant Crook” Cline                                               |
| Crime             | Sneaks croissants into their purse                                          |
| Palette           | Pastry browns, cream, butter-yellow, frosting pinks, warm bakery tones      |
| Core Feel         | Elegant pastry theft, rotating mixers, croissant platforms, sticky slowdown |

### Level Elements

- Platforms made of stacked croissants.
- Baguette platforms.
- Cake platforms.
- Giant dough mixers that spin as rotating hazards.
- Sticky syrup puddles that slow movement.
- Donut platforms / donut decorations from visual references.
- Croissant stacks from visual references.
- Pastry factory machinery from visual references.
- Central dough mixer machine from visual references.
- Waterfall-like blue liquid from visual references, possibly cream/sugar-water flow.
- Donut/croissant collectibles or hazard objects.

### Background / Environmental Storytelling

- Decorative pastry architecture.
- Oversized bakery machinery.
- Croissant platforms layered like palace balconies.
- Pride decor can appear through bakery signage, pastry flags, or inclusive customer photos.

### Hazards

- Rotating dough mixers.
- Sticky syrup puddles.
- Oversized croissants thrown by boss that stick to the ground and block movement.
- Exploding jelly-filled donuts.
- Rolling baguettes.

### Mechanics

- Sticky movement slowdown.
- Rotating hazard timing.
- Croissant projectile obstruction.
- Boss dash patterns.
- Syrup Boots counter sticky movement.
- Possible mixer timing / rotating-platform traversal.

### Enemies

| Enemy                            | Current Behavior                          | Status                         |
| -------------------------------- | ----------------------------------------- | ------------------------------ |
| Flying Éclairs                   | Hover and shoot whipped cream projectiles | Canonical                      |
| Rolling Baguette                 | Rolls along platforms, contact damage     | Canonical                      |
| Jelly-filled Donuts              | Chase player and explode on contact       | Canonical                      |
| Donut / pastry machinery hazards | Seen in visual references                 | Variant / environmental hazard |

### Boss Fight

| Field          | Current Design                                                                         |
| -------------- | -------------------------------------------------------------------------------------- |
| Boss           | Cameron “Croissant Crook” Cline                                                        |
| Main attacks   | Throws oversized croissants; dashes around arena                                       |
| Obstruction    | Croissants stick to ground and block movement                                          |
| Counterplay    | Use Syrup Boots to move through sticky areas; attack while boss is throwing croissants |
| Possible state | Summoning state can spawn rolling croissants or baguettes                              |

### Power-Ups

- Syrup Trail: creates a sticky path to slow enemies.
- Whipped Cream Shield: absorbs one hit.
- Syrup Boots are referenced as a counter to sticky areas, though also treated globally in power-up docs.

### Evidence

- **TBD Evidence**: no explicit evidence item is currently specified in the source design.
- Candidate evidence to define later without inventing now: croissant crumbs, hidden croissant, purse receipt.

### Weapons Connected To Level

| Weapon                | Type                   | Source Category                    | Notes                              |
| --------------------- | ---------------------- | ---------------------------------- | ---------------------------------- |
| Croissant Cutter      | Main-hand              | Weapon examples                    | Pastry-themed blade                |
| Whipped Cream Shield  | Off-hand               | Weapon examples / power-up overlap | Also appears as power-up           |
| Baguette Maul         | Two-handed             | Weapon examples                    | Heavy pastry weapon                |
| Cake Cutter Dagger    | Main-hand              | Additional weapon                  | Fast dagger                        |
| Frost Edge Knife      | Main-hand              | Additional weapon                  | Frosting/ice-flavored knife        |
| Jam Jar Grenade       | Off-hand               | Additional weapon                  | Throwable AoE                      |
| Butter Spray Can      | Off-hand               | Additional weapon                  | Spray/debuff tool                  |
| Bakery Mixer Staff    | Two-handed             | Additional weapon                  | Staff with mixer motif             |
| Layer Cake Greatsword | Two-handed             | Additional weapon                  | Heavy blade                        |
| Bread Slicer          | Temporary level weapon | Level-specific weapon              | Temporary weapon for Pastry Palace |
| Whipped Cream Cannon  | Level reward weapon    | Reward weapon                      | Reward weapon after level          |

### Visual References Assigned

- First image batch: croissant/donut machine platform level.
- Second image batch: croissant-shirt character likely Croissant Crook variant.

### Open / TBD

- Confirm final boss silhouette for Cameron.
- Separate Whipped Cream Shield as either weapon, power-up, or both with distinct rules.
- Define evidence item.

---

## 5.3 Sticky Syrup Swamp

### Identity

| Field             | Value                                                       |
| ----------------- | ----------------------------------------------------------- |
| Level             | Sticky Syrup Swamp                                          |
| Culprit Title     | Syrup Scoundrel                                             |
| Canonical Culprit | Skyler “Syrup Scoundrel” Sugars                             |
| Legacy Culprit    | Simon “Syrup Scoundrel” Sugars                              |
| Crime             | Dumps syrup all over the buffet, ruining food               |
| Palette           | Amber, honey gold, pancake tan, swamp green, syrup brown    |
| Core Feel         | Sticky, slow, vertical syrup traversal, pancake rafts, bees |

### Level Elements

- Slippery syrup-coated platforms.
- Sticky syrup-coated platforms.
- Syrup waterfalls.
- Floating pancake rafts.
- Syrup lakes.
- Pancake stacks.
- Syrup barrels.
- Honey/syrup-coated rock platforms.
- Ladders and syrup bridges from visual references.
- Water body / swamp layer from visual references.
- Butter pats on pancakes.
- Dripping syrup edges.

### Background / Environmental Storytelling

- Syrup swamp landscape.
- Pancake islands.
- Bees protecting syrup sources.
- Rainbow syrup bottle labels as inclusive environmental detail.

### Hazards

- Sticky syrup floors.
- Slippery syrup platforms.
- Syrup pools placed by boss.
- Syrup waterfalls as movement obstacles.
- Bees.
- Syrup golems emerging from sticky floor.
- Flying butter pats.
- Falling / dripping syrup streams.

### Mechanics

- Sticky slowdown.
- Slippery surface handling.
- Vertical traversal around syrup waterfalls.
- Slow pancake raft timing.
- Syrup pool avoidance during boss fight.
- Butter Boots prevent slipping.
- Honey Comb distracts bees.

### Enemies

| Enemy                | Current Behavior                                | Status                                 |
| -------------------- | ----------------------------------------------- | -------------------------------------- |
| Angry Bees           | Buzz in circular pattern and attack when nearby | Canonical                              |
| Syrup Golems         | Rise from sticky floor and charge at player     | Canonical                              |
| Flying Butter Pats   | Fly across screen and damage on contact         | Canonical                              |
| Bee variants         | Seen in visual references                       | Variant                                |
| Syrup barrel enemies | Seen in visual references                       | Variant / possible environmental enemy |

### Boss Fight

| Field           | Current Design                                      |
| --------------- | --------------------------------------------------- |
| Boss            | Skyler “Syrup Scoundrel” Sugars                     |
| Main weapon     | Syrup cannon                                        |
| Main attack     | Covers parts of the arena with syrup                |
| Counterplay     | Avoid syrup pools and attack during reload          |
| Visual variants | Two syrup-gun boss sprites supplied in conversation |

### Power-Ups

- Butter Boots: prevent slipping on syrupy platforms.
- Honey Comb: attracts bees and distracts them from attacking.
- Syrup Boots: related global power-up reference; prevents slipping on hazards.

### Evidence

- **TBD Evidence**: no explicit evidence item is currently specified in the source design.

### Weapons Connected To Level

| Weapon             | Type                   | Source Category                          | Notes                            |
| ------------------ | ---------------------- | ---------------------------------------- | -------------------------------- |
| Butter Knife       | Main-hand              | Weapon examples / level-specific overlap | Also appears as temporary weapon |
| Sticky Net         | Off-hand               | Weapon examples                          | Immobilization utility           |
| Syrup Cannon       | Two-handed             | Weapon examples                          | Heavy syrup projectile           |
| Honey Comb Blade   | Main-hand              | Additional weapon                        | Bee/honey blade                  |
| Maple Saber        | Main-hand              | Additional weapon                        | Syrup sword                      |
| Sugar Cube Bomb    | Off-hand               | Additional weapon                        | Throwable explosive              |
| Sticky Syrup Globe | Off-hand               | Additional weapon                        | Sticky AoE                       |
| Molasses Mallet    | Two-handed             | Additional weapon                        | Heavy slow weapon                |
| Caramel Whip       | Two-handed             | Additional weapon                        | Reach weapon                     |
| Butter Knife       | Temporary level weapon | Level-specific weapon                    | Temporary weapon for this level  |
| Syrup Launcher     | Level reward weapon    | Reward weapon                            | Reward weapon after level        |

### Visual References Assigned

- Second image batch: Sticky Syrup Swamp level overview with bees, pancake stacks, syrup waterfalls, barrels.
- Second image batch: two syrup-gun boss variants.

### Open / TBD

- Pick final boss variant or classify one as mini-boss / alternate.
- Define evidence item.
- Resolve Butter Knife appearing as both main-hand weapon and temporary level weapon.

---

## 5.4 Kitchen Mayhem

### Identity

| Field             | Value                                                                         |
| ----------------- | ----------------------------------------------------------------------------- |
| Level             | Kitchen Mayhem                                                                |
| Culprit Title     | Cutlery Thief                                                                 |
| Canonical Culprit | Casey “Cutlery Thief” Canes                                                   |
| Legacy Culprit    | Carl “Cutlery Carl” Canes / Carl “Cutlery Thief” Canes                        |
| Crime             | Steals forks, spoons, and knives                                              |
| Palette           | Stainless steel, tile whites, stove orange, cutting-board brown, utensil gray |
| Core Feel         | Chaotic back-kitchen obstacle course with sharp objects and hot hazards       |

### Level Elements

- Chaotic back kitchen.
- Falling knives.
- Boiling pots.
- Flying rolling pins.
- Cutting board platforms.
- Countertop platforms.
- Hanging pans.
- Stoves.
- Fire jets.
- Wooden crates.
- Stairs.
- Tiled kitchen walls.
- Giant utensils.
- Pots over flame.
- Steam / boiling bubbles.
- Hanging kitchen tools: spatulas, forks, ladles, pans, whisks.
- Dish piles used in boss fight.

### Background / Environmental Storytelling

- White tiled kitchen wall.
- Hanging utensils and pans.
- Active stoves, pots, counters, crates.
- Pride details can appear as stickers on kitchen prep boards, staff pins, or “All Are Welcome” kitchen signage.

### Hazards

- Falling knives.
- Boiling pots.
- Hot stoves.
- Flying rolling pins.
- Spinning ladles.
- Knife projectiles.
- Fire jets.
- Steam bursts.
- Dish piles / destructible cover.

### Mechanics

- Projectile avoidance.
- Reflecting or blocking knives.
- Breaking dish piles to expose boss.
- Boiling pot timing.
- Falling utensil timing.
- Kitchen trigger hazards possibly activated by enemies.
- Shield of Cutlery reflects flying knives and projectiles.

### Enemies

| Enemy                           | Current Behavior                    | Status                                      |
| ------------------------------- | ----------------------------------- | ------------------------------------------- |
| Knife-throwing Chefs            | Throw knives at the player in arcs  | Canonical                                   |
| Dishwashing Sponges             | Leap / jump toward player           | Canonical                                   |
| Spinning Ladles                 | Spin in place as hazards            | Canonical                                   |
| Angry chefs                     | Mentioned in general kitchen levels | Variant / broader category                  |
| Rolling pins                    | Mentioned as enemies/hazards        | Variant / hazard                            |
| Knife-throwing sous chefs       | Mentioned in general kitchen levels | Variant / duplicate of Knife-throwing Chefs |
| Additional chef/cutlery sprites | Supplied in visual references       | Variant / boss/enemy candidates             |

### Boss Fight

| Field                   | Current Design                                                                                 |
| ----------------------- | ---------------------------------------------------------------------------------------------- |
| Boss                    | Casey “Cutlery Thief” Canes                                                                    |
| Main attacks            | Throws stolen cutlery at player                                                                |
| Defensive behavior      | Hides behind piles of dishes                                                                   |
| Counterplay             | Break dishes to expose boss, attack while dodging flying cutlery                               |
| Possible implementation | Boss class separate from regular enemies; uses ranged projectile attack and destructible cover |

### Power-Ups

- Dish Soap Speed Boost: temporarily increases movement speed.
- Shield of Cutlery: reflects flying knives and projectiles.

### Evidence

- Cutlery.

### Weapons Connected To Level

| Weapon             | Type                   | Source Category       | Notes                             |
| ------------------ | ---------------------- | --------------------- | --------------------------------- |
| Chef’s Cleaver     | Main-hand              | Weapon examples       | Kitchen blade                     |
| Hot Lid            | Off-hand               | Weapon examples       | Defensive/parry shield            |
| Rolling Pin Roller | Two-handed             | Weapon examples       | Heavy rolling weapon              |
| Paring Knife       | Main-hand              | Additional weapon     | Fast knife                        |
| Chef’s Skewer      | Main-hand              | Additional weapon     | Piercing weapon                   |
| Pepper Grinder     | Off-hand               | Additional weapon     | Debuff / projectile candidate     |
| Hot Sauce Flask    | Off-hand               | Additional weapon     | Fire / damage-over-time candidate |
| Stock Pot Shield   | Two-handed             | Additional weapon     | Heavy shield                      |
| Chopping Board Axe | Two-handed             | Additional weapon     | Heavy cleaver/axe                 |
| Dishwasher Sprayer | Temporary level weapon | Level-specific weapon | Temporary level weapon            |
| Rolling Pin        | Level reward weapon    | Reward weapon         | Reward weapon after level         |

### Visual References Assigned

- Second image batch: Kitchen Mayhem level overview.
- Second image batch: three chef/cutlery character variants.

### Open / TBD

- Pick final Casey boss silhouette.
- Standardize title: current docs use both “Cutlery Thief” and “Cutlery Carl.” Recommended active title: **Cutlery Thief**.
- Decide which chef sprites become regular enemy types.

---

## 5.5 Candy Chaos

### Identity

| Field             | Value                                                                  |
| ----------------- | ---------------------------------------------------------------------- |
| Level             | Candy Chaos                                                            |
| Culprit Title     | Dessert Hoarder                                                        |
| Canonical Culprit | Drew “Dessert Hoarder” Sweet                                           |
| Legacy Culprit    | Debbie “Dessert Hoarder” Sweet                                         |
| Crime             | Hoards all the desserts at the buffet                                  |
| Palette           | Candy red, mint, pink, chocolate brown, frosting white, gumdrop colors |
| Core Feel         | High-bounce candy playground with chocolate lava and explosive sweets  |

### Level Elements

- Candy cane bridges.
- Chocolate lava rivers.
- Gumdrop trampolines.
- Rolling peppermint wheels.
- Cupcake platforms.
- Peppermint signs/wheels.
- Candy seats/chairs.
- Giant cupcake boss-object.
- Candy projectiles.
- Candy cane pillars.
- Frosting-coated platforms.
- Wooden/candy scaffold structures from visual references.

### Background / Environmental Storytelling

- Dessert bar fantasy enlarged into a platformer world.
- Giant cupcakes, peppermint signs, gumdrops.
- Pride cupcake as level-specific inclusive detail.

### Hazards

- Chocolate lava rivers.
- Rolling peppermint wheels.
- Explosive candy.
- Cupcake bombs exploding into frosting.
- Gummy bear charges.
- Jellybean sniper projectiles.

### Mechanics

- Gumdrop trampoline bounce traversal.
- Rolling hazard timing.
- Chocolate lava avoidance.
- Switch activation to trigger sprinklers.
- Sprinklers wash away boss cake.
- Sugar Rush doubles attack speed.
- Frosting Barrier shields candy projectiles.

### Enemies

| Enemy                       | Current Behavior                           | Status                           |
| --------------------------- | ------------------------------------------ | -------------------------------- |
| Gummy Bear Brutes           | Charge at player in straight lines         | Canonical                        |
| Cupcake Bombs               | Chase and explode into frosting on contact | Canonical                        |
| Jellybean Snipers           | Fire candy projectiles at player           | Canonical                        |
| Cupcake-themed character    | Supplied in visual references              | Variant / possible boss or enemy |
| Candy boss/hoarder variants | Supplied in visual references              | Variant                          |

### Boss Fight

| Field       | Current Design                                                                   |
| ----------- | -------------------------------------------------------------------------------- |
| Boss        | Drew “Dessert Hoarder” Sweet                                                     |
| Vehicle     | Giant rolling cake                                                               |
| Main attack | Throws explosive candy                                                           |
| Counterplay | Jump on switches to activate sprinklers that wash cake away; knock boss off cake |

### Power-Ups

- Frosting Barrier: shields player from candy projectiles.
- Sugar Rush: temporarily doubles attack speed.
- Rainbow Boosts may be placed in this level as inclusion-themed pickups.

### Evidence

- **TBD Evidence**: no explicit evidence item is currently specified in the source design.

### Weapons Connected To Level

| Weapon               | Type                   | Source Category       | Notes                     |
| -------------------- | ---------------------- | --------------------- | ------------------------- |
| Lollipop Blade       | Main-hand              | Weapon examples       | Candy blade               |
| Sugar Shield         | Off-hand               | Weapon examples       | Defensive sugar shield    |
| Candy Floss Launcher | Two-handed             | Weapon examples       | Ranged candy-floss weapon |
| Gum Blade            | Main-hand              | Additional weapon     | Sticky blade candidate    |
| Candy Cane Dagger    | Main-hand              | Additional weapon     | Small candy blade         |
| Chocolate Bomb       | Off-hand               | Additional weapon     | AoE explosive             |
| Sugar Rush Injector  | Off-hand               | Additional weapon     | Buff item                 |
| Marshmallow Launcher | Two-handed             | Additional weapon     | Ranged launcher           |
| Candy Floss Hammer   | Two-handed             | Additional weapon     | Heavy weapon              |
| Lollipop Hammer      | Temporary level weapon | Level-specific weapon | Temporary level weapon    |
| Gummy Bear Grenade   | Level reward weapon    | Reward weapon         | Reward weapon after level |

### Visual References Assigned

- First image batch: Candy Chaos level overview with peppermint wheels and giant cupcake.
- First image batch: cupcake/dessert character sprite.
- First image batch: candy-colored boss/culprit sprite.

### Open / TBD

- Define evidence item.
- Decide whether cupcake sprite is Drew, a mini-boss, or an enemy class.

---

## 5.6 Egg Factory Frenzy

### Identity

| Field             | Value                                                                            |
| ----------------- | -------------------------------------------------------------------------------- |
| Level             | Egg Factory Frenzy                                                               |
| Culprit Title     | Omelet Overlord                                                                  |
| Canonical Culprit | Morgan “Omelet Overlord” Eggman                                                  |
| Legacy Culprit    | Oliver “Omelet Overlord” Eggman                                                  |
| Crime             | Takes all the eggs to make a giant omelet                                        |
| Palette           | Eggshell white, yolk yellow, factory gray, hazard-stripe black/yellow, pan black |
| Core Feel         | Industrial egg conveyor chaos with yolk traps and chicken enemies                |

### Level Elements

- Conveyor belts transporting giant eggs.
- Platforms shaped like frying pans.
- Egg carton platforms.
- Cracking egg hazards.
- Yolk traps.
- Industrial factory walls.
- Chicken/egg conveyor systems.
- Warning-stripe platforms.
- Egg machines.
- Frying pan hazards.
- Factory signage.
- Egg rows and cracked-shell enemies from visual references.

### Background / Environmental Storytelling

- Egg factory machinery.
- Conveyor belts.
- Warning signs.
- Egg packing/processing stations.
- Pride details can appear on worker badges, small posters, or packaging labels.

### Hazards

- Conveyor belts.
- Cracking eggs spilling yolk traps.
- Yolk trap slowdown/damage.
- Frying pans slamming down.
- Eggshell drones dropping yolk bombs.
- Moving machinery.

### Mechanics

- Conveyor movement.
- Timed egg cracking.
- Yolk trap avoidance.
- Slam-timing from frying pans.
- Boss uses spatula to flip player off platforms.
- Egg Launcher cracks boss defenses.
- Egg Timer slows enemies temporarily.

### Enemies

| Enemy                 | Current Behavior                     | Status                 |
| --------------------- | ------------------------------------ | ---------------------- |
| Angry Chickens        | Chase player and peck                | Canonical              |
| Eggshell Drones       | Fly above player and drop yolk bombs | Canonical              |
| Frying Pans           | Slam down on platforms               | Canonical hazard/enemy |
| Chicken/egg variants  | Supplied in visual references        | Variant                |
| Cracked egg creatures | Supplied in visual references        | Variant                |

### Boss Fight

| Field       | Current Design                                           |
| ----------- | -------------------------------------------------------- |
| Boss        | Morgan “Omelet Overlord” Eggman                          |
| Main weapon | Spatula                                                  |
| Main attack | Flips player off platforms                               |
| Counterplay | Use Egg Launcher to crack defenses, avoid platform flips |

### Power-Ups

- Omelet Shield: absorbs one hit.
- Egg Timer: slows enemies temporarily.

### Evidence

- **TBD Evidence**: no explicit evidence item is currently specified in the source design.

### Weapons Connected To Level

| Weapon              | Type                   | Source Category              | Notes                          |
| ------------------- | ---------------------- | ---------------------------- | ------------------------------ |
| Egg Beater          | Main-hand              | Weapon examples              | Egg-themed melee / tool        |
| Yolk Bomb           | Off-hand               | Weapon examples              | Throwable yolk item            |
| Frying Pan          | Two-handed             | Weapon examples              | Heavy pan weapon               |
| Eggshell Knife      | Main-hand              | Additional weapon            | Small blade                    |
| Egg Scrambler Blade | Main-hand              | Additional weapon            | Scrambler sword                |
| Salt Shaker         | Off-hand               | Additional weapon            | Debuff / status item candidate |
| Egg Yolk Grenade    | Off-hand               | Additional weapon            | AoE sticky explosive           |
| Omelet Spatula      | Two-handed             | Additional weapon            | Boss/themed weapon             |
| Egg Beater Staff    | Two-handed             | Additional weapon            | Staff weapon                   |
| Egg Whisk           | Temporary level weapon | Level-specific weapon        | Temporary level weapon         |
| Egg Launcher        | Level reward weapon    | Reward weapon / boss counter | Cracks boss defenses           |

### Visual References Assigned

- First image batch: Egg Factory Frenzy level overview with conveyors, chickens, eggs, yolk traps.
- First image batch: frying-pan/egg-apron boss sprite.

### Open / TBD

- Define evidence item.
- Decide whether frying pan is enemy, hazard, weapon, or all three with separate rules.

---

## 5.7 Citrus Cascade

### Identity

| Field             | Value                                                                |
| ----------------- | -------------------------------------------------------------------- |
| Level             | Citrus Cascade                                                       |
| Culprit Title     | Juice Jacker                                                         |
| Canonical Culprit | Jordan “Juice Jacker” Squeeze                                        |
| Legacy Culprit    | Julie “Juice Jacker” Squeeze                                         |
| Crime             | Steals all the orange juice in bottles                               |
| Palette           | Orange, yellow, lime green, juice gold, metal juicer gray, sky aqua  |
| Core Feel         | Bright citrus processing parkour with juice waterfalls and launchers |

### Level Elements

- Platforms made of citrus wedges.
- Orange slice platforms.
- Streams of orange juice as slippery hazards.
- Soda fountains spraying juice as launchers.
- Juice launchers.
- Orange juice waterfalls.
- Juicers.
- Juice machines.
- Citrus trees and greenery.
- Orange/lime/lemon decorations.
- Juice bottles and glasses.
- Conveyor/pipe-like citrus structures from visual references.

### Background / Environmental Storytelling

- Giant citrus slices.
- Industrial juicers.
- Citrus groves.
- Juice fountains.
- Pride-colored citrus decorations as inclusive environmental detail.

### Hazards

- Slippery orange juice streams.
- Juice pushback jets.
- Squeezing machines spitting juice jets.
- Lemon bats swooping at player.
- Orange peel traps rolling across ground.
- Juice waterfalls.

### Mechanics

- Slippery juice movement.
- Juice launchers for vertical/horizontal movement.
- Rolling orange peel traps.
- Boss reload vulnerability.
- Juice streams as pushback/projectile hazards.
- Vitamin Boost heals.
- Citrus Blast fires orange grenade that explodes into sticky pulp.

### Enemies

| Enemy                 | Current Behavior                 | Status                         |
| --------------------- | -------------------------------- | ------------------------------ |
| Squeezing Machines    | Shoot/spit juice jets at player  | Canonical                      |
| Lemon Bats            | Zigzag and swoop down to attack  | Canonical                      |
| Orange Peel Traps     | Roll across platforms as hazards | Canonical                      |
| Citrus bat variants   | Supplied in visual references    | Variant                        |
| Juice machine hazards | Supplied in visual references    | Variant / environmental hazard |

### Boss Fight

| Field       | Current Design                                   |
| ----------- | ------------------------------------------------ |
| Boss        | Jordan “Juice Jacker” Squeeze                    |
| Main weapon | Juicer gun                                       |
| Main attack | Sprays juice streams                             |
| Counterplay | Dodge streams, attack when boss pauses to reload |

### Power-Ups

- Vitamin Boost: heals small amount of health.
- Citrus Blast: fires an orange grenade that explodes into sticky pulp.

### Evidence

- **TBD Evidence**: no explicit evidence item is currently specified in the source design.

### Weapons Connected To Level

| Weapon         | Type                   | Source Category                  | Notes                         |
| -------------- | ---------------------- | -------------------------------- | ----------------------------- |
| Orange Zester  | Main-hand              | Weapon examples                  | Citrus blade/tool             |
| Juice Squeezer | Off-hand               | Weapon examples                  | Utility/shield or debuff item |
| Citrus Blaster | Two-handed             | Weapon examples / reward overlap | Also level reward weapon      |
| Citrus Saber   | Main-hand              | Additional weapon                | Citrus sword                  |
| Peeler Knife   | Main-hand              | Additional weapon                | Small blade                   |
| Zest Grenade   | Off-hand               | Additional weapon                | AoE citrus explosive          |
| Lime Shield    | Off-hand               | Additional weapon                | Defensive citrus shield       |
| Juicer Staff   | Two-handed             | Additional weapon                | Staff weapon                  |
| Orange Flail   | Two-handed             | Additional weapon                | Heavy flail                   |
| Zester Shooter | Temporary level weapon | Level-specific weapon            | Temporary level weapon        |
| Citrus Blaster | Level reward weapon    | Reward weapon                    | Reward weapon after level     |

### Visual References Assigned

- First image batch: Citrus Cascade level overview with orange slices, juice jets, juicers, flying citrus enemies.
- First image batch: orange/yellow citrus boss/character sprite.

### Open / TBD

- Define evidence item.
- Resolve Citrus Blaster as both two-handed weapon and reward weapon.

---

## 5.8 Bakery Bonanza

### Identity

| Field             | Value                                                                                       |
| ----------------- | ------------------------------------------------------------------------------------------- |
| Level             | Bakery Bonanza                                                                              |
| Culprit Title     | Muffin Mastermind                                                                           |
| Canonical Culprit | Quinn “Muffin Mastermind” Munch                                                             |
| Legacy Culprit    | Marty “Muffin Mastermind” Munch                                                             |
| Crime             | Hides muffins in their hat to smuggle them out                                              |
| Palette           | Oven orange, flour white, dough tan, baking-tray gray, warm bread brown                     |
| Core Feel         | Industrial bakery platforming with ovens, conveyors, rising dough, flour visibility hazards |

### Level Elements

- Giant ovens.
- Conveyor belts.
- Rising dough platforms.
- Dough platforms that expand and collapse.
- Flour clouds that obscure visibility.
- Muffin conveyor / bakery machinery.
- Oven towers.
- Metal stairs.
- Industrial bakery structures.
- Flour puffs / cloud hazards.
- Muffin platforms/enemies.
- Giant bread loaves.
- Bakery pipes and factory supports.

### Background / Environmental Storytelling

- Huge ovens with glowing interiors.
- Bakery factory platforms and conveyor belts.
- Flour clouds floating in background and foreground.
- Pride/inclusive detail can appear on bakery packaging, staff uniforms, or “All Are Welcome” signage near ovens.

### Hazards

- Hot ovens.
- Conveyor belts.
- Expanding/collapsing dough platforms.
- Flour clouds obscuring visibility.
- Rolling muffin trays.
- Burning muffins.
- Explosive muffins thrown by boss.
- Baking trays used as boss cover.

### Mechanics

- Conveyor belt traversal.
- Expanding / collapsing dough timing.
- Visibility obstruction from flour clouds.
- Hot hazard avoidance.
- Boss hides behind baking trays.
- Clearing baking trays exposes boss.
- Oven Mitts protect against hot hazards.

### Enemies

| Enemy                       | Current Behavior                        | Status                         |
| --------------------------- | --------------------------------------- | ------------------------------ |
| Flour Bag Monsters          | Puff flour clouds that obscure vision   | Canonical                      |
| Rolling Muffin Trays        | Roll across platforms as moving hazards | Canonical                      |
| Burning Muffins             | Charge at player and deal fire damage   | Canonical                      |
| Muffin enemies              | Seen in visual references               | Variant                        |
| Oven/muffin machine hazards | Seen in visual references               | Variant / environmental hazard |

### Boss Fight

| Field              | Current Design                        |
| ------------------ | ------------------------------------- |
| Boss               | Quinn “Muffin Mastermind” Munch       |
| Main attack        | Throws explosive muffins              |
| Defensive behavior | Hides behind piles of baking trays    |
| Counterplay        | Clear trays to expose boss and attack |

### Power-Ups

- Oven Mitts: protect against hot hazards.
- Muffin Shield: blocks one projectile.

### Evidence

- **TBD Evidence**: no explicit evidence item is currently specified in the source design.

### Weapons Connected To Level

| Weapon             | Type                   | Source Category       | Notes                              |
| ------------------ | ---------------------- | --------------------- | ---------------------------------- |
| Dough Cutter       | Main-hand              | Weapon examples       | Also duplicated in additional list |
| Flour Puff         | Off-hand               | Weapon examples       | Also duplicated in additional list |
| Bread Roller       | Two-handed             | Weapon examples       | Also duplicated in additional list |
| Rolling Pin Blade  | Main-hand              | Additional weapon     | Blade variant                      |
| Dough Hook         | Main-hand              | Additional weapon     | Hook weapon                        |
| Flour Cloud Bomb   | Off-hand               | Additional weapon     | Visibility/status bomb             |
| Dough Ball Trap    | Off-hand               | Additional weapon     | Trap item                          |
| Oven Door Shield   | Two-handed             | Additional weapon     | Heavy shield                       |
| Dough Roller Staff | Two-handed             | Additional weapon     | Staff variant                      |
| Dough Roller       | Temporary level weapon | Level-specific weapon | Temporary level weapon             |
| Flour Blaster      | Level reward weapon    | Reward weapon         | Reward weapon after level          |

### Visual References Assigned

- Second image batch: Bakery Bonanza level overview with ovens, muffins, flour clouds, conveyor/stair layout.
- Second image batch: muffin/croissant-holding baker sprite likely boss or variant.

### Open / TBD

- Define evidence item.
- Resolve Dough Cutter / Flour Puff / Bread Roller duplication in weapon docs.
- Confirm Quinn’s final visual design.

---

# 6. Global Weapon Inventory

## 6.1 Weapon System Concepts

- Weapon attributes:
  - Fire rate.
  - Damage.
  - Ammo capacity.
  - Cooldown.
  - Projectile scene.
- Weapon types:
  - Melee.
  - Ranged.
  - Area-of-effect.
  - Main-hand.
  - Off-hand.
  - Two-handed.
  - Temporary level weapon.
  - Level reward weapon.
- Swappable weapon functionality.
- Projectile spawning through weapon firing.
- Damage can be source-based through `damage_source` dictionaries.
- Status effects may include immobilized, slowed, blinded, stunned, frozen, wrapped, knocked back, pushed, debuffed.

## 6.2 Weapon Effect Categories

| Enemy Class       | Intended Weapon Effect                                               |
| ----------------- | -------------------------------------------------------------------- |
| Small enemy       | Killed by strong/special hit                                         |
| Medium enemy      | Takes damage and may be wrapped/immobilized; killed on critical      |
| Large enemy / mob | Takes damage, partial state effect possible                          |
| Boss              | Immune or limited damage except during defined vulnerability windows |

## 6.3 All Current Weapons By Level

| Level              | Main-hand        | Off-hand                   | Two-handed           | Additional Main-hand                 | Additional Off-hand                 | Additional Two-handed                     | Temporary Weapon   | Reward Weapon        |
| ------------------ | ---------------- | -------------------------- | -------------------- | ------------------------------------ | ----------------------------------- | ----------------------------------------- | ------------------ | -------------------- |
| Grease Canyon      | Bacon Gun        | Extra Bacon / bacon shield | TBD                  | TBD                                  | TBD                                 | TBD                                       | TBD                | TBD                  |
| Pastry Palace      | Croissant Cutter | Whipped Cream Shield       | Baguette Maul        | Cake Cutter Dagger; Frost Edge Knife | Jam Jar Grenade; Butter Spray Can   | Bakery Mixer Staff; Layer Cake Greatsword | Bread Slicer       | Whipped Cream Cannon |
| Sticky Syrup Swamp | Butter Knife     | Sticky Net                 | Syrup Cannon         | Honey Comb Blade; Maple Saber        | Sugar Cube Bomb; Sticky Syrup Globe | Molasses Mallet; Caramel Whip             | Butter Knife       | Syrup Launcher       |
| Kitchen Mayhem     | Chef’s Cleaver   | Hot Lid                    | Rolling Pin Roller   | Paring Knife; Chef’s Skewer          | Pepper Grinder; Hot Sauce Flask     | Stock Pot Shield; Chopping Board Axe      | Dishwasher Sprayer | Rolling Pin          |
| Candy Chaos        | Lollipop Blade   | Sugar Shield               | Candy Floss Launcher | Gum Blade; Candy Cane Dagger         | Chocolate Bomb; Sugar Rush Injector | Marshmallow Launcher; Candy Floss Hammer  | Lollipop Hammer    | Gummy Bear Grenade   |
| Egg Factory Frenzy | Egg Beater       | Yolk Bomb                  | Frying Pan           | Eggshell Knife; Egg Scrambler Blade  | Salt Shaker; Egg Yolk Grenade       | Omelet Spatula; Egg Beater Staff          | Egg Whisk          | Egg Launcher         |
| Citrus Cascade     | Orange Zester    | Juice Squeezer             | Citrus Blaster       | Citrus Saber; Peeler Knife           | Zest Grenade; Lime Shield           | Juicer Staff; Orange Flail                | Zester Shooter     | Citrus Blaster       |
| Bakery Bonanza     | Dough Cutter     | Flour Puff                 | Bread Roller         | Rolling Pin Blade; Dough Hook        | Flour Cloud Bomb; Dough Ball Trap   | Oven Door Shield; Dough Roller Staff      | Dough Roller       | Flour Blaster        |

## 6.4 Global / Special Weapons and Power-Weapon Items

- Bacon Gun.
- Syrup Shooter.
- Syrup Boots.
- Bacon Grease Slide.
- Extra Bacon shield.

## 6.5 Current Weapon Duplicates / Merge Notes

| Item                                     | Issue                                               | Proposed Handling                                                                   |
| ---------------------------------------- | --------------------------------------------------- | ----------------------------------------------------------------------------------- |
| Whipped Cream Shield                     | Appears as off-hand weapon and power-up             | Keep both for now; define one as equipment and one as temporary shield pickup later |
| Butter Knife                             | Appears as main-hand and temporary level weapon     | Mark as `Needs merge`                                                               |
| Citrus Blaster                           | Appears as two-handed and reward weapon             | Mark as `Needs merge`                                                               |
| Dough Cutter / Flour Puff / Bread Roller | Repeated in Bakery list                             | Mark first listing canonical, later duplicates as confirmations                     |
| Rolling Pin / Rolling Pin Roller         | Similar names, different categories                 | Keep both until weapon taxonomy is finalized                                        |
| Bacon Gun                                | Global weapon, level-signature weapon, boss counter | Needs final progression placement                                                   |

---

# 7. Global Power-Up Inventory

| Power-Up              | Level / Context        | Current Effect                                            |
| --------------------- | ---------------------- | --------------------------------------------------------- |
| Grease Slide          | Grease Canyon          | Dash to avoid tornado; may leave slowing trail            |
| Bacon Grease Slide    | Global / Grease Canyon | Dash move that leaves slowing trail                       |
| Extra Bacon           | Grease Canyon          | Absorbs one hit / temporary bacon shield                  |
| Golden Bacon Shield   | Grease Canyon visual   | Hovering golden bacon shield                              |
| Syrup Trail           | Pastry Palace          | Creates sticky path to slow enemies                       |
| Whipped Cream Shield  | Pastry Palace          | Absorbs one hit                                           |
| Butter Boots          | Sticky Syrup Swamp     | Prevents slipping on syrupy platforms                     |
| Honey Comb            | Sticky Syrup Swamp     | Attracts bees and distracts them                          |
| Dish Soap Speed Boost | Kitchen Mayhem         | Temporarily increases movement speed                      |
| Shield of Cutlery     | Kitchen Mayhem         | Reflects flying knives/projectiles                        |
| Frosting Barrier      | Candy Chaos            | Shields from candy projectiles                            |
| Sugar Rush            | Candy Chaos            | Temporarily doubles attack speed                          |
| Omelet Shield         | Egg Factory Frenzy     | Absorbs one hit                                           |
| Egg Timer             | Egg Factory Frenzy     | Slows enemies temporarily                                 |
| Vitamin Boost         | Citrus Cascade         | Heals a small amount of health                            |
| Citrus Blast          | Citrus Cascade         | Fires orange grenade that explodes into sticky pulp       |
| Oven Mitts            | Bakery Bonanza         | Protects against hot hazards                              |
| Muffin Shield         | Bakery Bonanza         | Blocks one projectile                                     |
| Syrup Boots           | Global / platforming   | Prevents slipping on hazards                              |
| Rainbow Boost         | Inclusion system       | Inclusive/celebratory power-up; exact gameplay effect TBD |

---

# 8. Evidence Inventory

| Level              | Current Evidence | Status                                        |
| ------------------ | ---------------- | --------------------------------------------- |
| Grease Canyon      | Bacon Strips     | Canonical                                     |
| Pastry Palace      | TBD Evidence     | Missing in current docs; preserve placeholder |
| Sticky Syrup Swamp | TBD Evidence     | Missing in current docs; preserve placeholder |
| Kitchen Mayhem     | Cutlery          | Canonical                                     |
| Candy Chaos        | TBD Evidence     | Missing in current docs; preserve placeholder |
| Egg Factory Frenzy | TBD Evidence     | Missing in current docs; preserve placeholder |
| Citrus Cascade     | TBD Evidence     | Missing in current docs; preserve placeholder |
| Bakery Bonanza     | TBD Evidence     | Missing in current docs; preserve placeholder |

Global evidence examples from core docs:
- Bacon strips.
- Cutlery.
- Receipts.
- Dynamic plate objects such as stacked bacon or hidden croissant in a bag.

---

# 9. Enemy Architecture Inventory

## 9.1 Base Enemy Class Direction

All regular enemies can inherit from a reusable `BaseEnemy` with:

- Health.
- Speed.
- Damage.
- Death state.
- `_process` default idle behavior.
- `_physics_process` default physics behavior.
- `take_damage(amount)`.
- `attack()`.
- `check_is_dead()`.

Bosses should be separated into their own classes because they involve unique phases and arena mechanics.

## 9.2 Core AI Movement Behaviors

Reusable AI behavior classes / concepts:

- Patrolling AI: moves between set points on a platform.
- Chasing AI: follows player within a defined detection range.
- Flying AI: handles airborne enemies and unique flight patterns.
- Pathfinding AI: A* or Dijkstra for complex levels.
- Idle state.
- Patrolling state.
- Chasing state.
- Attacking state.
- Retreating state.
- Detection range.
- Attack range.
- Attack cooldown.
- Patrol range.
- Patrol points.
- Movement speed.
- Retreat threshold.

## 9.3 Extended Enemy States

| State      | Current Meaning                | Current Use Candidate                            |
| ---------- | ------------------------------ | ------------------------------------------------ |
| Idle       | Stationary/simple animations   | All enemies                                      |
| Patrolling | Moves along path/platform      | Pigs, chefs, rolling enemies                     |
| Chasing    | Follows player in range        | Chickens, donuts, golems, muffins                |
| Attacking  | Performs melee/ranged attack   | All combat enemies                               |
| Retreating | Moves away / safe position     | Low-health enemies                               |
| Stunned    | Temporarily disabled           | Bacon Bandit hit by grease trail; weapon effects |
| Summoning  | Spawns minions/traps           | Croissant Crook spawning rolling croissants      |
| Fleeing    | Runs away when health drops    | Culprits and special enemies                     |
| Frozen     | Immobilized but vulnerable     | Future ice/frost weapon effects                  |
| Invincible | Ignores damage during i-frames | Health component / visual feedback               |
| Wrapped    | Immobilized by Bacon Gun       | Bacon Gun effect                                 |
| Slowed     | Movement speed reduced         | Syrup / grease / sticky weapons                  |
| Blinded    | Vision/aim impaired            | Dishwasher Sprayer or Flour Cloud effects        |

## 9.4 Environment-Aware Enemy Interaction Types

| Interaction Type    | Current Description                       | Brunch Police Example                                |
| ------------------- | ----------------------------------------- | ---------------------------------------------------- |
| Hazard-aware        | Enemies avoid or take damage from hazards | Bacon worms can die in boiling grease pits           |
| Platform-aware      | Enemies follow platforms or avoid edges   | Platform-bound éclairs avoid falling                 |
| Destructible-aware  | Enemies break crates/barrels/objects      | Bees destroy player barricades                       |
| Trigger-aware       | Enemies activate switches/traps           | Kitchen enemies activate conveyors or moving hazards |
| Dynamic pathfinding | Enemies navigate around obstacles         | Complex factory/kitchen layouts                      |

## 9.5 Enemy Spawning

EnemySpawner concept:

- Uses predefined spawn points.
- Can dynamically spawn enemies during gameplay.
- Stores enemy scene reference.
- Adds spawn points.
- Spawns a requested enemy count up to available spawn points.

Use cases:

- Boss summoning phases.
- Enemy waves.
- Respawning hazards.
- Arena escalation.

---

# 10. Full Enemy Behavior Index

| Level              | Enemy                | Behavior                                        |
| ------------------ | -------------------- | ----------------------------------------------- |
| Grease Canyon      | Small Angry Pigs     | Patrol / charge; knock player off platforms     |
| Grease Canyon      | Bacon Worms          | Move up and down sausage ropes                  |
| Grease Canyon      | Flying Sausage Links | Hover and swoop down at player                  |
| Pastry Palace      | Flying Éclairs       | Hover and shoot whipped cream projectiles       |
| Pastry Palace      | Rolling Baguette     | Rolls along platforms, damages on contact       |
| Pastry Palace      | Jelly-filled Donuts  | Chase player and explode on contact             |
| Sticky Syrup Swamp | Angry Bees           | Buzz in circular pattern and attack when nearby |
| Sticky Syrup Swamp | Syrup Golems         | Rise from syrup floor and charge                |
| Sticky Syrup Swamp | Flying Butter Pats   | Fly across screen, damage on contact            |
| Kitchen Mayhem     | Knife-throwing Chefs | Throw knives at player in arcs                  |
| Kitchen Mayhem     | Dishwashing Sponges  | Jump toward player                              |
| Kitchen Mayhem     | Spinning Ladles      | Spin in place as hazard                         |
| Candy Chaos        | Gummy Bear Brutes    | Charge in straight lines                        |
| Candy Chaos        | Cupcake Bombs        | Chase and explode into frosting                 |
| Candy Chaos        | Jellybean Snipers    | Fire candy projectiles                          |
| Egg Factory Frenzy | Angry Chickens       | Chase player and peck                           |
| Egg Factory Frenzy | Eggshell Drones      | Fly above player and drop yolk bombs            |
| Egg Factory Frenzy | Frying Pans          | Slam down on platforms                          |
| Citrus Cascade     | Squeezing Machines   | Shoot juice jets                                |
| Citrus Cascade     | Lemon Bats           | Zigzag flight and swoop attack                  |
| Citrus Cascade     | Orange Peel Traps    | Roll across platforms                           |
| Bakery Bonanza     | Flour Bag Monsters   | Puff flour clouds that obscure visibility       |
| Bakery Bonanza     | Rolling Muffin Trays | Roll across platforms                           |
| Bakery Bonanza     | Burning Muffins      | Charge and deal fire damage                     |

---

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

# 12. Interaction System Inventory

Current interaction system supports:

- Inspecting objects.
- Inspecting NPCs.
- Triggering events.
- Opening doors.
- Activating switches.
- Context-sensitive prompts such as “Press E to talk”.
- Starting a boss fight.
- Picking up temporary weapons.
- Activating checkpoints.
- NPC dialogue integration.
- Dialogue + interaction integration.

Implementation direction:

- Interaction Manager uses `Area2D` style interaction zones.
- Interactions can map to named actions/events.
- NPCs can use interaction triggers to start dialogue.
- Reusable modular triggers should be used for boss fights, weapon pickups, and checkpoints.

---

# 13. Dialogue System Inventory

Current dialogue system supports:

- NPC dialogue display.
- Optional typewriter effect.
- Branching dialogue paths.
- Player choices.
- NPC reactions.
- Dialogue-specific events.
- Accusations.
- Triggering NPC fleeing behavior after a correct accusation.
- Humorous responses for incorrect accusations.
- Clue gathering.
- Casual partner mentions as inclusion detail.
- Proposal side quest dialogue.

---

# 14. NPC, Hub, and Investigation Systems

## 14.1 NPC Types / Behavior Concepts

- Picky eaters.
- Hoarders.
- Sneaky thieves.
- Suspicious brunch guests.
- Diverse NPC body types and expressions.
- Same-sex and non-binary couples in crowd scenes.
- NPCs with distinct personalities and routines.

## 14.2 Inspection Mechanics

- Inspect NPCs.
- Inspect objects.
- Inspect plates.
- Close-up plate view.
- Dynamic plate objects:
  - stacked bacon.
  - sneaky croissant in a bag.
  - suspicious missing food.
  - stolen cutlery.
  - receipts.

## 14.3 Accusation Mechanics

- Player accuses based on clues and inspections.
- Correct accusation triggers fleeing sequence.
- Incorrect accusation triggers comedic NPC response.
- Accusation dialogue should connect to dialogue event system.

---

# 15. Visual and Audio Inventory

## 15.1 Visual Style

- Cartoonish, humorous art style.
- Bright, colorful brunch area.
- Detailed food and decor.
- Platformer levels have exaggerated, wacky designs.
- Giant bacon strips as platforms.
- Syrup waterfalls.
- Oversized kitchen utensils.
- Pixel-art character sprites from visual references.
- Painterly / cartoon level concept art from visual references.
- Strong food textures.
- Exaggerated silhouettes.

## 15.2 Audio Direction

- Whimsical, lighthearted soundtrack.
- Relaxing brunch music in hub.
- Fast-paced quirky music for platformer levels.
- Food splat sound effects.
- Sizzling grease sound effects.
- NPC dialogue snippets.
- Weapon-specific food sounds.
- Boss phase stingers.

---

# 16. Development / Project Architecture Inventory

## 16.1 Existing File Structure Direction

Core source folders:

- `src/core/`
  - `Game.cpp`
  - `Player.cpp`
  - `Enemy.cpp`
  - `Boss.cpp`
  - `Weapon.cpp`
  - `Inventory.cpp`
  - `DialogueSystem.cpp`
  - `SaveSystem.cpp`
- `src/utils/`
  - `Timer.cpp`
  - `ResourceManager.cpp`
  - `AudioManager.cpp`
  - `VisualEffects.cpp`
- `src/levels/`
  - `GreaseCanyon.cpp`
  - `PastryPalace.cpp`
  - `StickySyrupSwamp.cpp`
  - `KitchenMayhem.cpp`
  - `CandyChaos.cpp`
  - `EggFactoryFrenzy.cpp`
  - `CitrusCascade.cpp`
  - `BakeryBonanza.cpp`
- `inc/core/`
- `inc/utils/`
- `inc/levels/`
- `obj/`
- `build/`
- `gdnative/`
- `assets/`
- `scenes/`
- `helpers/`
- `shaders/`

## 16.2 Existing Assets Structure Direction

- Player sprites.
- Enemy sprites.
  - `croissant_crook.png`
  - `bacon_bandit.png`
  - `syrup_scoundrel.png`
  - etc.
- Audio/music.
- Audio/SFX.
- Backgrounds:
  - `grease_canyon_bg.png`
  - `pastry_palace_bg.png`
- Level scenes:
  - `grease_canyon.tscn`
  - `pastry_palace.tscn`
  - `sticky_syrup_swamp.tscn`
  - etc.
- Character scenes:
  - `player.tscn`
  - `croissant_crook.tscn`
  - `bacon_bandit.tscn`
- Shaders:
  - `grease_shader.gdshader`
  - `syrup_shader.gdshader`

---

# 17. Additional / Future Level Ideas Already Present

These are not part of the eight-level current roster but must not be lost.

## 17.1 Back Alley / Garbage Bin / Street Theme

- Culprit smuggles food in closed trash containers to retrieve later.
- Trash can parkour.

## 17.2 Street / Alley / Road Levels

- Enemies:
  - Small angry pigs.
  - Traffic obstacles.
  - Food trucks.
- Hazards:
  - Slippery oil spills.
  - Falling food debris.
- Power-ups:
  - Bacon grease slide.
  - Syrup stickiness for temporary wall climbing.

## 17.3 Toilet / Pipes Levels

- Enemies:
  - Germ monsters.
  - Toilet paper snakes.
- Hazards:
  - Overflowing toilets.
  - Gushing water pipes.
- Power-ups:
  - Plunger jump.
  - Sanitizer spray that clears enemies.

## 17.4 General Kitchen Level Ideas

- Enemies:
  - Angry chefs.
  - Rolling pins.
  - Knife-throwing sous chefs.
- Hazards:
  - Hot stoves.
  - Falling pots and pans.
- Power-ups:
  - Shield of Cutlery.
  - Dish Soap Speed Boost.

---

# 18. Visual Reference Assignment Index

## 18.1 First Visual Batch

| Visual                                         | Assigned Level     | Notes                                                      |
| ---------------------------------------------- | ------------------ | ---------------------------------------------------------- |
| Croissant/donut machinery platformer scene     | Pastry Palace      | Croissant stacks, dough mixer, donut/pastry machinery      |
| Cupcake/dessert character sprite               | Candy Chaos        | Possible Drew variant, dessert minion, or cupcake enemy    |
| Candy level scene with peppermints and cupcake | Candy Chaos        | Candy cane bridges, peppermint wheels, cupcake boss object |
| Pink candy boss sprite                         | Candy Chaos        | Possible Drew variant or candy enemy                       |
| Citrus factory level scene                     | Citrus Cascade     | Orange slice platforms, juice jets, juicers, citrus bats   |
| Orange/yellow citrus character sprite          | Citrus Cascade     | Possible Jordan variant                                    |
| Egg factory conveyor scene                     | Egg Factory Frenzy | Eggs, chickens, yolk traps, conveyors                      |
| Pan/egg apron boss sprite                      | Egg Factory Frenzy | Possible Morgan variant                                    |
| Bacon canyon scene with pigs and sausage ropes | Grease Canyon      | Bacon platforms, grease pits, pigs                         |
| Bacon boss arena with pig chefs                | Grease Canyon      | Possible Bailey variant, mini-boss, or boss-arena concept  |

## 18.2 Second Visual Batch

| Visual                                      | Assigned Level     | Notes                                         |
| ------------------------------------------- | ------------------ | --------------------------------------------- |
| Kitchen wall level with pots, knives, chefs | Kitchen Mayhem     | Core level layout reference                   |
| Running chef sprite with chef hat           | Kitchen Mayhem     | Enemy or Casey variant                        |
| Chef with tool/sprayer sprite               | Kitchen Mayhem     | Enemy or Casey variant                        |
| Chef with pan/hook sprite                   | Kitchen Mayhem     | Possible Casey boss variant                   |
| Bakery oven/muffin level scene              | Bakery Bonanza     | Ovens, muffins, flour clouds, conveyors       |
| Muffin/croissant-holding baker sprite       | Bakery Bonanza     | Possible Quinn variant or enemy               |
| Croissant shirt character sprite            | Pastry Palace      | Possible Cameron variant                      |
| Sticky Syrup Swamp level scene              | Sticky Syrup Swamp | Pancakes, syrup waterfalls, bees, barrels     |
| Syrup gun boss sprite 1                     | Sticky Syrup Swamp | Possible Skyler final boss variant            |
| Syrup gun boss sprite 2                     | Sticky Syrup Swamp | Possible Skyler alternate / mini-boss variant |

---

# 19. Current Design Conflicts / Cleanup Queue

| Area                 | Conflict                                                                | Current Treatment                                                      |
| -------------------- | ----------------------------------------------------------------------- | ---------------------------------------------------------------------- |
| Boss names           | Legacy gendered names vs inclusive names                                | Inclusive names are canonical; legacy names kept for reference only    |
| Casey title          | Cutlery Thief vs Cutlery Carl                                           | Canonical title should be Cutlery Thief; Cutlery Carl kept legacy      |
| Evidence             | Several levels have empty evidence sections                             | Preserve as `TBD Evidence`; do not delete                              |
| Weapon taxonomy      | Some weapons appear as power-ups, temporary weapons, and reward weapons | Keep all; mark duplicates as `Needs merge`                             |
| Visual styles        | Character sprites are pixel art; level refs are painterly/cartoon       | Treat as concept references until final art style guide is defined     |
| Boss variants        | Multiple possible boss sprites for Kitchen and Syrup                    | Keep all as variants until selected                                    |
| Grease Canyon reward | Bacon Gun is critical but reward/progression placement unclear          | Mark `Needs progression decision`                                      |
| Enemy vs hazard      | Frying pans, rolling pins, ladles can be enemies or hazards             | Preserve both interpretations until implementation taxonomy is defined |

---

# 20. Recommended Next Reorganization Pass

The next document pass should split this inventory into clean working docs without losing any content:

1. `00-master-index.md`
2. `01-core-game-loop.md`
3. `02-investigation-system.md`
4. `03-dialogue-system.md`
5. `04-interaction-system.md`
6. `05-player-combat-health.md`
7. `06-weapons-index.md`
8. `07-powerups-and-status-effects.md`
9. `08-enemy-taxonomy.md`
10. `09-boss-index.md`
11. `10-levels/grease-canyon.md`
12. `10-levels/pastry-palace.md`
13. `10-levels/sticky-syrup-swamp.md`
14. `10-levels/kitchen-mayhem.md`
15. `10-levels/candy-chaos.md`
16. `10-levels/egg-factory-frenzy.md`
17. `10-levels/citrus-cascade.md`
18. `10-levels/bakery-bonanza.md`
19. `11-inclusion-and-representation.md`
20. `12-visual-style-guide.md`
21. `13-implementation-architecture.md`
22. `14-open-questions-and-cleanup.md`

---

# 21. Canonical Preservation Checklist

Before adding new mechanics, verify the following remain represented:

- [ ] All eight current levels.
- [ ] All canonical inclusive boss names.
- [ ] All legacy names retained only as reference.
- [ ] All crimes.
- [ ] All level elements.
- [ ] All enemies.
- [ ] All hazards.
- [ ] All boss mechanics.
- [ ] All power-ups.
- [ ] All weapons from `weapons.md`.
- [ ] All temporary level weapons.
- [ ] All level reward weapons.
- [ ] Bacon Gun special rules.
- [ ] Evidence items and TBD evidence gaps.
- [ ] Hub investigation loop.
- [ ] Dialogue system.
- [ ] Interaction system.
- [ ] Health component.
- [ ] Damage calculation.
- [ ] I-frames.
- [ ] Visual feedback blinking.
- [ ] Projectile manager.
- [ ] Enemy states.
- [ ] Enemy spawner.
- [ ] Enemy AI movement.
- [ ] Enemy environment interactions.
- [ ] LGBTQ+ inclusion ideas.
- [ ] Other/future level ideas.
- [ ] Visual reference assignments.

---

## End of Inventory
