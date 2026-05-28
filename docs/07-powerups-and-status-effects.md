# Power-Ups and Status Effects

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


## Related Evidence Inventory

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


## Related Enemy Status States

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
