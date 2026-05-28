# BP2 Level Elements Catalog

This file regroups level/environment content only. It focuses on platforms, hazards, interactions, traversal systems, background details, ambiance, and reusable environmental objects.

---

## Shared Level Element Categories

Use these categories to tag level elements in implementation:

- `platform`
- `moving_platform`
- `collapsing_platform`
- `slippery_surface`
- `sticky_surface`
- `hazard`
- `soft_hazard`
- `launcher`
- `rope`
- `switch`
- `destructible`
- `background_prop`
- `foreground_fx`
- `ambience_audio`
- `boss_arena_element`
- `evidence_prop`
- `inclusive_detail`

---

## Reusable Platform Elements

### Static Themed Platform

- **Element Type:** Platform.
- **Behavior:** Stable ground made from level-specific material.
- **Use:** Baseline traversal and combat footing.
- **Examples:** Bacon ledge, cake tier, countertop, chocolate bar, egg-carton ledge, citrus wedge, bread shelf.
- **Implementation Notes:** Should share collision and grounding logic across levels.

### Wiggling Platform

- **Element Type:** Animated platform.
- **Behavior:** Shakes, bends, drips, wobbles, or deforms before recovering.
- **Use:** Adds tension without necessarily removing footing.
- **Examples:** Bacon strips, dough platforms, pancake stacks.
- **Implementation Notes:** Needs readable animation before state change.

### Collapsing Platform

- **Element Type:** Temporary platform.
- **Behavior:** Breaks or sinks after the player stands on it briefly.
- **Use:** Forces commitment and forward movement.
- **Examples:** Brittle pastry floors, cracked eggshell platforms, sinking pancakes, collapsing dough.
- **Implementation Notes:** Use warning state before collapse.

### Moving Platform

- **Element Type:** Moving platform.
- **Behavior:** Moves horizontally, vertically, diagonally, or on a loop.
- **Use:** Timing and route construction.
- **Examples:** Hot pan lifts, cake lifts, frying-pan lifts, citrus wedge lifts, conveyor trays.
- **Implementation Notes:** Use path nodes or spline movement.

### Conveyor Platform

- **Element Type:** Moving surface.
- **Behavior:** Pushes the player and objects in one direction.
- **Use:** Factory and kitchen traversal pressure.
- **Examples:** Egg Factory belts, Bakery conveyor trays, citrus processing belts.
- **Implementation Notes:** Should affect enemies and physics objects consistently.

### Slippery Surface

- **Element Type:** Surface modifier.
- **Behavior:** Reduces traction and braking.
- **Use:** Movement challenge.
- **Examples:** Grease, juice streams, yolk spills, dishwater.
- **Implementation Notes:** Use friction override or player movement modifier.

### Sticky Surface

- **Element Type:** Surface modifier.
- **Behavior:** Slows movement and jump recovery.
- **Use:** Soft hazard and vulnerability setup.
- **Examples:** Syrup puddles, frosting, caramel, pulp, dough traps.
- **Implementation Notes:** Should apply status duration and show clear visual residue.

### Bounce Platform

- **Element Type:** Launcher platform.
- **Behavior:** Launches player upward or forward.
- **Use:** Vertical traversal, secrets, platforming rhythm.
- **Examples:** Pancakes, gumdrops, sponge cake pads, bread loaves.
- **Implementation Notes:** Needs predictable launch vector.

### Swing Rope

- **Element Type:** Climb / swing interaction.
- **Behavior:** Player can climb or swing across gaps.
- **Use:** Vertical traversal and alternate routes.
- **Examples:** Sausage links, licorice ropes, hanging utensils, dough strands.
- **Implementation Notes:** Can share rope interaction logic across all reskins.

---

## Reusable Hazard Elements

### Hot Liquid Pit

- **Element Type:** Damage hazard.
- **Behavior:** Damages or resets player on contact.
- **Use:** Bottomless-pit replacement with thematic identity.
- **Examples:** Boiling grease, chocolate lava, citrus acid, hot syrup.
- **Implementation Notes:** Requires strong visual warning and safe ledge spacing.

### Periodic Splash

- **Element Type:** Timed hazard.
- **Behavior:** Emits arcs or bursts on a fixed cycle.
- **Use:** Timing challenge.
- **Examples:** Grease splashes, syrup drips, juice sprays, yolk bursts.
- **Implementation Notes:** Telegraph before active hitbox.

### Crusher / Slammer

- **Element Type:** Timed damage hazard.
- **Behavior:** Slams down or closes on the player.
- **Use:** Timing gates and factory pressure.
- **Examples:** Frying pans, presses, oven doors, juicer press, mixer blades.
- **Implementation Notes:** Needs anticipation frame and recovery frame.

