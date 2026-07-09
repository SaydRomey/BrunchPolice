# Brunch Police Level Asset Production List

This is a consolidated level-by-level asset list for planning tiles, collectibles, objects, hazards, FX, backgrounds, music, and implementation needs.

Each asset includes category, function/specs, animation or FX needs, and concise visual direction.

---

## Global Asset Rules

- **Shared Tile Needs**  
  **Category:** Core tileset structure.  
  **Specs:** Each level should have terrain top tiles, side tiles, underside tiles, corners, slopes if needed, breakable variants, hazard-edged variants, and transition tiles between safe ground and hazard zones.  
  **Animation / FX:** Optional idle shimmer, bounce, drip, steam, sparkle, or machinery loops depending on level.  
  **Visual Direction:** Large readable shapes, chunky pixel outlines, clear safe-versus-danger contrast, high silhouette readability.

- **Shared Collectible Shell**  
  **Category:** Pickup / collectible framework.  
  **Specs:** Needed for evidence, optional score pickups, health pickups, level power-ups, and temporary weapon pickups.  
  **Animation / FX:** Idle bob, small sparkle, pickup burst, icon flash.  
  **Visual Direction:** Badge-like food objects with bold outline and bright highlight.

- **Shared Hazard Warning FX**  
  **Category:** Readability / telegraph FX.  
  **Specs:** Used before falling objects, bursts, slams, explosions, sprays, and moving hazards.  
  **Animation / FX:** Flashing outline, shake frame, warning shadow, exclamation pop, impact ring.  
  **Visual Direction:** Simple high-contrast warning frames that work in pixel art without clutter.

- **Shared Background Structure**  
  **Category:** Parallax / atmosphere.  
  **Specs:** Far background, midground, near background, foreground particles.  
  **Animation / FX:** Slow parallax drift, subtle looped particles, environmental motion.  
  **Visual Direction:** Softer contrast than gameplay objects so enemies, hazards, and platforms remain readable.


---

# Grease Canyon Assets

Grease Canyon’s source feel is hot, greasy, slippery, smoky, and sizzling, with bacon platforms, grease pits, sausage ropes, fat clouds, bacon comets, and a Bacon Tornado boss arena.

- **Sizzling Bacon Platform Tiles**  
  **Category:** Main terrain / platform tiles.  
  **Specs:** Primary walkable surface; should support straight tiles, corners, edges, underside, broken ends, and short/long strips.  
  **Animation / FX:** Slight wiggle loop, heat shimmer, tiny grease glints.  
  **Visual Direction:** Crispy red-brown bacon strips with golden fat bands, glossy highlights, dark fried edges, readable horizontal ledge shape.

- **Hot Bacon Hazard Tiles**  
  **Category:** Damage terrain variant.  
  **Specs:** Same base form as bacon platforms, but communicates danger and heat.  
  **Animation / FX:** Orange glow pulse, sizzling steam, small smoke wisps.  
  **Visual Direction:** Extra-bright bacon strips with charred edges and glowing grease bubbles.

- **Boiling Grease Pit**  
  **Category:** Liquid hazard.  
  **Specs:** Bottomless or damage-floor hazard used under platforms.  
  **Animation / FX:** Bubble loops, splash bursts, golden-yellow liquid shimmer.  
  **Visual Direction:** Thick golden grease with orange highlights, brown foam edges, dangerous lava-like surface.

- **Grease Splash Emitter**  
  **Category:** Timed hazard / FX object.  
  **Specs:** Shoots periodic vertical or arcing grease splashes from pits.  
  **Animation / FX:** Warning bubble, splash rise, droplets fall, puddle fade.  
  **Visual Direction:** Bright oily splash shapes with round droplets and brown shadow pixels.

- **Sausage-Link Rope**  
  **Category:** Climb / traversal object.  
  **Specs:** Hanging climbable rope; can be static or swaying.  
  **Animation / FX:** Gentle sway loop, greasy shine at attachment points.  
  **Visual Direction:** Linked reddish-brown sausages with small tied ends, glossy casing, clear vertical chain silhouette.

- **Hanging Bacon Strip Hazard**  
  **Category:** Swinging / contact hazard.  
  **Specs:** Hanging bacon strips used as obstacles or timing hazards.  
  **Animation / FX:** Slow swing, grease drip, impact wobble.  
  **Visual Direction:** Long flexible bacon strips with crispy edges and oily shine.

- **Sizzling Griddle Plates**  
  **Category:** Background / platform object.  
  **Specs:** Metal breakfast surfaces used under or behind bacon platforms.  
  **Animation / FX:** Heat shimmer, smoke curls, red-orange grill glow.  
  **Visual Direction:** Dark gray griddle plates with hot orange reflections and grease smears.

- **Bacon Spiral Columns**  
  **Category:** Boss arena / background structure.  
  **Specs:** Decorative or blocking columns in boss arena.  
  **Animation / FX:** Subtle twist shimmer, grease drip loop.  
  **Visual Direction:** Vertical spirals of bacon wrapping around a column form, red-brown stripes, golden highlights.

- **Bacon Tornado FX**  
  **Category:** Boss attack FX.  
  **Specs:** Large looping arena attack; must clearly show active damage area.  
  **Animation / FX:** Spinning bacon strips, debris orbit, smoke spiral, slowdown state.  
  **Visual Direction:** Swirling red-brown vortex with flying bacon strips and oily wind streaks.

- **Flying Bacon Debris**  
  **Category:** Boss projectile / hazard.  
  **Specs:** Small projectiles during boss fight.  
  **Animation / FX:** Spin frames, grease trail, impact splat.  
  **Visual Direction:** Curled bacon shards with crispy ends and shiny fat streaks.

