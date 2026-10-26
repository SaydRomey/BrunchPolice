# World 04 — Kitchen Mayhem

**World ID:** `kitchen_mayhem` · **Case:** `case_cutlery` · **Culprit:** **Casey “Cutlery Thief” Canes** (they/them)

**Crime:** Steals utensils and hides them among kitchen equipment.

**Experience:** flying utensils, timed mechanical hazards and destructible dish cover. **Signature teaching mechanic:** Reading utensil arcs while using cover.

## World identity

**Palette:** White tile, gray steel, wooden brown, burner orange. The silhouette and environment materials must make reading utensil arcs while using cover readable. Signature hazards recur across tutorial, escalation and boss; mechanics borrowed from other worlds remain secondary.

## Four-section chase progression

1. **Countertop Entry — cutting boards and short utensil paths**
2. **Dish Rack Aisle — safe cover and sponge hoppers**
3. **Hot Line — frying pans, burners and steam vents**
4. **Dish-Pile Showdown — breakable protection boss**

## Traversal and level components

**Platforms:** Countertops, cutting boards, pot lids, dish racks, moving carts.

**Hazards and machines:** Chopping knives, falling pans, steam vents, burners, rolling cans and dishwater. Each hazardous state must provide a telegraph and at least one safe counter-path. Checkpoints follow major escalating sections and precede the boss.

## Enemies

Knife-Throwing Chefs; Dishwashing Sponges; Spinning Ladles. Tune encounter timing so players first learn each archetype separately, then with the level's signature movement constraint. Ranged attacks and moving hazards cannot occupy every safe landing at once.

## Boss: Casey “Cutlery Thief” Canes

**Encounter:** Stolen cutlery behind dish cover.

1. Casey attacks from behind a shallow dish pile
2. Players break cover and punish a short exposure interval
3. Rapid throws and smaller cover piles change lane choices

**Intended counterplay:** Destroy the dish piles, block with Hot Lid and strike while exposed.

## Equipment and rewards

**Loadout and power-ups:** Chef's Cleaver; Hot Lid; Rolling Pin Roller; Dishwasher Sprayer; Shield of Cutlery.

**Completion reward:** Cutlery-case stamp and configured kitchen defensive item.

## Investigation and evidence

**Case evidence:** Empty cutlery rack, irregular utensil inventory, initialed cutlery cache. The hub must offer an identity clue and a means/opportunity clue. A chase corroboration pickup should reinforce the accusation without retroactively changing whether the accusation was justified.

## Graybox and playtest requirements

**First tutorial beat:** Teach duck/cover at a single knife throw before pairing with burners.

**Primary readability risk:** Offscreen airborne knives intersecting mandatory jump landings.

**Acceptance:** complete the four-section course without an unavoidable hit; demonstrate one readable mechanic tutorial, one optional route, one working checkpoint, one evidence pickup, one unique enemy interaction and the authored boss counter. Test reduced flashing and controller navigation at every interaction.

**Implementation:** instantiate generic components from the reusable level kit, configure them with resources, and route case/boss/evidence events through application services. Do not place direct UI node paths in level machinery.