### Rolling Hazard

- **Element Type:** Moving hazard.
- **Behavior:** Rolls across platforms or down slopes.
- **Use:** Lane denial and jump timing.
- **Examples:** Baguettes, orange peels, muffin trays, candy balls.
- **Implementation Notes:** May be enemy or pure hazard depending on scene setup.

### Visibility Cloud

- **Element Type:** Soft hazard.
- **Behavior:** Obscures player view, enemies, platforms, or pickups.
- **Use:** Adds uncertainty without direct damage.
- **Examples:** Flour clouds, steam, syrup mist, smoke.
- **Implementation Notes:** Should not fully hide lethal hazards without telegraph.

### Pushback Jet

- **Element Type:** Movement hazard.
- **Behavior:** Pushes player in a direction.
- **Use:** Positioning challenge.
- **Examples:** Juice jets, steam vents, dishwasher spray.
- **Implementation Notes:** Force vector should be visible and consistent.

### Explosive Food

- **Element Type:** Area damage hazard.
- **Behavior:** Detonates after contact, timer, or trigger.
- **Use:** Space denial and enemy pressure.
- **Examples:** Jelly-filled donuts, cupcake bombs, explosive muffins, candy bombs.
- **Implementation Notes:** Clear fuse animation required.

---

## Grease Canyon Level Elements

### Sizzling Bacon Strip Platform

- **Element Type:** Platform.
- **Behavior:** Stable or slightly wiggling platform made of bacon.
- **Use:** Main traversal surface.
- **Details:** Animated in warm reds and browns with fat shimmer.
- **Implementation Notes:** Can use idle wiggle animation to communicate heat.

### Bacon Wiggle Platform

- **Element Type:** Animated platform.
- **Behavior:** Slightly shakes or bends under the player.
- **Use:** Timing readability and thematic movement.
- **Details:** Should not collapse unless marked as separate hazard variant.
- **Implementation Notes:** Use deformation animation only; collision remains stable unless variant is created.

### Fat Drip Edge

- **Element Type:** Foreground / surface detail.
- **Behavior:** Fat drips from platform edges.
- **Use:** Visual ambiance and hazard readability.
- **Details:** Looping pixel shimmer.
- **Implementation Notes:** Non-colliding visual effect unless upgraded to drip hazard.

### Boiling Grease Pit

- **Element Type:** Damage hazard.
- **Behavior:** Damages or resets player on contact.
- **Use:** Gap and floor danger.
- **Details:** Golden-yellow bubbling animation.
- **Implementation Notes:** Add bubbling cycle and occasional splash telegraph.

### Grease Splash

- **Element Type:** Timed hazard.
- **Behavior:** Hot grease arcs upward from pit.
- **Use:** Timing challenge above pits.
- **Details:** Works best in predictable intervals.
- **Implementation Notes:** Separate warning bubble from active hitbox.

### Dripping Grease

- **Element Type:** Timed ceiling hazard.
- **Behavior:** Falls from ceilings or ledges.
- **Use:** Forces movement timing.
- **Details:** Can mark dangerous overhead spaces.
- **Implementation Notes:** Small impact splash optional.

### Sausage-Link Rope

- **Element Type:** Rope / climb interaction.
- **Behavior:** Player climbs or swings on linked sausages.
- **Use:** Vertical traversal and gap crossing.
- **Details:** Sways slightly, attached to bacon ceilings.
- **Implementation Notes:** Can host Bacon Worm enemies.

### Sizzling Griddle

- **Element Type:** Hazard-adjacent platform.
- **Behavior:** Hot surface; may be safe, damaging, or timed depending on variant.
- **Use:** Arena staging and thermal identity.
- **Details:** Appears in background and playable areas.
- **Implementation Notes:** Use glow or steam to distinguish damaging griddles.

### Giant Cracked Egg Sky Prop

- **Element Type:** Background prop.
- **Behavior:** Non-interactive.
- **Use:** Surreal brunch skyline.
- **Details:** Floating cracked eggs in sky.
- **Implementation Notes:** Parallax layer candidate.

### Bacon Grease Blob Cloud

- **Element Type:** Background prop.
- **Behavior:** Non-interactive cloud silhouette.
- **Use:** Thematic sky treatment.
- **Details:** Pixel clouds shaped like bacon grease blobs.
- **Implementation Notes:** Slow parallax.

### Bacon Comet

- **Element Type:** Parallax object.
- **Behavior:** Zips by in background.
- **Use:** Motion and comedy.
- **Details:** Bacon-shaped streak object.
- **Implementation Notes:** Randomized background loop.

