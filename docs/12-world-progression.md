# World Structure and Campaign Progression

## Campaign map

The buffet is the persistent case hub. The initial release design has eight main cases in the order below; case progression is sequential by default, with optional backtracking and previously completed level replay. New Game exposes Case 1; solving a case unlocks the next case and preserves all discovered evidence.

| Order | Case ID | World ID | Core tutorial | Mastery and boss use |
|---|---|---|---|---|
| 1 | `case_bacon` | `grease_canyon` | Grease pits, ropes, timing | Tornado and grease evasion |
| 2 | `case_croissant` | `pastry_palace` | Rotating mixers and frosting | Sticky obstacles and ranged dash boss |
| 3 | `case_syrup` | `sticky_syrup_swamp` | Slow traction, mobile pancake rafts | Syrup cannon, reload gaps |
| 4 | `case_cutlery` | `kitchen_mayhem` | Cover, knives, steam | Break dish cover, projectile lanes |
| 5 | `case_coffee` | `caffeine_craze` | Steam pressure cycles and lifts | Multi-valve overpressure encounter |
| 6 | `case_omelet` | `egg_factory_frenzy` | Conveyors and egg machinery | Spatula flip and shell guard |
| 7 | `case_juice` | `citrus_cascade` | Juice pushback and launchers | Juicer stream timing |
| 8 | `case_muffin` | `bakery_bonanza` | Oven heat, dust and growing dough | Baking-tray cover and explosive muffins |

## World structure requirement

Each level has an arrival/tutorial zone, mechanical escalation, optional exploration branch, checkpoint(s), pre-boss consolidation, boss arena, reward sequence and transition. The level must reinforce its signature interaction in at least three contexts before expecting the player to use it in a boss encounter. Reused mechanics appear as secondary accents, never displacing the world's identity.

## Progress state

`locked` → `available` → `investigating` → `chase_unlocked` → `chase_active` → `boss_defeated` → `solved`. Replaying a solved world uses a separate replay context and cannot erase campaign completion or reissue one-time rewards.

## Navigation

The case board shows cases available for investigation; the hub map displays buffet stations, active NPCs and solved-case stamps. Exits are controlled by scene routing; the project may present kitchen, bathroom or outdoor chase entrances as story choices, but each case still routes to its authored world scene.

## Rewards and completion

Completing a case grants a case stamp, unlocks the next station, resolves the NPC dialogue arc and grants the configured permanent item or currency exactly once. Optional evidence and collectibles are tracked separately from required completion. See [Save](15-save-and-persistence.md).