- **Grease Slide Pickup / Trail**  
  **Category:** Power-up / movement FX.  
  **Specs:** Dash pickup and trail effect; trail can slow enemies.  
  **Animation / FX:** Pickup bob, dash streak, fading grease smear.  
  **Visual Direction:** Golden-brown grease streak with bubbles and bright oily highlights.

- **Extra Bacon Shield Pickup**  
  **Category:** Defensive power-up.  
  **Specs:** Absorbs one hit, especially from flying bacon debris.  
  **Animation / FX:** Golden sparkle, shield orbit, break pop.  
  **Visual Direction:** Crossed bacon strips forming a small golden shield icon.

- **Bacon Strip Evidence**  
  **Category:** Evidence collectible.  
  **Specs:** Canonical evidence item.  
  **Animation / FX:** Glimmer when untouched, pickup sparkle.  
  **Visual Direction:** Clean crispy bacon strip, slightly brighter than terrain, badge-like collectible readability.

- **Grease Canyon Background Set**  
  **Category:** Parallax background.  
  **Specs:** Fat clouds, huge cracked eggs in sky, bacon grease blob clouds, bacon comets.  
  **Animation / FX:** Slow cloud drift, bacon comet streaks, heat haze.  
  **Visual Direction:** Warm orange sky, smoky breakfast atmosphere, soft parallax silhouettes.

- **Grease Canyon Music / Ambience**  
  **Category:** Audio.  
  **Specs:** Fast, sizzling, tense traversal loop with greasy comedy tone.  
  **Audio Direction:** Sizzle percussion, bubbling grease, griddle hiss, slap-bass or muted brass accents, bacon debris whooshes.


---

# Pastry Palace Assets

Pastry Palace uses stacked croissant platforms, baguette and cake platforms, rotating dough mixers, sticky syrup puddles, donut/croissant objects, decorative pastry architecture, and a boss that throws oversized croissants.

- **Croissant Stack Platform Tiles**  
  **Category:** Main terrain.  
  **Specs:** Primary decorative platform set; needs top, side, corner, stacked variants, broken ends.  
  **Animation / FX:** Light butter shimmer, crumb fall on impact.  
  **Visual Direction:** Layered crescent croissants in warm pastry browns, flaky curves, butter-yellow highlights.

- **Baguette Platform Tiles**  
  **Category:** Long platform object.  
  **Specs:** Thin horizontal ledges or moving platforms.  
  **Animation / FX:** Crumb dust on landing, slight bounce.  
  **Visual Direction:** Long toasted baguettes with scoring cuts, rounded crust ends, readable straight ledge silhouette.

- **Cake Platform Tiles**  
  **Category:** Soft terrain / arena platform.  
  **Specs:** Wider platforms for combat or staging.  
  **Animation / FX:** Soft squash on landing, frosting sprinkle particles.  
  **Visual Direction:** Layer cake slabs with cream filling, frosting top, pastry-brown sides.

- **Rotating Dough Mixer**  
  **Category:** Rotating hazard / machinery.  
  **Specs:** Timed rotating obstacle; can serve as traversal timing challenge.  
  **Animation / FX:** Continuous rotation, metal glints, dough smears.  
  **Visual Direction:** Oversized mixer bowl and beaters, silver metal, beige dough, bakery-machine base.

- **Sticky Syrup Puddle**  
  **Category:** Slowdown hazard.  
  **Specs:** Ground patch that slows movement.  
  **Animation / FX:** Amber shimmer, sticky ripple, footstep stretch.  
  **Visual Direction:** Glossy amber puddle with darker caramel outline and sticky shine.

- **Oversized Croissant Projectile / Obstruction**  
  **Category:** Boss projectile / temporary blocker.  
  **Specs:** Thrown by boss, sticks to ground and blocks movement.  
  **Animation / FX:** Throw arc, landing thud, sticky dust.  
  **Visual Direction:** Large golden croissant with thick outline and buttery sparkle trail.

- **Exploding Jelly Donut FX**  
  **Category:** Enemy explosion / hazard residue.  
  **Specs:** Used by jelly-filled donuts.  
  **Animation / FX:** Red jelly burst, frosting fragments, sticky puddle linger.  
  **Visual Direction:** Pink-red jelly splash with donut crumbs and icing bits.

- **Donut Decoration / Donut Platform**  
  **Category:** Decorative object / possible platform.  
  **Specs:** Background and optional bounce/platform variants.  
  **Animation / FX:** Sprinkle sparkle, small wobble.  
  **Visual Direction:** Frosted donuts with pastel icing, sprinkles, warm pastry outline.

- **Pastry Machinery Set**  
  **Category:** Background / hazard machines.  
  **Specs:** Machines, pipes, rollers, central mixer, pastry factory pieces.  
  **Animation / FX:** Gear rotation, cream pipe drip, small steam puffs.  
  **Visual Direction:** Brass-and-steel bakery machinery mixed with frosting pipes and pastry rollers.

- **Syrup Trail Pickup**  
  **Category:** Power-up / utility.  
  **Specs:** Creates sticky path that slows enemies.  
  **Animation / FX:** Dripping trail, amber sparkle.  
  **Visual Direction:** Small syrup bottle or syrup badge with golden liquid inside.

- **Whipped Cream Shield Pickup**  
  **Category:** Power-up / shield.  
  **Specs:** Absorbs one hit.  
  **Animation / FX:** Puffy shield pop, cream splat.  
  **Visual Direction:** Swirled white whipped cream dollop with light-blue shadow pixels.

- **Syrup Boots Pickup**  
  **Category:** Movement power-up.  
  **Specs:** Counter to sticky areas.  
  **Animation / FX:** Boot sparkle, sticky immunity pulse.  
  **Visual Direction:** Small boots with amber syrup soles and pastry-gold highlights.

- **Evidence Slot: Pastry Clue**  
  **Category:** Evidence collectible.  
  **Specs:** Source docs mark evidence as TBD, with candidate options like croissant crumbs, hidden croissant, or purse receipt.  
  **Animation / FX:** Evidence sparkle, badge glint.  
  **Visual Direction:** Small clue object with pastry crumbs or hidden croissant shape; final item still needs selection.

