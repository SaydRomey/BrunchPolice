# World 07 — Citrus Cascade

**World ID:** `citrus_cascade` · **Case:** `case_juice` · **Culprit:** **Jordan “Juice Jacker” Squeeze** (they/them)

**Crime:** Steals orange juice bottles from the buffet.

**Experience:** orange-slice platforms and directional juice propulsion. **Signature teaching mechanic:** Juice pushback vs controlled launch arcs.

## World identity

**Palette:** Orange, lemon yellow, lime green, juicy teal. The silhouette and environment materials must make juice pushback vs controlled launch arcs readable. Signature hazards recur across tutorial, escalation and boss; mechanics borrowed from other worlds remain secondary.

## Four-section chase progression

1. **Juice Grove — citrus platforms and simple slippery arcs**
2. **Pipe Terrace — directional fountains and valve changes**
3. **Acid Falls — orange peel rollers and bat swoops**
4. **Bottling Duel — juicer boss arena**

## Traversal and level components

**Platforms:** Orange-slice discs, citrus wedge lifts, pipe platforms and floating peel.

**Hazards and machines:** Juice jets/streams, acid pools, juicer blades, rolling peels and fountains. Each hazardous state must provide a telegraph and at least one safe counter-path. Checkpoints follow major escalating sections and precede the boss.

## Enemies

Squeezing Machines; Lemon Bats; Orange Peel Traps. Tune encounter timing so players first learn each archetype separately, then with the level's signature movement constraint. Ranged attacks and moving hazards cannot occupy every safe landing at once.

## Boss: Jordan “Juice Jacker” Squeeze

**Encounter:** Juicer streams and reload windows.

1. Jordan sprays broad predictable horizontal jets
2. Moving platforms shorten safe spaces without concealing cues
3. A pressure pause exposes the juicer after a defined reload

**Intended counterplay:** Dodge streams and use approach windows after the juicer reloads.

## Equipment and rewards

**Loadout and power-ups:** Orange Zester; Juice Squeezer; Citrus Blaster; Zester Shooter; Vitamin Boost.

**Completion reward:** Citrus-case stamp and juice weapon unlock.

## Investigation and evidence

**Case evidence:** Juice rack vacancy, broken bottle seals, matching bottling tags. The hub must offer an identity clue and a means/opportunity clue. A chase corroboration pickup should reinforce the accusation without retroactively changing whether the accusation was justified.

## Graybox and playtest requirements

**First tutorial beat:** Present a safe fountain launch over solid ground before adding acid.

**Primary readability risk:** Liquid directional force mixing with slippery traction unpredictably.

**Acceptance:** complete the four-section course without an unavoidable hit; demonstrate one readable mechanic tutorial, one optional route, one working checkpoint, one evidence pickup, one unique enemy interaction and the authored boss counter. Test reduced flashing and controller navigation at every interaction.

**Implementation:** instantiate generic components from the reusable level kit, configure them with resources, and route case/boss/evidence events through application services. Do not place direct UI node paths in level machinery.