### Bacon Spiral Column

- **Element Type:** Boss arena element.
- **Behavior:** Decorative or blocking arena column.
- **Use:** Bacon Bandit fight silhouette.
- **Details:** Can frame the arena or serve as obstacle.
- **Implementation Notes:** Keep out of core movement path unless readable.

### Bacon Tornado FX Loop

- **Element Type:** Boss hazard / visual effect.
- **Behavior:** Spinning bacon cyclone.
- **Use:** Main Bacon Bandit attack.
- **Details:** Emits flying bacon debris.
- **Implementation Notes:** Active hitbox should match visible tornado bounds.

### Hanging Bacon Strip Hazard

- **Element Type:** Swinging hazard.
- **Behavior:** Hangs or swings from ceiling.
- **Use:** Obstacle near vertical movement.
- **Details:** Seen in visual references.
- **Implementation Notes:** Use slow swing and clear damage edge if harmful.

### Rainbow-Tinted Bacon Flag

- **Element Type:** Inclusive detail / background prop.
- **Behavior:** Non-interactive.
- **Use:** Environmental inclusivity detail.
- **Details:** Pride-colored bacon flag.
- **Implementation Notes:** Keep as natural set dressing.

### Grease Canyon Ambiance

- **Element Type:** Audio / visual ambiance.
- **Details:** Sizzling grease, bacon crackle, bubbling pits, distant pig snorts, orange heat haze, smoke plumes.
- **Implementation Notes:** Use low-frequency bubbling bed plus short hot-oil pops.

---

## Pastry Palace Level Elements

### Croissant Platform

- **Element Type:** Platform.
- **Behavior:** Curved pastry platform.
- **Use:** Main traversal surface.
- **Details:** Croissant shapes support elegant silhouette language.
- **Implementation Notes:** Collision should remain simple despite curved art.

### Donut Platform

- **Element Type:** Platform.
- **Behavior:** Circular platform, sometimes with center gap.
- **Use:** Jump timing and visual variety.
- **Details:** Can be static, moving, or rotating.
- **Implementation Notes:** Use clear collision ring if center hole matters.

### Rotating Mixer Arm

- **Element Type:** Moving platform / hazard.
- **Behavior:** Rotates around a central mixer.
- **Use:** Timing-based traversal.
- **Details:** Core Pastry Palace mechanical identity.
- **Implementation Notes:** Can be safe platform on top and damaging at edges.

### Giant Mixing Bowl

- **Element Type:** Background / foreground prop.
- **Behavior:** Non-interactive or arena base.
- **Use:** Establishes bakery machinery scale.
- **Details:** Can frame platform routes.
- **Implementation Notes:** Parallax or collision variant.

### Sticky Frosting Surface

- **Element Type:** Sticky surface.
- **Behavior:** Slows player movement.
- **Use:** Soft hazard.
- **Details:** Used with Croissant Crook ground obstruction.
- **Implementation Notes:** Syrup Boots can negate or reduce effect.

### Brittle Pastry Floor

- **Element Type:** Collapsing platform.
- **Behavior:** Cracks then breaks after brief contact.
- **Use:** Route timing.
- **Details:** Crumb particles signal damage.
- **Implementation Notes:** Warning crack state before collapse.

### Falling Pastry

- **Element Type:** Falling hazard.
- **Behavior:** Drops from shelves or overhead.
- **Use:** Timed obstacle.
- **Details:** Can be croissants, bread, donuts, or cake chunks.
- **Implementation Notes:** Use falling crumbs as pre-telegraph.

### Cream Jet

- **Element Type:** Timed projectile hazard.
- **Behavior:** Shoots whipped cream.
- **Use:** Lane denial.
- **Details:** Could come from machines or Flying Éclairs.
- **Implementation Notes:** Hit may slow or blind instead of dealing high damage.

### Pastry Shelf

- **Element Type:** Background prop / platform.
- **Behavior:** Holds pastries, collectibles, or falling hazards.
- **Use:** Environmental storytelling and staging.
- **Details:** Stolen pastry displays and crumb trails.
- **Implementation Notes:** Some shelves can be breakable.

### Crumb Trail

- **Element Type:** Storytelling prop.
- **Behavior:** Non-interactive clue path.
- **Use:** Leads player toward culprit or secret.
- **Details:** Supports Croissant Crook theft theme.
- **Implementation Notes:** Can double as investigation clue.

### Powdered Sugar Particle

- **Element Type:** Foreground FX.
- **Behavior:** Soft drifting particles.
- **Use:** Ambiance.
- **Details:** Adds palace/bakery atmosphere.
- **Implementation Notes:** Keep opacity low for readability.