- **Pastry Palace Background Set**  
  **Category:** Parallax background.  
  **Specs:** Decorative pastry architecture, oversized bakery machinery, croissant balconies, bakery signage.  
  **Animation / FX:** Soft steam, rotating distant mixer, falling crumbs.  
  **Visual Direction:** Elegant bakery palace in pastry browns, cream, butter-yellow, frosting pinks.

- **Pastry Palace Music / Ambience**  
  **Category:** Audio.  
  **Specs:** Elegant but playful bakery loop with mechanical rhythm.  
  **Audio Direction:** Light waltz or bouncy bakery theme, mixer whirs, soft chimes, pastry pops, sticky syrup squelches.


---

# Sticky Syrup Swamp Assets

Sticky Syrup Swamp is defined by sticky/slippery syrup platforms, syrup waterfalls, pancake rafts, syrup lakes, barrels, bees, butter pats, and dripping syrup edges.

- **Sticky Syrup Platform Tiles**  
  **Category:** Main terrain / slowdown terrain.  
  **Specs:** Walkable but sticky; should communicate reduced movement.  
  **Animation / FX:** Slow amber ripple, sticky foot-pull effect.  
  **Visual Direction:** Pancake-tan or rock platform coated in glossy amber syrup, heavy drips along edges.

- **Slippery Syrup Platform Tiles**  
  **Category:** Movement-modifier terrain.  
  **Specs:** Walkable but low-friction; distinct from sticky tiles.  
  **Animation / FX:** Smooth shine sweep, skid particles.  
  **Visual Direction:** Thinner syrup coating with bright slick highlights and smoother surface.

- **Floating Pancake Raft**  
  **Category:** Moving platform.  
  **Specs:** Slow raft timing over syrup lakes.  
  **Animation / FX:** Gentle bob, syrup ripple underneath.  
  **Visual Direction:** Stacked pancake raft with butter pat, syrup drip, soft tan edges.

- **Syrup Lake**  
  **Category:** Liquid hazard / background water layer.  
  **Specs:** Slow/damage or fall hazard depending on placement.  
  **Animation / FX:** Thick bubbling syrup, slow wave loops.  
  **Visual Direction:** Dark amber swamp liquid with honey-gold highlights and sticky surface tension.

- **Syrup Waterfall**  
  **Category:** Traversal obstacle / background feature.  
  **Specs:** Vertical movement obstacle and visual landmark.  
  **Animation / FX:** Slow falling syrup sheet, droplets, splash base.  
  **Visual Direction:** Thick amber curtain with darker caramel streaks and glossy highlights.

- **Syrup Barrel**  
  **Category:** Prop / destructible object / possible enemy source.  
  **Specs:** Can be background, obstacle, or source for syrup hazards.  
  **Animation / FX:** Leak loop, crack state, burst splash.  
  **Visual Direction:** Wooden barrel with amber syrup leaking from seams and sticky puddle at base.

- **Dripping Syrup Edge Tiles**  
  **Category:** Edge decoration / hazard tell.  
  **Specs:** Used on platform undersides and ceilings.  
  **Animation / FX:** Drip forms, falls, resets.  
  **Visual Direction:** Long caramel droplets hanging from pancake or rock edges.

- **Falling Syrup Stream**  
  **Category:** Timed hazard.  
  **Specs:** Periodic falling stream from ceiling or waterfall.  
  **Animation / FX:** Warning drip, full pour, splash.  
  **Visual Direction:** Thick vertical amber stream with heavy rounded droplets.

- **Butter Boots Pickup**  
  **Category:** Movement power-up.  
  **Specs:** Prevents slipping on syrupy platforms.  
  **Animation / FX:** Foot sparkle, skid immunity flash.  
  **Visual Direction:** Small yellow boots with butter shine and syrup-resistant sole.

- **Honey Comb Pickup**  
  **Category:** Utility power-up.  
  **Specs:** Distracts bees.  
  **Animation / FX:** Honey sparkle, tiny bee-attraction swirl.  
  **Visual Direction:** Golden honeycomb tile with hex cells and honey drips.

- **Syrup Pool Boss Hazard**  
  **Category:** Boss arena hazard.  
  **Specs:** Placed by boss to cover arena areas.  
  **Animation / FX:** Cannon splat, spreading puddle, sticky glisten.  
  **Visual Direction:** Wide syrup puddle with brighter impact center and dark caramel edges.

- **Evidence Slot: Syrup Clue**  
  **Category:** Evidence collectible.  
  **Specs:** Source docs mark evidence as TBD.  
  **Animation / FX:** Evidence glimmer.  
  **Visual Direction:** Placeholder could be a syrup-stained clue object, but final evidence item still needs definition.

- **Syrup Swamp Background Set**  
  **Category:** Parallax background.  
  **Specs:** Syrup swamp landscape, pancake islands, bees guarding syrup sources, rainbow syrup bottle labels.  
  **Animation / FX:** Slow swamp mist, syrup bubbles, bee silhouettes.  
  **Visual Direction:** Amber, honey gold, pancake tan, swamp green, syrup brown.

- **Sticky Syrup Swamp Music / Ambience**  
  **Category:** Audio.  
  **Specs:** Slow sticky groove with vertical traversal tension.  
  **Audio Direction:** Syrup glugs, honey drips, bee buzzes, sticky squelches, lazy swamp bass, soft pancake raft creaks.


---

# Kitchen Mayhem Assets

Kitchen Mayhem includes falling knives, boiling pots, flying rolling pins, cutting-board and countertop platforms, stoves, fire jets, tiled walls, hanging tools, steam, and dish piles for boss cover.

