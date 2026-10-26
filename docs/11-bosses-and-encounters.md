# Culprits, Bosses and Arena Encounters

## Canonical culprits

| World | Culprit | Crime | Core counterplay |
|---|---|---|---|
| Grease Canyon | Bailey “Bacon Bandit” Brown | Takes an entire plate of bacon | Dodge Bacon Tornado; punish slowdown using Bacon Gun |
| Pastry Palace | Cameron “Croissant Crook” Cline | Conceals stolen croissants | Avoid sticky thrown croissants; punish throw recovery |
| Sticky Syrup Swamp | Skyler “Syrup Scoundrel” Sugars | Dumps syrup across buffet food | Avoid cannon-covered zones; punish reload |
| Kitchen Mayhem | Casey “Cutlery Thief” Canes | Steals forks, spoons and knives | Destroy dish cover; evade projectiles |
| Caffeine Craze | Marlowe “Mocha Menace” Mugs | Hoards coffee, sabotages dispensers | Redirect steam, overheat machine, strike exposed cockpit |
| Egg Factory Frenzy | Morgan “Omelet Overlord” Eggman | Takes all eggs for a giant omelet | Avoid spatula flips; use Egg Launcher to crack guard |
| Citrus Cascade | Jordan “Juice Jacker” Squeeze | Steals orange juice | Dodge juice streams; punish reload |
| Bakery Bonanza | Quinn “Muffin Mastermind” Munch | Hides stolen muffins | Break tray cover; dodge explosive muffins |

All culprits use **they/them** pronouns in game text unless a distinct character profile explicitly specifies otherwise.

## Boss components

`BossCore` owns health thresholds, invulnerability policies, current phase, phase-change signals, exposed windows and defeat transaction; a boss controller owns spatial patterns and authored choreography. `EncounterController` activates hazards, waves and cutscenes. Bosses must not inherit generic enemy behavior assumptions such as patrolling off platforms.

## Phase design template

Every phase must describe entry condition, attack rotation, telegraph animation, recovery windows, active environmental machines, weapon interaction, safe-zone layout, phase-exit event and difficulty escalation. Vulnerability windows emit start/end events and show an unmistakable visual plus audio cue.

## Common arena flow

Intro (safe player position) → teach one pattern → patterned attacks → counter interaction → vulnerability → damage opportunity → next phase or final defeat. A boss defeat is committed exactly once, after animation and rewards, and triggers case resolution. Failing the boss routes to its checkpoint without duplicating evidence or rewards.

## Caffeine Craze: Grand Percolator

1. **Espresso Assault:** horizontal espresso streams sweep marked lanes; players use platform height for safe positioning.
2. **Caffeine Overload:** faster volleys of bouncing beans and triggered floor vents require phase-reading.
3. **Pressure Meltdown:** control valves at safe windows, build overpressure and expose Marlowe's cockpit for deliberate strikes.

Pressure is visible as a four-state gauge (`LOW`, `BUILDING`, `RELEASE`, `RECOVERY`) with non-color cues; valves must remain reachable without damage in at least one authored safe window. The boss uses the world signature mechanic as its defeat path, not raw DPS alone.

## Acceptance

Boss mechanics remain legible with effects reduced, during camera motion, and under both keyboard/gamepad input. No mandatory hit occurs from offscreen without a warning; vulnerability never closes mid-hit without resolving an accepted strike according to the chosen active-frame rules.
