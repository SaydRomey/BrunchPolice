# World 01 — Grease Canyon

**World ID:** `grease_canyon` · **Case:** `case_bacon` · **Culprit:** **Bailey “Bacon Bandit” Brown** (they/them)

**Crime:** Takes an entire plate of bacon from the buffet.

**Experience:** bacon-strip platforms, sausage ropes, boiling grease and the Bacon Tornado. **Signature teaching mechanic:** Hot grease timing and rope route selection.

## World identity

**Palette:** Sizzling reds, golds and smoked browns. The silhouette and environment materials must make hot grease timing and rope route selection readable. Signature hazards recur across tutorial, escalation and boss; mechanics borrowed from other worlds remain secondary.

## Four-section chase progression

1. **Sizzling Welcome — stable bacon planks and one grease gap**
2. **Sausage Heights — hanging sausage-link rope routes and swooping links**
3. **Griddle Run — fat drips, timed grease splashes and pigs**
4. **Tornado Ring — bacon spiral columns and boss**

## Traversal and level components

**Platforms:** Bacon strips; swaying sausage ropes; alternate elevated ledges.

**Hazards and machines:** Boiling grease pits, periodic grease splash, dripping fat and suspended strips. Each hazardous state must provide a telegraph and at least one safe counter-path. Checkpoints follow major escalating sections and precede the boss.

## Enemies

Small Angry Pigs; Bacon Worms; Flying Sausage Links. Tune encounter timing so players first learn each archetype separately, then with the level's signature movement constraint. Ranged attacks and moving hazards cannot occupy every safe landing at once.

## Boss: Bailey “Bacon Bandit” Brown

**Encounter:** Bacon Tornado.

1. Bacon whirlwind introduces a protected upper route
2. Fast rotating debris punishes overcommitting to one ledge
3. Bailey slows after a readable spin, exposing the punish window

**Intended counterplay:** Use Bacon Gun control hits as the tornado slows; dodge across alternating elevated platforms.

## Equipment and rewards

**Loadout and power-ups:** Brunch Fork; Bacon Gun; Extra Bacon defense; Grease Slide.

**Completion reward:** Bacon-case completion stamp and configured bacon-themed equipment unlock.

## Investigation and evidence

**Case evidence:** Bacon strips; oversized stack and grease trail; stolen bacon at the chase exit. The hub must offer an identity clue and a means/opportunity clue. A chase corroboration pickup should reinforce the accusation without retroactively changing whether the accusation was justified.

## Graybox and playtest requirements

**First tutorial beat:** Teach the grease pit on safe ground, then a sausage rope over a recoverable gap.

**Primary readability risk:** Punishing a mistimed rope release with unavoidable grease damage.

**Acceptance:** complete the four-section course without an unavoidable hit; demonstrate one readable mechanic tutorial, one optional route, one working checkpoint, one evidence pickup, one unique enemy interaction and the authored boss counter. Test reduced flashing and controller navigation at every interaction.

**Implementation:** instantiate generic components from the reusable level kit, configure them with resources, and route case/boss/evidence events through application services. Do not place direct UI node paths in level machinery.