- **Countertop Platform Tiles**  
  **Category:** Main terrain.  
  **Specs:** Standard walkable kitchen surface.  
  **Animation / FX:** Small shine on clean tiles, crumbs or sauce details.  
  **Visual Direction:** Gray-white countertop slabs with clean pixel edges and kitchen grime accents.

- **Cutting Board Platform Tiles**  
  **Category:** Wooden platform terrain.  
  **Specs:** Warm alternate platform material.  
  **Animation / FX:** Knife nick particles, wood dust on impact.  
  **Visual Direction:** Brown cutting boards with visible grain, knife marks, rounded corners.

- **Tiled Kitchen Wall Set**  
  **Category:** Background / wall tiles.  
  **Specs:** Repeating background tile pattern, cracked variants, stained variants.  
  **Animation / FX:** Occasional steam overlay.  
  **Visual Direction:** White square tiles with gray grout, subtle stains, high kitchen readability.

- **Stove / Burner Tiles**  
  **Category:** Damage hazard / platform edge.  
  **Specs:** Hot stove zones and burner hazards.  
  **Animation / FX:** Flame loop, orange glow, heat shimmer.  
  **Visual Direction:** Dark stove metal with orange burner circles and flickering flame pixels.

- **Boiling Pot Hazard**  
  **Category:** Timed hazard.  
  **Specs:** Damage source with timed bubble/steam bursts.  
  **Animation / FX:** Boiling bubbles, steam burst, lid rattle.  
  **Visual Direction:** Large steel pot over flame, white steam, bubbling water.

- **Falling Knife Hazard**  
  **Category:** Timed projectile / falling hazard.  
  **Specs:** Falls from ceiling or racks; needs warning shadow.  
  **Animation / FX:** Warning glint, fall streak, metal impact spark.  
  **Visual Direction:** Shiny silver knife with dark handle and sharp vertical silhouette.

- **Flying Rolling Pin Hazard**  
  **Category:** Moving hazard.  
  **Specs:** Horizontal projectile or moving obstacle.  
  **Animation / FX:** Spin loop, flour trail, wood impact particles.  
  **Visual Direction:** Wooden rolling pin with motion marks and flour dust.

- **Spinning Ladle Hazard**  
  **Category:** Rotating hazard.  
  **Specs:** Spins in place or moves on path.  
  **Animation / FX:** Circular metal streak, clang hit sparks.  
  **Visual Direction:** Silver ladle with readable bowl and long handle, strong circular motion frames.

- **Fire Jet Emitter**  
  **Category:** Timed hazard.  
  **Specs:** Emits bursts from stoves or wall pipes.  
  **Animation / FX:** Warning glow, flame burst, smoke fade.  
  **Visual Direction:** Orange flame column from metal nozzle with heat shimmer.

- **Steam Burst Vent**  
  **Category:** Timed hazard / obscuring FX.  
  **Specs:** Short steam bursts from pipes or pots.  
  **Animation / FX:** White steam plume, fade-out cloud.  
  **Visual Direction:** Soft white-gray pixel cloud with transparent edge shapes.

- **Wooden Crates**  
  **Category:** Breakable object / cover.  
  **Specs:** Optional collectible containers or route blockers.  
  **Animation / FX:** Crack state, break particles.  
  **Visual Direction:** Brown kitchen storage crates with simple plank pattern.

- **Hanging Kitchen Tool Set**  
  **Category:** Background prop / possible hazard.  
  **Specs:** Spatulas, forks, ladles, pans, whisks.  
  **Animation / FX:** Slight swing loop.  
  **Visual Direction:** Gray metal tools hanging from hooks, clear silhouettes.

- **Dish Pile Cover**  
  **Category:** Boss arena destructible cover.  
  **Specs:** Boss hides behind piles; player breaks to expose boss.  
  **Animation / FX:** Crack states, plate shard burst, dust.  
  **Visual Direction:** Stacked white plates and bowls with blue-gray shadows and visible cracks.

- **Shield of Cutlery Pickup**  
  **Category:** Power-up.  
  **Specs:** Reflects flying knives and projectiles.  
  **Animation / FX:** Metal shield flash, reflected spark.  
  **Visual Direction:** Small shield made of crossed forks, spoons, and knives.

- **Dish Soap Speed Boost Pickup**  
  **Category:** Movement power-up.  
  **Specs:** Temporarily increases movement speed.  
  **Animation / FX:** Blue soap bubbles, speed streak.  
  **Visual Direction:** Dish soap bottle with bright blue liquid and bubble particles.

- **Cutlery Evidence**  
  **Category:** Evidence collectible.  
  **Specs:** Canonical evidence item.  
  **Animation / FX:** Metallic glint and pickup sparkle.  
  **Visual Direction:** Missing fork/spoon/knife bundle with evidence-badge shine.

- **Kitchen Mayhem Background Set**  
  **Category:** Parallax background.  
  **Specs:** White tiled wall, hanging utensils, active stoves, pots, counters, crates, inclusive signage/stickers.  
  **Animation / FX:** Steam drift, flickering stove glows, swinging utensils.  
  **Visual Direction:** Stainless steel, tile whites, stove orange, cutting-board brown, utensil gray.

- **Kitchen Mayhem Music / Ambience**  
  **Category:** Audio.  
  **Specs:** Chaotic kitchen percussion loop.  
  **Audio Direction:** Clanging pans, knife whooshes, bubbling pots, stove flames, fast percussion using utensil-like metallic hits.


---

# Candy Chaos Assets

Candy Chaos is a saturated dessert playground with candy cane bridges, chocolate lava, gumdrop trampolines, peppermint wheels, cupcake platforms, explosive candy, sprinklers, candy projectiles, and a giant rolling cake boss vehicle. Its environment design also calls for gumdrops, brittle candy glass, licorice ropes, cake layers, hard candy discs, sugar spikes, pop candy bursts, candy rollers, and chocolate blocks.

