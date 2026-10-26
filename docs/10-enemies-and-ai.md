# Enemies and AI

## Reusable controller model

Regular actors consist of a scene, `EnemyDefinition` resource, movement strategy, targeting/attack strategy, health/hit receiver, status component and feedback component. Distinguish **behavior state** (`idle`, `patrol`, `chase`, `attack`, `recover`, `retreat`, `flee`) from **combat overlays** (`stunned`, `frozen`, `wrapped`, `slowed`, `blinded`, `invincible`). An overlay modifies or interrupts a behavior state but does not erase its original objective.

## Enemy schema

`enemy_id`, display name key, world tags, archetype, max HP, speed, contact damage, detection distance, preferred attack distance, cooldown, movement/attack strategy IDs, status resistances, drops, score and VFX profile.

## Behavioral families

Ground patrol, charge/swoop, hopper, lane roller, flying patrol, flying bomber, ranged sentry, turret, summoned minion, armored guard and environment-bound hazard. Reuse these families for food variants rather than branching on enemy names. Enemies are platform-edge aware unless a deliberate attack overrides this limit.

## World roster

| World | Primary enemies | Learning focus |
|---|---|---|
| Grease Canyon | Small Angry Pigs; Bacon Worms; Flying Sausage Links | Charge timing, rope hazards, swoops |
| Pastry Palace | Flying Éclairs; Rolling Baguette; Jelly-Filled Donuts; Rolling Croissants | Ranged arcs, rolling lanes, exploding pursuers |
| Sticky Syrup Swamp | Angry Bees; Syrup Golems; Flying Butter Pats | Combat under sticky movement constraints |
| Kitchen Mayhem | Knife-Throwing Chefs; Dishwashing Sponges; Spinning Ladles | Cover, hopping pressure, stationary blades |
| Caffeine Craze | Bean Bouncers; Grinder Gremlins; Froth Flyers | Accelerating hops, armored shots, airborne control |
| Egg Factory Frenzy | Angry Chickens; Eggshell Drones; Frying Pans; Cracked Egg Creatures | Conveyors, bombing, shell hatching |
| Citrus Cascade | Squeezing Machines; Lemon Bats; Orange Peel Traps | Pushback jets, swoops and rolling hazards |
| Bakery Bonanza | Flour Bag Monsters; Rolling Muffin Trays; Burning Muffins | Visibility, lane control and fast charges |

See [the full enemy roster](reference/enemy-roster.md) for role, contact behavior, counterplay and environmental relationships.

## Encounter constraints

Every enemy must show direction and actionable telegraph before a punishing attack. Spawners cap concurrency, clean up on level unload, and provide authored minimum safe spacing around player spawn/checkpoint. Pause and dialogue freeze movement/attacks; offscreen despawn may never invalidate a required quest objective.
