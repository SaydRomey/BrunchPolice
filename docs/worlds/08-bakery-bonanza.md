# World 08 — Bakery Bonanza

**World ID:** `bakery_bonanza` · **Case:** `case_muffin` · **Culprit:** **Quinn “Muffin Mastermind” Munch** (they/them)

**Crime:** Hides muffins and smuggles them away from the buffet.

**Experience:** ovens, rising dough, flour obscuration and baking-tray cover. **Signature teaching mechanic:** Expandable temporary platforms plus cover-breaking under flour haze.

## World identity

**Palette:** Oven orange, crust brown, butter beige and flour white. The silhouette and environment materials must make expandable temporary platforms plus cover-breaking under flour haze readable. Signature hazards recur across tutorial, escalation and boss; mechanics borrowed from other worlds remain secondary.

## Four-section chase progression

1. **Oven Door — warm-up dough lifts and safe oven windows**
2. **Rising Bakery — expanding dough, trays and conveyor paths**
3. **Flour Storm — reduced visibility with clear telegraphs**
4. **Muffin Vault — cover-break boss arena**

## Traversal and level components

**Platforms:** Rising/collapsing dough platforms, conveyor trays, bread loaf, metal stairs.

**Hazards and machines:** Hot oven flames, flour clouds, falling pans/trays and rolling muffin trays. Each hazardous state must provide a telegraph and at least one safe counter-path. Checkpoints follow major escalating sections and precede the boss.

## Enemies

Flour Bag Monsters; Rolling Muffin Trays; Burning Muffins. Tune encounter timing so players first learn each archetype separately, then with the level's signature movement constraint. Ranged attacks and moving hazards cannot occupy every safe landing at once.

## Boss: Quinn “Muffin Mastermind” Munch

**Encounter:** Explosive muffin throws behind tray cover.

1. Quinn uses staggered explosive muffin arcs from tray cover
2. More tray shields appear as flour clouds shorten visibility
3. Breaking cover creates a clear final strike window

**Intended counterplay:** Clear baking trays and approach during throw recovery; Oven Mitts aid heat traversal.

## Equipment and rewards

**Loadout and power-ups:** Dough Cutter; Flour Puff; Bread Roller; Dough Roller; Flour Blaster; Oven Mitts; Muffin Shield.

**Completion reward:** Final case stamp and campaign resolution sequence.

## Investigation and evidence

**Case evidence:** Missing muffin count, flour trail, stamped wrapper and concealed cache. The hub must offer an identity clue and a means/opportunity clue. A chase corroboration pickup should reinforce the accusation without retroactively changing whether the accusation was justified.

## Graybox and playtest requirements

**First tutorial beat:** Teach rising dough as a timed platform over safe ground before pairing with flames.

**Primary readability risk:** Flour cloud fully obscuring an unsafe platform edge.

**Acceptance:** complete the four-section course without an unavoidable hit; demonstrate one readable mechanic tutorial, one optional route, one working checkpoint, one evidence pickup, one unique enemy interaction and the authored boss counter. Test reduced flashing and controller navigation at every interaction.

**Implementation:** instantiate generic components from the reusable level kit, configure them with resources, and route case/boss/evidence events through application services. Do not place direct UI node paths in level machinery.