- **Candy Cane Bridge Tiles**  
  **Category:** Main terrain / bridge.  
  **Specs:** Static or brittle paths.  
  **Animation / FX:** Crack state for brittle variants.  
  **Visual Direction:** Red-white striped candy cane platforms with glossy sugar shine and rounded ends.

- **Gumdrop Trampoline**  
  **Category:** Bounce platform.  
  **Specs:** Primary vertical traversal mechanic.  
  **Animation / FX:** Squash-stretch bounce, sugar sparkle burst.  
  **Visual Direction:** Rounded gumdrop with translucent candy body, sugar crystals, bright color variants.

- **Chocolate Bar Platform Tiles**  
  **Category:** Modular terrain.  
  **Specs:** Rectangular platforms, some slippery.  
  **Animation / FX:** Melt shimmer for slippery variants.  
  **Visual Direction:** Chocolate rectangles with segmented squares, glossy highlights, dark brown edges.

- **Chocolate Lava River**  
  **Category:** Liquid damage hazard.  
  **Specs:** Dangerous floor / river.  
  **Animation / FX:** Bubbling chocolate, lava-like glow, splash on contact.  
  **Visual Direction:** Dark melted chocolate with bright brown-orange highlights and thick bubbles.

- **Licorice Rope**  
  **Category:** Swinging / climbable traversal.  
  **Specs:** Vertical and gap traversal object.  
  **Animation / FX:** Sway loop, stretch frames.  
  **Visual Direction:** Twisted black or red licorice strand with glossy candy shine.

- **Cake Layer Platform**  
  **Category:** Wide arena platform.  
  **Specs:** Combat stages and boss arena layouts.  
  **Animation / FX:** Soft landing crumbs, frosting wobble.  
  **Visual Direction:** Layered cake slabs with frosting seams and pastel icing.

- **Hard Candy Disc Platform**  
  **Category:** Rotating platform.  
  **Specs:** Timing challenge platform.  
  **Animation / FX:** Continuous rotation, glassy highlight sweep.  
  **Visual Direction:** Round translucent candy disc with radial shine.

- **Rolling Peppermint Wheel / Candy Roller**  
  **Category:** Moving hazard.  
  **Specs:** Rolls along slopes or tracks.  
  **Animation / FX:** Spin loop, candy trail, impact bounce.  
  **Visual Direction:** Red-white peppermint wheel with strong circular silhouette.

- **Brittle Candy Glass**  
  **Category:** Breakable hazard / route object.  
  **Specs:** Shatters into danger zones or opens routes.  
  **Animation / FX:** Crack stages, sugar shard burst.  
  **Visual Direction:** Thin translucent candy panels with sharp sparkle edges.

- **Sticky Caramel Pool**  
  **Category:** Slowdown hazard.  
  **Specs:** Surface modifier that slows player.  
  **Animation / FX:** Stretchy pull, caramel bubble.  
  **Visual Direction:** Golden-brown sticky puddle with elastic strands.

- **Sugar Spikes**  
  **Category:** Damage hazard.  
  **Specs:** Static spike hazard.  
  **Animation / FX:** Sugar sparkle glint.  
  **Visual Direction:** Jagged crystal-like sugar spikes, white/pink highlights.

- **Pop Candy Burst**  
  **Category:** Timing hazard / FX.  
  **Specs:** Small explosive bursts.  
  **Animation / FX:** Warning sparkle, pop burst, tiny candy fragments.  
  **Visual Direction:** Bright colorful candy particles with star-shaped burst frames.

- **Candy Sprinkler Switch**  
  **Category:** Boss counterplay object.  
  **Specs:** Activates sprinklers to wash away boss cake.  
  **Animation / FX:** Pressed state, sprinkler water spray.  
  **Visual Direction:** Candy-colored floor switch with sprinkle markings and water nozzle icon.

- **Giant Rolling Cake Vehicle**  
  **Category:** Boss object.  
  **Specs:** Boss rides it; can be washed away by sprinklers.  
  **Animation / FX:** Cake roll loop, frosting damage stages, crumble under water.  
  **Visual Direction:** Oversized layered cake wheel with frosting, sprinkles, candy decorations.

- **Frosting Barrier Pickup**  
  **Category:** Defensive power-up.  
  **Specs:** Shields from candy projectiles.  
  **Animation / FX:** Frosting shield shimmer, candy impact splat.  
  **Visual Direction:** Rounded frosting shield with white/pink swirls.

- **Sugar Rush Pickup**  
  **Category:** Buff power-up.  
  **Specs:** Temporarily doubles attack speed.  
  **Animation / FX:** Speed sparkle aura, candy streaks.  
  **Visual Direction:** Bright sugar crystal or candy injector icon with energetic glow.

- **Rainbow Boost Pickup**  
  **Category:** Optional inclusion-themed pickup.  
  **Specs:** Placement candidate for Candy Chaos.  
  **Animation / FX:** Rainbow sparkle, celebratory burst.  
  **Visual Direction:** Bright rainbow candy/star icon with clear collectible outline.

- **Evidence Slot: Candy Clue**  
  **Category:** Evidence collectible.  
  **Specs:** Source docs mark evidence as TBD.  
  **Animation / FX:** Evidence sparkle.  
  **Visual Direction:** Placeholder candy wrapper, dessert receipt, or missing dessert clue; final evidence still needs definition.

- **Candy Chaos Background Set**  
  **Category:** Parallax background.  
  **Specs:** Giant candy skyline, dessert mountains, chocolate rivers, empty dessert shelves, candy wrappers, hoarded cake piles, licorice strands, candy pipes, sugar sparkles.  
  **Animation / FX:** Floating candy dust, chocolate drips, sparkle loops.  
  **Visual Direction:** Saturated candy red, mint, pink, chocolate brown, frosting white, gumdrop colors.

