# World 03 — Sticky Syrup Swamp

**World ID:** `sticky_syrup_swamp` · **Case:** `case_syrup` · **Culprit:** **Skyler “Syrup Scoundrel” Sugars** (they/them)

**Crime:** Pours syrup over buffet food, ruining the spread.

**Experience:** viscous syrup, pancake rafts and sticky traction. **Signature teaching mechanic:** Sticky movement and slow raft positioning.

## World identity

**Palette:** Amber, maple brown, moss green and pancake tan. The silhouette and environment materials must make sticky movement and slow raft positioning readable. Signature hazards recur across tutorial, escalation and boss; mechanics borrowed from other worlds remain secondary.

## Four-section chase progression

1. **Pancake Banks — slow surfaces with wide recovery space**
2. **Raft Crossing — moving pancakes and buttered bounce pads**
3. **Syrup Falls — vertical hazards, valves, golems**
4. **Cannon Clearing — syrup-spreading boss arena**

## Traversal and level components

**Platforms:** Pancake raft, sinking pancake, syrup-coated log and pancake stack.

**Hazards and machines:** Syrup pools, falls, drips and sticky puddle traps. Each hazardous state must provide a telegraph and at least one safe counter-path. Checkpoints follow major escalating sections and precede the boss.

## Enemies

Angry Bees; Syrup Golems; Flying Butter Pats. Tune encounter timing so players first learn each archetype separately, then with the level's signature movement constraint. Ranged attacks and moving hazards cannot occupy every safe landing at once.

## Boss: Skyler “Syrup Scoundrel” Sugars

**Encounter:** Syrup cannon and lane denial.

1. Skyler paints one clearly marked lane with syrup
2. Golems and moving raft patterns shorten the safe zone
3. An extended spray is followed by a predictable reload

**Intended counterplay:** Avoid pools, use Butter Boots when available, attack during reload windows.

## Equipment and rewards

**Loadout and power-ups:** Butter Knife; Sticky Net; Syrup Cannon; Butter Boots; Honey Comb; Syrup Launcher.

**Completion reward:** Syrup-case stamp and configured syrup utility unlock.

## Investigation and evidence

**Case evidence:** Dispenser residue, tampered valve seal, matching key imprint. The hub must offer an identity clue and a means/opportunity clue. A chase corroboration pickup should reinforce the accusation without retroactively changing whether the accusation was justified.

## Graybox and playtest requirements

**First tutorial beat:** Teach surface friction before adding chase pressure or raft movement.

**Primary readability risk:** Slowdown loops that keep the player trapped in persistent hazard fields.

**Acceptance:** complete the four-section course without an unavoidable hit; demonstrate one readable mechanic tutorial, one optional route, one working checkpoint, one evidence pickup, one unique enemy interaction and the authored boss counter. Test reduced flashing and controller navigation at every interaction.

**Implementation:** instantiate generic components from the reusable level kit, configure them with resources, and route case/boss/evidence events through application services. Do not place direct UI node paths in level machinery.
