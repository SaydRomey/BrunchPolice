# Environment Design Systems

## Purpose

This document defines reusable environmental systems for BP2 / Brunch Police side-scrolling levels, including platform types, hazards, interactions, background treatment, ambiance, and systemic design rules.

---

## 1. Platform Types

Platforms should be defined by material, movement, risk, and readability.

| Platform Type                 | Behavior                                                                                            | Gameplay Use                                               |
| ----------------------------- | --------------------------------------------------------------------------------------------------- | ---------------------------------------------------------- |
| Static themed platforms       | Stable ground made from food props, machinery, trays, counters, terrain, or level-specific objects. | Baseline traversal and combat footing.                     |
| Wiggling / unstable platforms | Shake, bend, drip, wobble, or deform before recovering.                                             | Adds timing pressure without necessarily removing footing. |
| Collapsing platforms          | Break after the player stands on them briefly.                                                      | Forces commitment and forward movement.                    |
| Moving platforms              | Travel horizontally, vertically, diagonally, or on loops.                                           | Creates timing and spacing challenges.                     |
| Conveyor platforms            | Push the player in one direction.                                                                   | Useful for factory, kitchen, or processing levels.         |
| Slippery platforms            | Reduce traction and braking control.                                                                | Creates movement challenge without direct damage.          |
| Sticky platforms              | Slow movement and jump recovery.                                                                    | Creates vulnerability and soft control loss.               |
| Bounce platforms              | Launch the player upward or forward.                                                                | Enables vertical traversal, alternate paths, and secrets.  |
| Rotating platforms            | Spin around a center point or flip orientation.                                                     | Tests timing and spatial awareness.                        |
| Hazard-adjacent platforms     | Safe surfaces placed near grease, syrup, heat, juice, chocolate, or machinery.                      | Creates risk/reward positioning.                           |
| Enemy staging platforms       | Platforms sized and placed around enemy patrols, ambushes, or ranged attacks.                       | Shapes combat encounters.                                  |
| Boss-arena platforms          | Wider, readable, and usually organized around safe zones and telegraphed hazard lanes.              | Supports boss pattern clarity.                             |

---

## 2. Hazard Categories

Hazards should communicate their danger visually before they punish the player.

### Damage Hazards

| Hazard Type      | Examples                                                   |
| ---------------- | ---------------------------------------------------------- |
| Hot liquid       | Grease pits, chocolate lava, boiling syrup.                |
| Fire / heat      | Ovens, griddles, burners, flaming pastry.                  |
| Sharp objects    | Knives, forks, slicers, juicer blades.                     |
| Crushing hazards | Mixers, presses, falling pans, oven doors.                 |
| Projectiles      | Whipped cream shots, juice jets, yolk bombs, flying bacon. |
| Explosives       | Jelly donuts, explosive muffins, jam bombs.                |

### Movement Hazards

| Hazard Type             | Effect                                             |
| ----------------------- | -------------------------------------------------- |
| Slippery surfaces       | Reduced traction and harder stopping.              |
| Sticky surfaces         | Slower movement and jump recovery.                 |
| Pushback jets           | Force the player backward, upward, or into danger. |
| Conveyor belts          | Override player positioning.                       |
| Rotating platforms      | Disrupt footing and timing.                        |
| Visibility blockers     | Reduce sightlines and enemy readability.           |
| Bounce / launch hazards | Can help or harm depending on player control.      |

### Soft Hazards

Soft hazards create vulnerability without always dealing direct damage.

| Soft Hazard        | Gameplay Function                             |
| ------------------ | --------------------------------------------- |
| Syrup puddles      | Slow the player before enemy attacks.         |
| Flour clouds       | Obscure platforms, enemies, and pickups.      |
| Steam vents        | Temporarily block sightlines or force timing. |
| Grease splashes    | Force jumps or evasive movement.              |
| Rolling food props | Interrupt movement routes.                    |
| Sticky pulp        | Briefly slows or traps the player.            |