- **Candy Chaos Music / Ambience**  
  **Category:** Audio.  
  **Specs:** Bouncy dessert playground music.  
  **Audio Direction:** Candy pops, chocolate bubbling, wrapper crinkles, gumdrop boings, sugar glass cracks, sticky caramel pulls.


---

# Egg Factory Frenzy Assets

Egg Factory Frenzy uses conveyor belts, frying-pan platforms, egg carton platforms, cracking egg hazards, yolk traps, factory walls, warning stripes, egg machines, frying pan hazards, and conveyor/processing systems.

- **Factory Floor Tiles**  
  **Category:** Main terrain.  
  **Specs:** Standard walkable factory tiles.  
  **Animation / FX:** Subtle machinery vibration.  
  **Visual Direction:** Gray metal panels with bolts, hazard-stripe accents, egg residue.

- **Warning-Stripe Platform Tiles**  
  **Category:** Hazard-adjacent terrain.  
  **Specs:** Used near machinery, conveyors, and frying pan hazards.  
  **Animation / FX:** Flashing caution edge for dangerous zones.  
  **Visual Direction:** Black/yellow striped platform edges with gray industrial body.

- **Egg Carton Platform**  
  **Category:** Soft platform / terrain.  
  **Specs:** Walkable carton-shaped platforms.  
  **Animation / FX:** Light bounce or paper crinkle.  
  **Visual Direction:** Pale cardboard egg-carton shapes with rounded cup pockets.

- **Frying Pan Platform**  
  **Category:** Platform / themed terrain.  
  **Specs:** Platform shaped like a pan; separate from frying pan slam hazard.  
  **Animation / FX:** Heat shimmer if hot.  
  **Visual Direction:** Dark pan surface with silver rim and long handle silhouette.

- **Conveyor Belt**  
  **Category:** Moving platform / terrain system.  
  **Specs:** Moves player and eggs; requires straight segments, corners if needed, start/end caps.  
  **Animation / FX:** Belt scrolling loop, roller spin.  
  **Visual Direction:** Dark rubber belt with gray rollers and yellow caution edges.

- **Giant Egg Conveyor Object**  
  **Category:** Background / moving object.  
  **Specs:** Eggs transported through level.  
  **Animation / FX:** Egg rolling loop, occasional wobble.  
  **Visual Direction:** Large white eggs moving along gray industrial belt.

- **Cracking Egg Hazard**  
  **Category:** Timed hazard.  
  **Specs:** Egg cracks and spills yolk trap.  
  **Animation / FX:** Crack warning, shell split, yolk splat.  
  **Visual Direction:** Oversized egg with crack lines and bright yellow yolk spill.

- **Yolk Trap**  
  **Category:** Slowdown / damage hazard.  
  **Specs:** Slows and damages player.  
  **Animation / FX:** Sticky ripple, yellow shine.  
  **Visual Direction:** Glossy yellow-orange puddle with egg-white border.

- **Frying Pan Slam Hazard**  
  **Category:** Timed vertical hazard.  
  **Specs:** Slams down on platforms.  
  **Animation / FX:** Warning shadow, shake, impact ring, metal clang.  
  **Visual Direction:** Heavy black pan with dents, yolk stains, downward impact pose.

- **Egg Machine / Processing Station**  
  **Category:** Background / hazard machine.  
  **Specs:** Decorative machinery and possible hazard source.  
  **Animation / FX:** Pistons, conveyor rollers, warning lights.  
  **Visual Direction:** Gray industrial egg processor with yellow yolk pipes and caution stripes.

- **Factory Signage Set**  
  **Category:** Background / readable signs.  
  **Specs:** Warning signs, packing labels, small posters, optional inclusive details.  
  **Animation / FX:** Blinking caution lights.  
  **Visual Direction:** Black/yellow caution signs, egg icons, simple factory labels.

- **Omelet Shield Pickup**  
  **Category:** Defensive power-up.  
  **Specs:** Absorbs one hit.  
  **Animation / FX:** Eggy shield shimmer, crack-on-break.  
  **Visual Direction:** Round omelet or egg shield with golden edge.

- **Egg Timer Pickup**  
  **Category:** Enemy-slowing power-up.  
  **Specs:** Slows enemies temporarily.  
  **Animation / FX:** Clock pulse, slow-motion ring.  
  **Visual Direction:** Small egg-shaped kitchen timer with white shell body and red dial.

- **Evidence Slot: Egg Clue**  
  **Category:** Evidence collectible.  
  **Specs:** Source docs mark evidence as TBD.  
  **Animation / FX:** Evidence glimmer.  
  **Visual Direction:** Placeholder cracked egg clue, egg receipt, or missing carton marker; final item still needs definition.

- **Egg Factory Background Set**  
  **Category:** Parallax background.  
  **Specs:** Egg factory machinery, conveyor belts, warning signs, packing stations, worker badge/poster/packaging details.  
  **Animation / FX:** Conveyor movement, blinking lights, piston loops.  
  **Visual Direction:** Eggshell white, yolk yellow, factory gray, hazard-stripe black/yellow, pan black.

- **Egg Factory Music / Ambience**  
  **Category:** Audio.  
  **Specs:** Industrial egg-processing rhythm.  
  **Audio Direction:** Conveyor clacks, egg cracks, yolk splats, factory motors, warning beeps, metallic slam percussion.


---

# Citrus Cascade Assets

Citrus Cascade uses citrus wedge platforms, orange slice platforms, orange juice streams, soda fountain launchers, juice waterfalls, juicers, citrus trees, decorations, bottles, glasses, and pipe/conveyor-like structures.

- **Citrus Wedge Platform Tiles**  
  **Category:** Main terrain.  
  **Specs:** Orange/lemon/lime wedge platforms; needs tops, sides, corners, underside.  
  **Animation / FX:** Juice sparkle, pulp texture shimmer.  
  **Visual Direction:** Bright citrus wedges with rind border, juicy segment lines, glossy pulp.

