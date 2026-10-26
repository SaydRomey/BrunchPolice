# World 06 — Egg Factory Frenzy

**World ID:** `egg_factory_frenzy` · **Case:** `case_omelet` · **Culprit:** **Morgan “Omelet Overlord” Eggman** (they/them)

**Crime:** Takes the buffet eggs to make a giant omelet.

**Experience:** egg-carton platforms, conveyor lines, egg chutes and presses. **Signature teaching mechanic:** Conveyor-relative movement and shell-guard cracking.

## World identity

**Palette:** Eggshell white, yolk yellow, metal steel and factory orange. The silhouette and environment materials must make conveyor-relative movement and shell-guard cracking readable. Signature hazards recur across tutorial, escalation and boss; mechanics borrowed from other worlds remain secondary.

## Four-section chase progression

1. **Sorting Belt — introduction to conveyor carry**
2. **Egg Chute — falling and cracking shell hazards**
3. **Press Room — crushers, reversible belts and drones**
4. **Omelet Station — spatula boss arena**

## Traversal and level components

**Platforms:** Conveyor belts, eggshell flats, frying-pan lifts and egg-carton ledges.

**Hazards and machines:** Yolk spill, shell shards, egg bombs, presses and egg chutes. Each hazardous state must provide a telegraph and at least one safe counter-path. Checkpoints follow major escalating sections and precede the boss.

## Enemies

Angry Chickens; Eggshell Drones; Frying Pans; Cracked Egg Creatures. Tune encounter timing so players first learn each archetype separately, then with the level's signature movement constraint. Ranged attacks and moving hazards cannot occupy every safe landing at once.

## Boss: Morgan “Omelet Overlord” Eggman

**Encounter:** Spatula flip and armored egg machinery.

1. Morgan guards while spatula attacks demand lateral movement
2. Egg drones pressure conveyor lanes and repositioning
3. Egg Launcher cracks protective shell and opens a strike window

**Intended counterplay:** Avoid spatula flips and use Egg Launcher to crack defenses.

## Equipment and rewards

**Loadout and power-ups:** Egg Beater; Yolk Bomb; Frying Pan; Egg Whisk; Egg Launcher; Omelet Shield; Egg Timer.

**Completion reward:** Egg-case stamp and Egg Launcher availability.

## Investigation and evidence

**Case evidence:** Egg count discrepancy, shipping label, factory carton seals. The hub must offer an identity clue and a means/opportunity clue. A chase corroboration pickup should reinforce the accusation without retroactively changing whether the accusation was justified.

## Graybox and playtest requirements

**First tutorial beat:** Teach walking against a conveyor before adding any egg projectile.

**Primary readability risk:** Carried player speed through a crushing press becoming unavoidable.

**Acceptance:** complete the four-section course without an unavoidable hit; demonstrate one readable mechanic tutorial, one optional route, one working checkpoint, one evidence pickup, one unique enemy interaction and the authored boss counter. Test reduced flashing and controller navigation at every interaction.

**Implementation:** instantiate generic components from the reusable level kit, configure them with resources, and route case/boss/evidence events through application services. Do not place direct UI node paths in level machinery.
