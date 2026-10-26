# World 05 — Caffeine Craze

**World ID:** `caffeine_craze` · **Case:** `case_coffee` · **Culprit:** **Marlowe “Mocha Menace” Mugs** (they/them)

**Crime:** Hoards all fresh coffee and sabotages buffet dispensers with decaf.

**Experience:** steam pressure cycles, copper valves, giant mugs and vertical espresso machinery. **Signature teaching mechanic:** Four-phase pressure cycles, steam lift and valve redirection.

## World identity

**Palette:** Espresso, caramel, copper, porcelain cream, teal and warning red. The silhouette and environment materials must make four-phase pressure cycles, steam lift and valve redirection readable. Signature hazards recur across tutorial, escalation and boss; mechanics borrowed from other worlds remain secondary.

## Four-section chase progression

1. **The Coffee Counter — cups, saucers, Bean Bouncers and one safe steam pulse**
2. **The Roasting Room — grinders, bean conveyors and Grinder Gremlins**
3. **The Espresso Engine — vertical steam lifts, valves and temporary foam platforms**
4. **The Grand Percolator — multi-valve overpressure boss**

## Traversal and level components

**Platforms:** Giant mugs and saucers, cup-handle ledges, rising/fragile milk-foam platforms.

**Hazards and machines:** Horizontal damaging steam, vertical propelling vents, grinder teeth, falling beans, moving roasting drums. Each hazardous state must provide a telegraph and at least one safe counter-path. Checkpoints follow major escalating sections and precede the boss.

## Enemies

Bean Bouncers; Grinder Gremlins; Froth Flyers. Tune encounter timing so players first learn each archetype separately, then with the level's signature movement constraint. Ranged attacks and moving hazards cannot occupy every safe landing at once.

## Boss: Marlowe “Mocha Menace” Mugs

**Encounter:** Grand Percolator espresso machine.

1. Espresso Assault — horizontal espresso sweep lanes with clear safe platforms
2. Caffeine Overload — bouncing bean volleys plus floor vent patterns
3. Pressure Meltdown — redirect valves to overheat machine and expose cockpit

**Intended counterplay:** Read pressure gauge, operate valves in safe windows and attack exposed cockpit.

## Equipment and rewards

**Loadout and power-ups:** Espresso Stirrer; Coffee Filter Shield; Portafilter Blaster; Tamper Hammer; Bean Bomb; Caffeine Rush; Foam Barrier.

**Completion reward:** Coffee-case stamp, Bean Bomb unlock and espresso machinery mastery.

## Investigation and evidence

**Case evidence:** Missing carafe labels, decaf swap, spilled coffee and stolen coffee tags. The hub must offer an identity clue and a means/opportunity clue. A chase corroboration pickup should reinforce the accusation without retroactively changing whether the accusation was justified.

## Graybox and playtest requirements

**First tutorial beat:** Use a four-phase gauge near a single safe vent before any hostile jet; next demonstrate an upward lift.

**Primary readability risk:** Confusing launching steam with damaging steam, or overlapping machine hazards with no recovery platform.

**Acceptance:** complete the four-section course without an unavoidable hit; demonstrate one readable mechanic tutorial, one optional route, one working checkpoint, one evidence pickup, one unique enemy interaction and the authored boss counter. Test reduced flashing and controller navigation at every interaction.

**Implementation:** instantiate generic components from the reusable level kit, configure them with resources, and route case/boss/evidence events through application services. Do not place direct UI node paths in level machinery.

## Steam-pressure specification

The mechanical coffee wonderland develops from recognisable counter equipment into a giant interconnected espresso engine. Avoid coffee rivers or pervasive liquid traction: steam timing, valve direction, and vertical traversal must distinguish this world from syrup and citrus.

| Pressure phase | Telegraph | Vent behavior | Player response |
|---|---|---|---|
| `low` | Needle low, idle pipe | Dormant | Cross or reposition |
| `building` | Rising needle, shaking metal, ticking sound | Safe warning | Prepare to dodge or launch |
| `release` | Gauge peak, directed steam sprite and hiss | Active damage/push or vertical lift | Dodge horizontal jet; ride upward vent |
| `recovery` | Fading steam, valve clunk | Shut down | Advance and manipulate valve |

Valves can redirect steam, delay a cycle or open optional routes. The cycle controller must broadcast state to all listeners; individual vents must not drift into unrelated timers unless an authored offset is explicit. Steam lifts cannot deal damage by default; a dangerous vent must have a separate unmistakable nozzle pattern. Provide a static platform beyond any foam-platform collapse.

### Caffeine enemies

- **Bean Bouncers:** nimble ground hoppers. Later bounce sequences accelerate; a pause between bursts supplies a readable punish window.
- **Grinder Gremlins:** armored short-burst ranged turrets with contact-danger grinder teeth; shots follow a visible windup and are vulnerable to heavy counters.
- **Froth Flyers:** milk-foam aerial patrols that launch temporary trapping/slow bubbles; they challenge vertical trajectories without making all platforms unsafe.

### Boss pressure transaction

Pressure valves are globally coordinated by the encounter controller. During the final phase: warning → release → player reaches safe valve → valve activated → machine overload event → armor disabled for a finite window → player hits exposed cockpit → recovery. Repeat with escalating but readable timing. The machine cannot self-overload through an unrelated timed event; required valves have redundant access routes after a fall.

### Coffee equipment

| Item | Slot | Action |
|---|---|---|
| Espresso Stirrer | Main | Quick spoon strikes; charged longer poke |
| Coffee Filter Shield | Off | Projectile block and limited steam mitigation |
| Portafilter Blaster | Two-handed | Compressed coffee-ground shot |
| Tamper Hammer | Special level weapon | Stuns Grinder Gremlins and knocks back projectiles; can free jammed valves |
| Bean Bomb | Reward throwable | Scatter burst damaging/slowing enemies |
| Caffeine Rush | Temporary buff | Haste on movement and attacks |
| Foam Barrier | Temporary shield | Absorbs one accepted hit |

### Caffeine art values

`#251A18` espresso outline, `#513427` deep machinery, `#714930` roasted surfaces, `#A46A40` caramel, `#C98447` copper, `#ECD6B2` porcelain, `#FFF1D5` steam/foam, `#5A938C` teal separation, `#C45E45` warning red. Show machine silhouettes, valves and nozzle directions; all steam states need non-color telegraphs.