- **Orange Slice Platform**  
  **Category:** Circular platform / stepping platform.  
  **Specs:** Smaller standalone platforms.  
  **Animation / FX:** Gentle bounce, juice droplet flicker.  
  **Visual Direction:** Round orange slices with radial segment pattern and green rind outline.

- **Slippery Orange Juice Stream**  
  **Category:** Surface hazard / movement modifier.  
  **Specs:** Slippery ground stream.  
  **Animation / FX:** Flow loop, skid particles.  
  **Visual Direction:** Bright orange juice ribbon with yellow highlights and transparent edges.

- **Juice Pushback Jet**  
  **Category:** Directional hazard.  
  **Specs:** Pushes player horizontally or vertically.  
  **Animation / FX:** Pressurized stream, splash impact, mist.  
  **Visual Direction:** Strong orange/yellow stream from nozzle with white foam edge.

- **Soda Fountain / Juice Launcher**  
  **Category:** Traversal launcher.  
  **Specs:** Launches player upward or sideways.  
  **Animation / FX:** Charge bubble, burst spray, landing mist.  
  **Visual Direction:** Soda fountain nozzle with orange juice eruption and citrus decals.

- **Orange Juice Waterfall**  
  **Category:** Background / traversal obstacle.  
  **Specs:** Vertical falling liquid; can be hazard or backdrop.  
  **Animation / FX:** Falling juice sheet, splash base, mist.  
  **Visual Direction:** Bright orange waterfall with golden highlights and soft splash foam.

- **Juicer Machine**  
  **Category:** Background / hazard machine.  
  **Specs:** Juicer props and squeezing machine hazards.  
  **Animation / FX:** Press motion, juice drip, machine shake.  
  **Visual Direction:** Gray metal juicer with orange halves, lime accents, glass juice tank.

- **Citrus Tree / Greenery Set**  
  **Category:** Background / decoration.  
  **Specs:** Grove scenery and parallax.  
  **Animation / FX:** Leaf sway, falling citrus.  
  **Visual Direction:** Green trees with oversized oranges, lemons, and limes.

- **Juice Bottle / Glass Props**  
  **Category:** Collectible prop / background object.  
  **Specs:** Bottles and glasses used for storytelling and platforms.  
  **Animation / FX:** Liquid shine, small bubble.  
  **Visual Direction:** Transparent bottles filled with orange juice, labels, bright highlights.

- **Orange Peel Trap Object**  
  **Category:** Rolling hazard.  
  **Specs:** Rolls across platforms.  
  **Animation / FX:** Spin loop, peel curl, zest particles.  
  **Visual Direction:** Curled orange rind with glossy peel and green leaf detail.

- **Vitamin Boost Pickup**  
  **Category:** Health power-up.  
  **Specs:** Heals small amount of health.  
  **Animation / FX:** Green/orange healing sparkle.  
  **Visual Direction:** Citrus vitamin capsule or juice bottle with plus symbol-like shape, no readable text needed.

- **Citrus Blast Pickup / Grenade FX**  
  **Category:** Power-up projectile / FX.  
  **Specs:** Orange grenade explodes into sticky pulp.  
  **Animation / FX:** Orange projectile arc, pulp explosion, sticky splatter.  
  **Visual Direction:** Small orange-shaped grenade with pulp burst frames.

- **Evidence Slot: Citrus Clue**  
  **Category:** Evidence collectible.  
  **Specs:** Source docs mark evidence as TBD.  
  **Animation / FX:** Evidence sparkle.  
  **Visual Direction:** Placeholder missing juice bottle, bottle cap, or orange juice receipt; final evidence still needs definition.

- **Citrus Cascade Background Set**  
  **Category:** Parallax background.  
  **Specs:** Giant citrus slices, industrial juicers, citrus groves, juice fountains, pride-colored citrus decorations.  
  **Animation / FX:** Fountain spray loops, leaf sway, juice mist.  
  **Visual Direction:** Orange, yellow, lime green, juice gold, metal gray, sky aqua.

- **Citrus Cascade Music / Ambience**  
  **Category:** Audio.  
  **Specs:** Bright, energetic processing-parkour loop.  
  **Audio Direction:** Juice splashes, soda-fountain pops, citrus zips, light tropical percussion, bubbly synths, machine pump rhythms.


---

# Bakery Bonanza Assets

Bakery Bonanza is built around giant ovens, conveyors, rising dough platforms, flour clouds, muffin machinery, oven towers, metal stairs, industrial supports, bread loaves, bakery pipes, and tray/bakery hazards. Its environment design adds platform types like rising dough, conveyor trays, oven ledges, flour shelves, bread-loaf platforms, muffin stacks, plus oven flames, falling trays, dough traps, and hot racks.

- **Rising Dough Platform**  
  **Category:** Timed traversal platform.  
  **Specs:** Expands or lifts over time for vertical traversal.  
  **Animation / FX:** Dough inflate loop, stretch frame, flour dust.  
  **Visual Direction:** Soft tan dough platform with puffy edges, flour dust, elastic surface.

- **Expanding / Collapsing Dough Platform**  
  **Category:** Timed platform hazard.  
  **Specs:** Grows then collapses; requires warning state.  
  **Animation / FX:** Inflate, wobble, crack/sink, reset.  
  **Visual Direction:** Puffy dough slab with stressed cracks and soft shading.

- **Conveyor Tray Platform**  
  **Category:** Moving platform.  
  **Specs:** Carries player through bakery machinery.  
  **Animation / FX:** Belt motion, tray rattle, wheel spin.  
  **Visual Direction:** Gray baking tray moving on metal rollers, warm oven highlights.

- **Oven Ledge Tiles**  
  **Category:** Stable platform near heat hazard.  
  **Specs:** Risk/reward positioning near ovens.  
  **Animation / FX:** Orange glow on underside, heat shimmer.  
  **Visual Direction:** Dark oven-metal ledges with glowing orange cracks and flour dust.