### Pastry Palace Ambiance

- **Element Type:** Audio / visual ambiance.
- **Details:** Mixer whirring, soft bakery bells, pastry puffs, frosting splats, warm golden lighting.
- **Implementation Notes:** Avoid overusing sparkles near hazards.

---

## Sticky Syrup Swamp Level Elements

### Pancake Raft

- **Element Type:** Moving platform.
- **Behavior:** Floats across syrup pools.
- **Use:** Core traversal over dangerous liquid.
- **Details:** Can bob and drift.
- **Implementation Notes:** Needs stable ride behavior with moving-platform parenting.

### Syrup-Coated Log

- **Element Type:** Sticky platform.
- **Behavior:** Slows player when crossed.
- **Use:** Soft challenge.
- **Details:** Swampy breakfast equivalent of log platforms.
- **Implementation Notes:** Apply sticky status only while grounded.

### Pancake Stack

- **Element Type:** Vertical platform cluster.
- **Behavior:** Static or slightly compressing.
- **Use:** Climbing routes.
- **Details:** Can hide pickups or evidence.
- **Implementation Notes:** Use simple rectangular collision per pancake.

### Buttered Pancake Bounce Pad

- **Element Type:** Bounce platform.
- **Behavior:** Launches player.
- **Use:** Vertical traversal.
- **Details:** Butter visual marks bounce zone.
- **Implementation Notes:** Consistent launch force.

### Sinking Pancake

- **Element Type:** Collapsing / sinking platform.
- **Behavior:** Sinks after sustained contact.
- **Use:** Forces quick movement.
- **Details:** Works over syrup pools.
- **Implementation Notes:** Reset after leaving screen or on timer.

### Deep Syrup Pool

- **Element Type:** Damage or reset hazard.
- **Behavior:** Punishes falling into swamp liquid.
- **Use:** Floor hazard.
- **Details:** Thick amber syrup surface.
- **Implementation Notes:** Decide if damage, instant reset, or slow escape.

### Syrup Puddle

- **Element Type:** Sticky surface.
- **Behavior:** Slows player.
- **Use:** Soft hazard before enemy attacks.
- **Details:** Can be created by boss or environmental drip.
- **Implementation Notes:** Shared with syrup weapons.

### Dripping Syrup

- **Element Type:** Timed hazard.
- **Behavior:** Falls from above.
- **Use:** Timing and pressure.
- **Details:** Can form temporary puddles.
- **Implementation Notes:** Separate falling hitbox and puddle effect.

### Syrup Valve

- **Element Type:** Switch / interaction.
- **Behavior:** Redirects syrup flow.
- **Use:** Opens paths or changes raft movement.
- **Details:** Core interaction hook.
- **Implementation Notes:** Connect to pipe/flow manager.

### Syrup Waterfall

- **Element Type:** Background / hazard candidate.
- **Behavior:** Flows downward.
- **Use:** Ambiance or path blocker.
- **Details:** Seen in swamp overview.
- **Implementation Notes:** Can be visual-only unless marked hazardous.

### Amber Mist

- **Element Type:** Foreground FX.
- **Behavior:** Ambient haze.
- **Use:** Mood.
- **Details:** Sticky swamp atmosphere.
- **Implementation Notes:** Keep transparent for platform readability.

### Sticky Syrup Swamp Ambiance

- **Element Type:** Audio / visual ambiance.
- **Details:** Syrup dripping, swamp bubbles, bees buzzing, raft creaks, amber haze.
- **Implementation Notes:** Slow, thick sound design reinforces movement slowdown.

---

## Kitchen Mayhem Level Elements

### Countertop Platform

- **Element Type:** Platform.
- **Behavior:** Wide stable platform.
- **Use:** Main traversal and combat footing.
- **Details:** Commercial kitchen surface.
- **Implementation Notes:** Good base for enemy staging.

### Cutting Board Platform

- **Element Type:** Platform.
- **Behavior:** Static or sliding.
- **Use:** Medium-sized combat/traversal surface.
- **Details:** Can host knife hazards.
- **Implementation Notes:** Sliding variant should telegraph direction.

### Pot Lid Platform

- **Element Type:** Tilting / moving platform.
- **Behavior:** Tilts, spins, or moves.
- **Use:** Timing challenge.
- **Details:** Circular metal platform.
- **Implementation Notes:** Could double as shield pickup visual language.

### Dish Rack Climb

- **Element Type:** Climb structure.
- **Behavior:** Vertical or ladder-like traversal.
- **Use:** Height changes.
- **Details:** Narrow shelves and metal rack lines.
- **Implementation Notes:** Keep collision clean.

### Swinging Utensil