---

## 3. Reusable Interaction Systems

| Interaction      | Description                                                |
| ---------------- | ---------------------------------------------------------- |
| Grab / climb     | Ropes, sausage links, licorice, ladders, hanging utensils. |
| Bounce           | Pancakes, gumdrops, dough pads, muffins, citrus pads.      |
| Slide            | Grease trails, juice streams, syrup slopes.                |
| Ride             | Pancake rafts, conveyor belts, trays, orange slices.       |
| Break            | Crates, jars, brittle pastries, eggshell barriers.         |
| Push / pull      | Kitchen carts, syrup barrels, baking trays.                |
| Activate         | Switches, levers, oven doors, juicer machines.             |
| Redirect         | Pipes, juice jets, conveyor switches, syrup valves.        |
| Shield / block   | Baking trays, pot lids, large pancakes.                    |
| Collect evidence | Food scraps, stolen items, culprit clues.                  |

---

## 4. Reusable Environmental Systems

These should be implemented once and reskinned per level.

| System             | Possible Reskins                                      |
| ------------------ | ----------------------------------------------------- |
| Slippery surface   | Grease, juice, syrup, butter.                         |
| Sticky surface     | Syrup, frosting, caramel, pulp.                       |
| Timed crusher      | Mixer, frying pan, juicer press, oven door.           |
| Launcher           | Juice fountain, soda spray, steam vent, dough bounce. |
| Moving platform    | Pancake raft, conveyor tray, orange slice, cake lift. |
| Swing rope         | Sausage links, licorice, utensils, dough strands.     |
| Visibility blocker | Flour cloud, steam, syrup mist, smoke.                |
| Rolling hazard     | Baguette, orange peel, muffin tray, candy ball.       |
| Projectile turret  | Squeezing machine, whipped cream cannon, yolk drone.  |
| Breakable barrier  | Eggshell, brittle candy, pastry crust, flour crate.   |

---

## 5. Background Layering

| Layer             | Purpose                                                                                        |
| ----------------- | ---------------------------------------------------------------------------------------------- |
| Far background    | Establishes the setting silhouette: canyon, palace, swamp, kitchen, factory, bakery, etc.      |
| Mid background    | Shows machinery, oversized food props, distant enemies, stolen goods, or patrol routes.        |
| Near background   | Adds depth through pipes, counters, hanging utensils, dripping food, or foreground structures. |
| Foreground        | Used sparingly for flour, steam, syrup drips, hanging food, smoke, or machinery edges.         |
| Parallax elements | Moving clouds, floating crumbs, bacon comets, bubbles, citrus spray, candy sparkles.           |

---

## 6. Ambiance Rules

Ambiance should reinforce both the material identity and the mechanical identity of each level.

### Audio Ambiance

Use looping background beds and short positional effects. Avoid overloading the mix during combat-heavy scenes.

Common sound types:

- Liquid sounds: dripping, bubbling, splashing, sloshing.
- Heat sounds: sizzling, crackling, oven hums.
- Machine sounds: conveyors, gears, mixers, alarms.
- Food impact sounds: splats, crunches, puffs, boings.
- Creature or enemy sounds: snorts, clucks, buzzing, mutters.
- Space sounds: room tone, outdoor wind, kitchen reverb, factory echo.

### Visual Ambiance

Use particles and lighting to support navigation, not just decoration.

Common visual treatments:

- Heat shimmer.
- Steam or flour clouds.
- Sticky surface reflections.
- Glowing hazard edges.
- Dripping liquids.
- Floating crumbs or particles.
- Directional lighting near exits, interactables, and key traversal routes.

---

## 7. Level Design Rule of Thumb

Each level should include:

1. One primary traversal gimmick.
2. One primary surface modifier.
3. One recurring moving hazard.
4. One verticality tool.
5. One boss-relevant environmental mechanic.

This keeps every level distinct while preserving a coherent platforming vocabulary across the game.