- **Flour-Covered Shelf Tiles**  
  **Category:** Visibility / movement modifier terrain.  
  **Specs:** Low-friction or obscured platforms.  
  **Animation / FX:** Footstep powder puff, drifting flour.  
  **Visual Direction:** Pale shelves dusted with white flour, soft gray shadows.

- **Bread-Loaf Platform**  
  **Category:** Soft/bouncy platform.  
  **Specs:** Basic traversal with bounce variation.  
  **Animation / FX:** Soft squash, crumb particles.  
  **Visual Direction:** Large golden bread loaf with crusty top and soft tan sides.

- **Muffin Stack Platforms**  
  **Category:** Vertical clustered platforms.  
  **Specs:** Climbing routes and secret placement.  
  **Animation / FX:** Slight wobble, crumb fall.  
  **Visual Direction:** Stacked muffins with paper wrappers and golden tops.

- **Giant Oven / Oven Tower**  
  **Category:** Background structure / hazard source.  
  **Specs:** Major landmark and heat hazard source.  
  **Animation / FX:** Glowing interior, opening door, heat shimmer, smoke.  
  **Visual Direction:** Huge industrial oven with orange-lit mouth, dark metal frame, flour-dusted edges.

- **Oven Flame Hazard**  
  **Category:** Timed damage hazard.  
  **Specs:** Activates in bursts.  
  **Animation / FX:** Warning glow, flame burst, fade.  
  **Visual Direction:** Orange-red flame tongues from oven vents with heat shimmer.

- **Falling Tray Hazard**  
  **Category:** Timed platform/damage hazard.  
  **Specs:** Drops after warning rattle.  
  **Animation / FX:** Shake, falling streak, metal clang impact.  
  **Visual Direction:** Gray baking tray with motion lines and warm reflections.

- **Flour Cloud Hazard**  
  **Category:** Visibility hazard.  
  **Specs:** Obscures enemies and platforms.  
  **Animation / FX:** Puff expansion, drifting cloud, fade.  
  **Visual Direction:** Soft white flour cloud with semi-transparent edges and powder particles.

- **Rolling Baguette Hazard**  
  **Category:** Moving hazard.  
  **Specs:** Rolls across floors or slopes.  
  **Animation / FX:** Spin loop, crumb trail.  
  **Visual Direction:** Long golden baguette with scoring marks, rolling motion marks.

- **Dough Trap**  
  **Category:** Slowdown / hold hazard.  
  **Specs:** Slows or briefly holds player.  
  **Animation / FX:** Dough stretch, sticky pull.  
  **Visual Direction:** Beige dough puddle with elastic strands and flour-dusted top.

- **Hot Rack Hazard**  
  **Category:** Stationary or moving damage hazard.  
  **Specs:** Heated rack surface.  
  **Animation / FX:** Red-orange glow, heat shimmer.  
  **Visual Direction:** Metal cooling rack with glowing hot bars.

- **Bread Cart**  
  **Category:** Pushable object / moving cover.  
  **Specs:** Creates moving cover or platforms.  
  **Animation / FX:** Wheel roll, bread wobble.  
  **Visual Direction:** Small bakery cart stacked with bread loaves and metal wheels.

- **Pastry Crate**  
  **Category:** Breakable object / collectible container.  
  **Specs:** Reveals collectibles or shortcuts.  
  **Animation / FX:** Crack state, crumb burst, wood pieces.  
  **Visual Direction:** Wooden bakery crate with flour marks and pastry labels.

- **Oven Mitt Switch**  
  **Category:** Interaction object.  
  **Specs:** Temporarily disables heat hazards.  
  **Animation / FX:** Press state, heat-off flash.  
  **Visual Direction:** Switch pad shaped like an oven mitt, warm orange/red accent.

- **Baking Tray Boss Cover**  
  **Category:** Destructible boss cover.  
  **Specs:** Boss hides behind trays; clearing exposes boss.  
  **Animation / FX:** Tray dent, clatter, break-apart stack.  
  **Visual Direction:** Piled gray baking trays with dents, flour dust, warm highlights.

- **Oven Mitts Pickup**  
  **Category:** Heat-protection power-up.  
  **Specs:** Protects against hot hazards.  
  **Animation / FX:** Heat shield shimmer, mitten sparkle.  
  **Visual Direction:** Pair of red/orange oven mitts with padded pixel stitching.

- **Muffin Shield Pickup**  
  **Category:** Defensive power-up.  
  **Specs:** Blocks one projectile.  
  **Animation / FX:** Muffin pop shield, crumb burst on break.  
  **Visual Direction:** Small muffin-shaped shield icon with golden top and wrapper base.

- **Evidence Slot: Bakery Clue**  
  **Category:** Evidence collectible.  
  **Specs:** Source docs mark evidence as TBD.  
  **Animation / FX:** Evidence sparkle.  
  **Visual Direction:** Placeholder muffin clue, flour footprint, or hidden hat-muffin item; final evidence still needs definition.

- **Bakery Bonanza Background Set**  
  **Category:** Parallax background.  
  **Specs:** Far ovens and bakery arches, muffin smuggling routes, hidden hat-shaped muffin piles, flour footprints, conveyor belts, tray racks, flour sacks, oven doors, flour dust, oven glow.  
  **Animation / FX:** Flour dust drift, oven glow pulse, tray motion.  
  **Visual Direction:** Oven orange, flour white, dough tan, baking-tray gray, warm bread brown.

- **Bakery Bonanza Music / Ambience**  
  **Category:** Audio.  
  **Specs:** Warm production-line bakery loop.  
  **Audio Direction:** Oven hums, dough rising sounds, flour puffs, tray rattles, bread-cart wheels, baguette rolling thumps.