- **Element Type:** Swing platform / hazard.
- **Behavior:** Hanging spoon, spatula, or ladle swings.
- **Use:** Gap crossing or obstacle.
- **Details:** Can be safe handle or damaging edge.
- **Implementation Notes:** Communicate safe contact area clearly.

### Kitchen Cart

- **Element Type:** Pushable platform / moving cover.
- **Behavior:** Can be pushed or rides along floor.
- **Use:** Creates temporary platform or shield.
- **Details:** Player-controlled positioning.
- **Implementation Notes:** Use physics or scripted movement; avoid jank.

### Chopping Knife

- **Element Type:** Timed damage hazard.
- **Behavior:** Moves up and down.
- **Use:** Timing gate.
- **Details:** Sharp vertical kitchen hazard.
- **Implementation Notes:** Clear windup and impact.

### Steam Vent

- **Element Type:** Soft hazard / pushback.
- **Behavior:** Hisses steam on timer.
- **Use:** Visibility block or push force.
- **Details:** Can be redirected.
- **Implementation Notes:** Use opacity carefully.

### Falling Pan

- **Element Type:** Falling hazard.
- **Behavior:** Drops after warning.
- **Use:** Area denial.
- **Details:** Clanging pre-sound.
- **Implementation Notes:** Add shadow or shake telegraph.

### Burner Flame

- **Element Type:** Timed damage hazard.
- **Behavior:** Turns on and off.
- **Use:** Timing path.
- **Details:** Stove orange flame.
- **Implementation Notes:** Safe/off state must be obvious.

### Rolling Can

- **Element Type:** Rolling hazard.
- **Behavior:** Rolls across counters.
- **Use:** Lane obstacle.
- **Details:** Kitchen clutter hazard.
- **Implementation Notes:** Can be spawned from shelves.

### Dishwater Spill

- **Element Type:** Slippery surface.
- **Behavior:** Reduces traction.
- **Use:** Movement challenge.
- **Details:** Works with sponge enemies.
- **Implementation Notes:** Use reflection/highlight to mark surface.

### Dish Pile Cover

- **Element Type:** Destructible cover.
- **Behavior:** Blocks attacks or hides boss.
- **Use:** Cutlery Thief boss counterplay.
- **Details:** Player clears dishes to expose boss.
- **Implementation Notes:** Health-based destructible object.

### Kitchen Mayhem Ambiance

- **Element Type:** Audio / visual ambiance.
- **Details:** Clanging pans, chopping sounds, steam hisses, dish crashes, stainless steel shine.
- **Implementation Notes:** Use sharp transient sounds sparingly during combat.

---

## Candy Chaos Level Elements

### Gumdrop Platform

- **Element Type:** Bounce platform.
- **Behavior:** Launches player when landed on.
- **Use:** Core vertical traversal.
- **Details:** Bright candy bounce surface.
- **Implementation Notes:** Consistent bounce strength, optional charged bounce variant.

### Candy Bridge

- **Element Type:** Platform.
- **Behavior:** Static or brittle.
- **Use:** Main path or collapse challenge.
- **Details:** Candy cane, hard candy, or sugar-glass construction.
- **Implementation Notes:** Brittle variant needs crack telegraph.

### Chocolate Bar Platform

- **Element Type:** Platform.
- **Behavior:** Rectangular, possibly slippery.
- **Use:** Modular candy geometry.
- **Details:** Good for gridlike platforming.
- **Implementation Notes:** Simple collision.

### Licorice Rope

- **Element Type:** Rope / swing interaction.
- **Behavior:** Player climbs or swings.
- **Use:** Vertical movement.
- **Details:** Candy version of rope traversal.
- **Implementation Notes:** Reuse rope system.

### Cake Layer Platform

- **Element Type:** Wide platform.
- **Behavior:** Stable soft footing.
- **Use:** Combat arena and staging.
- **Details:** Multi-tier dessert structure.
- **Implementation Notes:** Can compress visually without affecting collision.

### Hard Candy Disc

- **Element Type:** Rotating platform.
- **Behavior:** Spins or rotates on pivot.
- **Use:** Timing challenge.
- **Details:** Glossy hard candy.
- **Implementation Notes:** Consider platform velocity transfer.

### Chocolate Lava

- **Element Type:** Damage hazard.
- **Behavior:** Dangerous liquid floor.
- **Use:** Floor hazard.
- **Details:** Bubbling chocolate.
- **Implementation Notes:** Differentiate from safe chocolate bars.

### Brittle Candy Glass

- **Element Type:** Breakable platform / damage hazard.
- **Behavior:** Shatters into dangerous pieces.
- **Use:** Route gating and hazard creation.
- **Details:** Sugar-glass cracks.
- **Implementation Notes:** Shard hitboxes should be limited and readable.

