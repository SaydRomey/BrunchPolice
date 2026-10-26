# World 02 — Pastry Palace

**World ID:** `pastry_palace` · **Case:** `case_croissant` · **Culprit:** **Cameron “Croissant Crook” Cline** (they/them)

**Crime:** Conceals croissants and sneaks them away in a carry bag.

**Experience:** pastry platforms, rotating mixers, brittle dough and sticky frosting. **Signature teaching mechanic:** Mixer rotation and breakable/sticky pastry surfaces.

## World identity

**Palette:** Butter gold, baked beige, cream and frosting pink. The silhouette and environment materials must make mixer rotation and breakable/sticky pastry surfaces readable. Signature hazards recur across tutorial, escalation and boss; mechanics borrowed from other worlds remain secondary.

## Four-section chase progression

1. **Croissant Stacks — basic curved pastry jumping**
2. **Mixer Gallery — telegraphed rotating arms and soft landings**
3. **Frosting Maze — sticky slowdown and breakable floor**
4. **Grand Pastry Display — croissant-throwing boss**

## Traversal and level components

**Platforms:** Croissant platforms, donut steps, giant bowls, pastry shelves.

**Hazards and machines:** Mixer arms, falling pastry, cream jets, brittle floors and frosting patches. Each hazardous state must provide a telegraph and at least one safe counter-path. Checkpoints follow major escalating sections and precede the boss.

## Enemies

Flying Éclairs; Rolling Baguette; Jelly-Filled Donuts; Rolling Croissants. Tune encounter timing so players first learn each archetype separately, then with the level's signature movement constraint. Ranged attacks and moving hazards cannot occupy every safe landing at once.

## Boss: Cameron “Croissant Crook” Cline

**Encounter:** Oversized sticky croissant volleys and dashes.

1. Cameron telegraphs slow throws that create persistent cover
2. Dashes between platforms while rolling pastries enter side lanes
3. Frequent throws and short recovery windows reward timed approaches

**Intended counterplay:** Use Syrup Boots to avoid sticky slowdown and attack during throwing recovery.

## Equipment and rewards

**Loadout and power-ups:** Croissant Cutter; Whipped Cream Shield; Baguette Maul; Bread Slicer; Whipped Cream Cannon.

**Completion reward:** Pastry-case stamp and configured cream-projectile unlock.

## Investigation and evidence

**Case evidence:** Croissant wrapping and receipt; hidden crumb-lined bag; matching pastry wrappers. The hub must offer an identity clue and a means/opportunity clue. A chase corroboration pickup should reinforce the accusation without retroactively changing whether the accusation was justified.

## Graybox and playtest requirements

**First tutorial beat:** Show one mixer sweep over safe ground before adding a falling pastry.

**Primary readability risk:** Frosting and mixer overlap hiding reachable escape routes.

**Acceptance:** complete the four-section course without an unavoidable hit; demonstrate one readable mechanic tutorial, one optional route, one working checkpoint, one evidence pickup, one unique enemy interaction and the authored boss counter. Test reduced flashing and controller navigation at every interaction.

**Implementation:** instantiate generic components from the reusable level kit, configure them with resources, and route case/boss/evidence events through application services. Do not place direct UI node paths in level machinery.
