# Enemy Taxonomy

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