### Candy Ball Roller

- **Element Type:** Rolling hazard.
- **Behavior:** Rolls across platforms or down slopes.
- **Use:** Lane control.
- **Details:** Bright candy sphere.
- **Implementation Notes:** Can be enemy-spawned or environmental.

### Sticky Caramel Pool

- **Element Type:** Sticky surface.
- **Behavior:** Slows movement.
- **Use:** Soft hazard.
- **Details:** Candy equivalent of syrup.
- **Implementation Notes:** Shared sticky system.

### Sugar Spike

- **Element Type:** Damage hazard.
- **Behavior:** Static sharp obstacle.
- **Use:** Precision movement.
- **Details:** Sharp candy formations.
- **Implementation Notes:** High contrast against floor.

### Pop Candy Burst

- **Element Type:** Timed explosive hazard.
- **Behavior:** Small popping explosions.
- **Use:** Area denial.
- **Details:** Short warning sparkle before pop.
- **Implementation Notes:** Use predictable burst interval.

### Sprinkler Switch

- **Element Type:** Boss arena switch.
- **Behavior:** Activates sprinklers that wash cake away.
- **Use:** Dessert Hoarder boss counterplay.
- **Details:** Player jumps on switches.
- **Implementation Notes:** Link to boss vehicle health/state.

### Candy Chaos Ambiance

- **Element Type:** Audio / visual ambiance.
- **Details:** Candy pops, chocolate bubbling, wrapper crinkles, gumdrop boings, sugar sparkles.
- **Implementation Notes:** Bright palette; avoid losing projectile readability.

---

## Egg Factory Frenzy Level Elements

### Conveyor Belt

- **Element Type:** Conveyor platform.
- **Behavior:** Moves player and objects.
- **Use:** Core traversal pressure.
- **Details:** Industrial egg factory belt.
- **Implementation Notes:** Allow reversible conveyors.

### Cracked Eggshell Platform

- **Element Type:** Collapsing platform.
- **Behavior:** Breaks after brief contact.
- **Use:** Commitment challenge.
- **Details:** Eggshell crack visuals.
- **Implementation Notes:** Warning crack state.

### Frying-Pan Lift

- **Element Type:** Moving platform.
- **Behavior:** Rises, tilts, or carries player.
- **Use:** Vertical traversal.
- **Details:** Themed around pan mechanics.
- **Implementation Notes:** Separate from Frying Pan enemy/hazard.

### Egg-Carton Ledge

- **Element Type:** Static platform.
- **Behavior:** Stable modular platform.
- **Use:** Main traversal.
- **Details:** Grid-like carton silhouette.
- **Implementation Notes:** Simple tileable platform art.

### Sorting Tray

- **Element Type:** Rideable platform.
- **Behavior:** Moves on rails.
- **Use:** Factory route movement.
- **Details:** Carries eggs or player.
- **Implementation Notes:** Rail/path system.

### Egg Chute

- **Element Type:** Spawner / pipe.
- **Behavior:** Releases eggs, enemies, or hazards.
- **Use:** Dynamic factory movement.
- **Details:** Can redirect with switches.
- **Implementation Notes:** Connect to spawn manager.

### Crushing Press

- **Element Type:** Crusher hazard.
- **Behavior:** Slams down on timer.
- **Use:** Timing gate.
- **Details:** Factory machinery.
- **Implementation Notes:** Strong warning lights.

### Yolk Spill

- **Element Type:** Slippery surface.
- **Behavior:** Reduces traction.
- **Use:** Movement challenge.
- **Details:** Yellow puddle.
- **Implementation Notes:** Can be created by drones.

### Egg Bomb

- **Element Type:** Explosive hazard.
- **Behavior:** Bursts after delay.
- **Use:** Area denial.
- **Details:** Dropped by drones or chutes.
- **Implementation Notes:** Fuse animation.

### Shell Shards

- **Element Type:** Damage hazard.
- **Behavior:** Sharp debris on floor/wall.
- **Use:** Punishes careless movement.
- **Details:** Broken shell pieces.
- **Implementation Notes:** Keep small but visible.

### Reversible Conveyor Switch

- **Element Type:** Switch.
- **Behavior:** Changes belt direction.
- **Use:** Route puzzle and boss counterplay.
- **Details:** Industrial lever/button.
- **Implementation Notes:** Affect belts and objects.

### Egg Factory Ambiance

- **Element Type:** Audio / visual ambiance.
- **Details:** Conveyor motors, egg cracks, chicken clucks, machine alarms, yellow warning lights.
- **Implementation Notes:** Use rhythmic machine loops.

---

## Citrus Cascade Level Elements

### Orange-Slice Platform

- **Element Type:** Platform.
- **Behavior:** Static curved platform.
- **Use:** Main traversal.
- **Details:** Orange slice with citrus segments.
- **Implementation Notes:** Simplified collision.

### Citrus Wedge Lift

- **Element Type:** Moving platform.
- **Behavior:** Moves vertically or diagonally.
- **Use:** Traversal lift.
- **Details:** Triangular citrus wedge.
- **Implementation Notes:** Can move along juice-powered route.

### Juice-Pipe Platform

- **Element Type:** Narrow platform.
- **Behavior:** Stable pipe walkway.
- **Use:** Precision traversal.
- **Details:** Industrial citrus processing pipe.
- **Implementation Notes:** Good for enemy turret placement.

### Floating Peel Platform

- **Element Type:** Moving platform.
- **Behavior:** Drifts on juice.
- **Use:** Moving traversal.
- **Details:** Citrus peel raft.
- **Implementation Notes:** Similar to pancake raft.

### Pulp Mat

- **Element Type:** Sticky surface.
- **Behavior:** Slows player movement.
- **Use:** Soft hazard.
- **Details:** Sticky citrus pulp.
- **Implementation Notes:** Shared sticky system.

### Juice Fountain Launcher

- **Element Type:** Launcher.
- **Behavior:** Launches player upward or forward.
- **Use:** Core verticality tool.
- **Details:** Soda fountain spraying juice.
- **Implementation Notes:** Clearly show launch direction.

### Orange Juice Stream

- **Element Type:** Slippery surface / push hazard.
- **Behavior:** Pushes or slicks movement.
- **Use:** Momentum traversal and hazard.
- **Details:** Flowing orange juice.
- **Implementation Notes:** Direction arrows or foam can communicate flow.

### Juice Jet

- **Element Type:** Pushback hazard.
- **Behavior:** Shoots player backward or into hazards.
- **Use:** Timing and positioning.
- **Details:** From machines or boss.
- **Implementation Notes:** Telegraph with nozzle shake.

### Citrus Acid Pool

- **Element Type:** Damage hazard.
- **Behavior:** Damages on contact.
- **Use:** Dangerous liquid zone.
- **Details:** Stronger version of juice pool.
- **Implementation Notes:** Visual distinction from safe juice required.

### Rolling Orange Peel

- **Element Type:** Rolling hazard.
- **Behavior:** Rolls across platforms.
- **Use:** Ground-lane obstacle.
- **Details:** Peel trap.
- **Implementation Notes:** Can spawn from background juicers.

### Juicer Blade

- **Element Type:** Rotating damage hazard.
- **Behavior:** Spins in place.
- **Use:** Timing and obstacle.
- **Details:** Industrial juicer machinery.
- **Implementation Notes:** Active radius must be clear.

### Citrus Pipe Valve

- **Element Type:** Switch.
- **Behavior:** Redirects citrus pipe flow.
- **Use:** Opens paths or changes hazard direction.
- **Details:** Main interaction hook.
- **Implementation Notes:** Connect to juice flow system.

### Citrus Cascade Ambiance

- **Element Type:** Audio / visual ambiance.
- **Details:** Juice splashes, citrus squirts, fountain sprays, juicer grinding, citrus mist.
- **Implementation Notes:** Bright and wet, with readable hazard contrast.

---

## Bakery Bonanza Level Elements

### Giant Oven

- **Element Type:** Background prop / hazard source.
- **Behavior:** Emits heat, flames, or light.
- **Use:** Establishes bakery production space.
- **Details:** Huge glowing oven interiors.
- **Implementation Notes:** Can spawn timed flame hazards.

### Conveyor Tray

- **Element Type:** Moving platform.
- **Behavior:** Carries player or objects.
- **Use:** Bakery route movement.
- **Details:** Tray on conveyor belt.
- **Implementation Notes:** Shared conveyor logic.

### Rising Dough Platform

- **Element Type:** Moving / expanding platform.
- **Behavior:** Rises, expands, then possibly collapses.
- **Use:** Core vertical traversal gimmick.
- **Details:** Expanding dough mass.
- **Implementation Notes:** Needs readable inflate/deflate cycle.

### Collapsing Dough Platform

- **Element Type:** Temporary platform.
- **Behavior:** Expands, softens, collapses.
- **Use:** Timed movement challenge.
- **Details:** Related to rising dough system.
- **Implementation Notes:** Warning sag animation.

### Flour Cloud

- **Element Type:** Visibility soft hazard.
- **Behavior:** Obscures view.
- **Use:** Platform and enemy readability challenge.
- **Details:** Can be ambient or enemy-created.
- **Implementation Notes:** Avoid hiding instant-kill hazards.

### Muffin Conveyor

- **Element Type:** Background / platforming machinery.
- **Behavior:** Moves muffins or trays.
- **Use:** Visual storytelling and moving hazards.
- **Details:** Bakery production line.
- **Implementation Notes:** Can spawn rolling muffin trays.

### Oven Tower

- **Element Type:** Background / platform structure.
- **Behavior:** Large vertical oven structure.
- **Use:** Establishes verticality.
- **Details:** Can include stairs and ledges.
- **Implementation Notes:** Use warm glow to guide player.

### Metal Stairs

- **Element Type:** Platform structure.
- **Behavior:** Static stairs.
- **Use:** Connects factory/bakery heights.
- **Details:** Industrial bakery supports.
- **Implementation Notes:** Simple collision.

### Flour Puff

- **Element Type:** Foreground FX / soft hazard.
- **Behavior:** Brief puff on contact or trigger.
- **Use:** Visibility interruption.
- **Details:** Can appear from flour sacks or enemies.
- **Implementation Notes:** May share effect with Flour Puff weapon.

### Giant Bread Loaf

- **Element Type:** Platform / prop.
- **Behavior:** Static or slightly bouncy.
- **Use:** Themed platforming surface.
- **Details:** Large bread shapes.
- **Implementation Notes:** Optional bounce variant.

### Bakery Pipe

- **Element Type:** Background prop / platform support.
- **Behavior:** Structural.
- **Use:** Factory depth.
- **Details:** Pipes and supports around ovens.
- **Implementation Notes:** Can emit steam or flour.

### Hot Oven Flame

- **Element Type:** Timed damage hazard.
- **Behavior:** Activates in bursts.
- **Use:** Heat timing challenge.
- **Details:** Orange flame from oven doors.
- **Implementation Notes:** Oven Mitts can protect player.

### Falling Baking Tray

- **Element Type:** Falling hazard.
- **Behavior:** Drops after warning rattle.
- **Use:** Area denial.
- **Details:** Metal tray sound cue.
- **Implementation Notes:** Shadow warning.

### Rolling Muffin Tray

- **Element Type:** Moving hazard.
- **Behavior:** Rolls across platforms.
- **Use:** Lane pressure.
- **Details:** Also listed as enemy-like hazard.
- **Implementation Notes:** Can be spawned by machinery.

### Baking Tray Cover

- **Element Type:** Destructible cover.
- **Behavior:** Blocks access to boss.
- **Use:** Muffin Mastermind counterplay.
- **Details:** Clear trays to expose boss.
- **Implementation Notes:** Health-based destructible cover.

### Oven Mitt Protection Zone / Pickup

- **Element Type:** Power-up interaction.
- **Behavior:** Protects against hot hazards.
- **Use:** Allows passage through hot areas.
- **Details:** Related to Oven Mitts power-up.
- **Implementation Notes:** Time-limited or hit-limited protection.

### Bakery Bonanza Ambiance

- **Element Type:** Audio / visual ambiance.
- **Details:** Oven hums, dough rising, flour puffs, tray rattles, warm bread tones, oven glow.
- **Implementation Notes:** Use warm lighting but keep hazards high contrast.

---

## Cross-Level Reuse Map

| System | Grease Canyon | Pastry Palace | Syrup Swamp | Kitchen | Candy | Egg Factory | Citrus | Bakery |
|---|---|---|---|---|---|---|---|---|
| Slippery surface | Grease | Butter/frosting variant | Syrup edge variant | Dishwater | Chocolate variant | Yolk | Juice | Flour/dough variant |
| Sticky surface | Grease residue | Frosting | Syrup | Sauce | Caramel | Yolk | Pulp | Dough |
| Rope/swing | Sausage links | Dough/utensil variant | Syrup vines | Utensils | Licorice | Cables | Vines/pipes | Dough strands |
| Launcher | Grease burst candidate | Cake bounce | Pancake bounce | Steam vent | Gumdrop | Pan lift | Juice fountain | Rising dough |
| Rolling hazard | Bacon debris | Baguette | Syrup barrel candidate | Rolling can | Candy ball | Egg/gear | Orange peel | Muffin tray |
| Visibility blocker | Smoke | Sugar dust | Amber mist | Steam | Sugar sparkle cloud | Steam/yolk splash | Citrus mist | Flour cloud |
| Crusher | Bacon press candidate | Mixer | Syrup press candidate | Chopping knife | Candy press candidate | Crushing press | Juicer blade | Oven door |
