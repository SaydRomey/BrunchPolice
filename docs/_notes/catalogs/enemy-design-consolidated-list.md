# Brunch Police Enemy Design Consolidated List

This is a consolidated working list for enemy visual design 
and later GDScript implementation planning.

Regular enemies should be treated as `BaseEnemy` variants 
with shared health, speed, damage, death, damage-taking, and attack hooks.  
Bosses should be separate classes because they need unique phases and arena mechanics.

Reusable behavior buckets include 
patrol, chase, flying, pathfinding, attack cooldowns, detection range, 
and states like stunned, slowed, blinded, wrapped, frozen, and fleeing.

---

## Grease Canyon Enemies

- **Small Angry Pig**  
  **Category:** Ground patrol / charger enemy.  
  **Theme:** Greasy bacon-platform pig minion.  
  **Specs:** Small body, fast ground movement, low-to-medium health, patrols platforms and charges when the player enters range. Edge-aware movement should keep it from constantly falling off bacon ledges.  
  **Effect:** Contact damage and knockback; main role is pushing the player toward grease pits or off narrow platforms.  
  **Projectile / VFX:** No projectile. Uses dust, grease skid marks, and small sweat/steam pixels during charge.  
  **Animations:** Idle snort, patrol walk, charge windup with hoof scrape, fast charge, stunned wobble, defeat pop.  
  **Concise visual description:** Round angry pig with pink body, greasy shine, scrunched eyebrows, tiny hooves, bacon-colored shoulder markings, compact charging silhouette.

- **Bacon Worm**  
  **Category:** Rope / vertical slither enemy.  
  **Theme:** Bacon-strip worm that moves through sausage ropes and greasy structures.  
  **Specs:** Small-to-medium hazard enemy, moderate speed, can move up/down ropes or along vertical paths. Better as a platform-aware enemy with fixed path points.  
  **Effect:** Contact damage; can block rope routes and force timing during climbing sections.  
  **Projectile / VFX:** Grease droplets, wavy heat shimmer, small bacon crumbs when hit.  
  **Animations:** Segmented wiggle idle, vertical crawl, quick lunge, wrapped/stunned freeze, crispy break-apart death.  
  **Concise visual description:** Flexible worm made from segmented red-brown bacon strips, oily highlights, small angry eyes, curled tail, dripping grease pixels.

- **Flying Sausage Link**  
  **Category:** Flying swooper enemy.  
  **Theme:** Sausage-link aerial hazard.  
  **Specs:** Small flying enemy with hover pattern, short detection range, swoops downward when the player is underneath or nearby.  
  **Effect:** Contact damage and aerial pressure; makes jumps across grease pits less safe.  
  **Projectile / VFX:** No projectile by default. Wing flap pixels, grease drops, small motion streak during swoop.  
  **Animations:** Hover flap, aim pause, swoop dive, recovery rise, defeated spin-fall.  
  **Concise visual description:** Reddish-brown sausage link with tiny wings, angry face, glossy casing, dangling grease drops, readable flying silhouette.

- **Pig/Bacon Enemy Variant**  
  **Category:** Armored ground bruiser variant.  
  **Theme:** Pig minion protected by bacon armor.  
  **Specs:** Medium enemy, slower than Small Angry Pig, higher health, shorter charge distance, less knockback taken.  
  **Effect:** Contact damage and body-blocking; good for narrow bacon bridges or arena pressure.  
  **Projectile / VFX:** Bacon armor chips off when damaged, grease splash on stomp or hit.  
  **Animations:** Heavy patrol, armored charge, armor crack frames, stunned shake, defeat with bacon strips flying off.  
  **Concise visual description:** Chunky pig wrapped in crispy bacon armor plates, greasy red-brown highlights, angry snout, squat heavy silhouette.

- **Chef-Pig / Armored Pig Figure**  
  **Category:** Mini-boss candidate / heavy elite.  
  **Theme:** Grease Canyon chef-pig enforcer.  
  **Specs:** Medium-to-large enemy, high health, slow movement, short-range melee attack. Could become a mini-boss or boss-minion.  
  **Effect:** Heavy knockback, area denial near grease pits, possible bacon-strip swing attack.  
  **Projectile / VFX:** Bacon whip arc, grease splashes, pan-clang hit sparks.  
  **Animations:** Idle belly bounce, weapon windup, bacon swing, stomp, stunned dizzy stars, heavy defeat.  
  **Concise visual description:** Pig chef wearing stained apron and small chef hat, bacon armor pieces, grumpy face, oversized mitts or spatula, bulky kitchen bruiser shape.

- **Bacon Bandit**  
  **Category:** Boss enemy.  
  **Theme:** Grease Canyon bacon thief.  
  **Specs:** Separate boss class with phase logic, tornado attack state, vulnerable slowdown window, possible stunned/fleeing states.  
  **Effect:** Uses Bacon Tornado, flying bacon debris, arena pressure, and delayed vulnerability.  
  **Projectile / VFX:** Bacon tornado loop, flying bacon strips, grease wind spiral, smoky heat shimmer.  
  **Animations:** Smug idle, tornado spin-up, full tornado loop, slowdown/stagger, bacon-gun hit reaction, fleeing or defeat animation.  
  **Concise visual description:** Bacon thief boss with apron, pixel shades, bacon-whip arm, greasy red-brown outfit, smug expression, tornado-shaped bacon effects.

---

## Pastry Palace Enemies

- **Flying Éclair**  
  **Category:** Flying projectile enemy.  
  **Theme:** Cream-filled pastry drone.  
  **Specs:** Small-to-medium airborne enemy, hover pattern, keeps distance, fires whipped cream projectiles. Platform-aware so it can hover around pastry arenas without drifting into hazards.  
  **Effect:** Ranged pressure; cream shots slow or interrupt the player.  
  **Projectile / VFX:** Whipped cream blobs, white splat decals, small cream puff muzzle effect.  
  **Animations:** Hover bob, aim puff, cream shot, reload squish, hit frosting splatter, defeat crumb burst.  
  **Concise visual description:** Chocolate-glazed éclair body with tiny cream wings, angry frosting eyes, cream nozzle mouth, soft pastry highlights.

- **Rolling Baguette**  
  **Category:** Rolling hazard enemy.  
  **Theme:** Bread log hazard.  
  **Specs:** Medium horizontal enemy, rolls along platforms, predictable path, high contact threat. Could use patrol-path logic with slope handling.  
  **Effect:** Contact damage and pushback; pressures the player’s timing on croissant and cake platforms.  
  **Projectile / VFX:** Crumb trail, flour dust, rolling motion streaks.  
  **Animations:** Idle wobble, start roll, looping roll, wall bump bounce, cracked/stunned state, break into bread chunks.  
  **Concise visual description:** Long crusty baguette with toasted scoring cuts, angry face carved into bread, rounded rolling ends, crumb trail.

- **Jelly-filled Donut**  
  **Category:** Chasing exploder enemy.  
  **Theme:** Unstable jelly pastry bomb.  
  **Specs:** Small-to-medium chaser, moderate speed, low health, explodes on contact or after damage threshold.  
  **Effect:** Explosion creates temporary sticky jelly area or burst damage.  
  **Projectile / VFX:** Red jelly splash, frosting fragments, sticky puddle.  
  **Animations:** Idle jiggle, chase bounce, swelling fuse-like warning, explosion splat, post-explosion jelly fade.  
  **Concise visual description:** Round jelly donut with frosting glaze, red jelly leaking from cracks, angry eyes, tiny chasing legs, unstable swollen silhouette.

- **Donut / Pastry Machinery Hazard**  
  **Category:** Environmental machine enemy / hazard.  
  **Theme:** Pastry factory machinery.  
  **Specs:** Stationary or rail-bound hazard, medium durability if destructible, timed attack cycle.  
  **Effect:** Spins, shoots pastries, or blocks paths with rotating mixer parts.  
  **Projectile / VFX:** Donut gears, cream bursts, metal sparks, pastry crumbs.  
  **Animations:** Gear idle, spin-up, attack cycle, overheating shake, disabled smoke.  
  **Concise visual description:** Small pastry machine with donut gears, croissant rollers, frosting pipes, metal bakery parts, blinking angry light.

- **Croissant Crook**  
  **Category:** Boss enemy.  
  **Theme:** Elegant pastry thief.  
  **Specs:** Separate boss class with dash patterns, croissant throw state, obstruction spawning, and possible summoning of rolling croissants or baguettes.  
  **Effect:** Throws oversized croissants that stick to the ground and block movement.  
  **Projectile / VFX:** Flying croissant projectile, sticky landing splat, buttery sparkle trail.  
  **Animations:** Sneaky idle, croissant throw, dash, summon, recovery window, defeat with hidden pastries spilling out.  
  **Concise visual description:** Pastry thief with croissant-themed outfit, hidden croissant bag or purse, buttery gold accents, mischievous face, elegant bakery-villain silhouette.

---

## Sticky Syrup Swamp Enemies

- **Angry Bee**  
  **Category:** Flying swarm enemy.  
  **Theme:** Syrup swamp bee guardian.  
  **Specs:** Small flying enemy, circular patrol pattern, attacks when the player enters range. Works well with detection radius and short dash attack.  
  **Effect:** Contact damage; can pressure players near pancake rafts and syrup waterfalls.  
  **Projectile / VFX:** Buzz lines, tiny honey droplets, wing blur.  
  **Animations:** Circular buzz, alert shake, sting dash, recovery hover, defeated spiral fall.  
  **Concise visual description:** Round honey-yellow bee with brown stripes, tiny wings, sharp stinger, angry eyes, syrup droplets on wings.

- **Syrup Golem**  
  **Category:** Ground rising charger / heavy chaser.  
  **Theme:** Sticky syrup monster from swamp floor.  
  **Specs:** Medium-to-large enemy, slow start, strong charge, high health. Can spawn from syrup pools and become active after a rising animation.  
  **Effect:** Charge damage, slow aura or sticky contact effect.  
  **Projectile / VFX:** Amber syrup splashes, sticky puddle trail, bubbles from floor spawn.  
  **Animations:** Emerge from syrup, heavy idle drip, charge windup, sticky charge, hit wobble, melt death.  
  **Concise visual description:** Chunky amber syrup body with pancake chunks, dripping arms, glowing eyes, heavy rounded form, puddle base.

- **Flying Butter Pat**  
  **Category:** Flying contact hazard.  
  **Theme:** Melting butter square.  
  **Specs:** Small flying hazard, straight-line movement or simple sine-wave path, low health.  
  **Effect:** Contact damage and possible slippery butter smear on platforms.  
  **Projectile / VFX:** Yellow butter trail, melting droplets, small shine sparkles.  
  **Animations:** Hover wobble, glide, melt drip, impact splat, defeat smear.  
  **Concise visual description:** Small yellow butter square with tiny wings, melting edges, angry face, glossy dairy highlights.

- **Bee Variant**  
  **Category:** Stronger flying swarm variant.  
  **Theme:** Honey guardian bee.  
  **Specs:** Medium flying enemy, higher health than Angry Bee, larger patrol loop, can command smaller bees or guard syrup sources.  
  **Effect:** Contact damage, stronger knockback, possible short-range honey spit if expanded later.  
  **Projectile / VFX:** Honey sparkle trail, thicker wing blur, angry alert ring.  
  **Animations:** Guard hover, buzz circle, sting charge, summon twitch, defeated honey burst.  
  **Concise visual description:** Larger fuzzy bee with striped body, oversized wings, syrup-stained legs, sharp stinger, protective swarm-guard expression.

- **Syrup Barrel Enemy**  
  **Category:** Environmental bruiser / trap enemy.  
  **Theme:** Syrup container monster.  
  **Specs:** Medium enemy or destructible hazard, slow movement, can leak syrup puddles.  
  **Effect:** Creates sticky ground areas or blocks routes.  
  **Projectile / VFX:** Syrup leaks, barrel crack particles, amber splash.  
  **Animations:** Barrel wobble, leak idle, roll/charge, crack state, burst into syrup.  
  **Concise visual description:** Wooden syrup barrel with amber syrup leaking from cracks, angry eyes inside opening, sticky arms, heavy swamp-hazard silhouette.

- **Syrup Scoundrel**  
  **Category:** Boss enemy.  
  **Theme:** Sticky syrup vandal boss.  
  **Specs:** Separate boss class with reload windows, syrup-pool placement, and arena coverage logic.  
  **Effect:** Covers parts of arena with syrup, forcing movement control and safe-lane routing.  
  **Projectile / VFX:** Syrup cannon streams, amber pools, sticky splash rings.  
  **Animations:** Syrup cannon aim, fire stream, reload pause, smug idle, slip reaction, defeat drip collapse.  
  **Concise visual description:** Syrup swamp boss with sticky amber outfit, syrup cannon, pancake-brown boots, dripping syrup details, smug sticky expression.

---

## Kitchen Mayhem Enemies

- **Knife-throwing Chef**  
  **Category:** Ground ranged enemy.  
  **Theme:** Aggressive kitchen chef.  
  **Specs:** Medium enemy, patrols or stands at range, throws arcing knife projectiles. Needs attack cooldown, detection range, and line-of-sight checks.  
  **Effect:** Ranged pressure; forces dodging and shield/reflection use.  
  **Projectile / VFX:** Spinning knife projectile, silver glint, metal hit spark.  
  **Animations:** Idle chop pose, knife windup, throw, reload grab, panic/stunned, defeat.  
  **Concise visual description:** Angry chef with white hat, stained apron, clenched expression, knives in both hands, utensil belt, sharp kitchen-combat silhouette.

- **Dishwashing Sponge**  
  **Category:** Jumping chaser enemy.  
  **Theme:** Soapy kitchen sponge.  
  **Specs:** Small-to-medium enemy, jumps toward player, medium speed, low-to-medium health. Uses leap arcs instead of normal walking.  
  **Effect:** Contact damage, knockback, possible soap slick on landing.  
  **Projectile / VFX:** Soap bubbles, water splash, scrub particles.  
  **Animations:** Squash idle, leap crouch, jump arc, landing splat, stunned squish, pop defeat.  
  **Concise visual description:** Yellow porous sponge with green scrubber back, soap bubbles, angry face, springy legs, wet jumping silhouette.

- **Spinning Ladle**  
  **Category:** Stationary or pathing hazard enemy.  
  **Theme:** Animated utensil hazard.  
  **Specs:** Low or no health depending on implementation; spins in place or moves on a fixed path.  
  **Effect:** Contact damage and area denial.  
  **Projectile / VFX:** Circular metal motion streak, clang sparks.  
  **Animations:** Slow spin idle, fast spin warning, damage spin loop, disabled wobble.  
  **Concise visual description:** Shiny metal ladle with long handle, angry eyes on bowl, circular motion marks, clean spinning hazard silhouette.

- **Angry Chef Variant**  
  **Category:** Ground bruiser variant.  
  **Theme:** Larger kitchen staff enemy.  
  **Specs:** Medium-to-large enemy, higher health, slower movement, short-range melee or shove attack.  
  **Effect:** Blocks paths, knocks player backward, can activate kitchen hazards if expanded.  
  **Projectile / VFX:** Sauce splashes, footstep dust, metal pan hit sparks.  
  **Animations:** Heavy walk, shout alert, melee swing, shove, stunned, defeat.  
  **Concise visual description:** Larger angry chef with rolled sleeves, sauce stains, heavy eyebrows, kitchen utensil in hand, bulky cook silhouette.

- **Rolling Pin Hazard**  
  **Category:** Rolling ground hazard.  
  **Theme:** Kitchen rolling obstacle.  
  **Specs:** Medium rolling hazard, predictable left-right movement, possibly invulnerable unless stunned.  
  **Effect:** Contact damage and pushback.  
  **Projectile / VFX:** Flour dust, rolling motion lines, wooden impact particles.  
  **Animations:** Start roll, roll loop, wall bump, stunned wobble, break/crack state.  
  **Concise visual description:** Wooden rolling pin with angry carved face, flour dust, spinning motion marks, metal-capped handles.

- **Knife-throwing Sous Chef**  
  **Category:** Fast ranged variant.  
  **Theme:** Smaller kitchen knife enemy.  
  **Specs:** Smaller and faster than Knife-throwing Chef, lower health, shorter cooldown, weaker damage.  
  **Effect:** Adds quick projectile pressure in groups.  
  **Projectile / VFX:** Small knife projectile, quick silver flash.  
  **Animations:** Quick idle bounce, rapid throw, sidestep, stunned, defeat.  
  **Concise visual description:** Small sous chef with short chef hat, apron, quick stance, knife bundle, nervous angry expression.

- **Cutlery Thief**  
  **Category:** Boss enemy.  
  **Theme:** Stolen utensil boss.  
  **Specs:** Separate boss class with ranged cutlery attack, destructible dish-cover defense, and exposed damage windows.  
  **Effect:** Throws stolen forks, spoons, and knives; hides behind dish piles.  
  **Projectile / VFX:** Fork/knife/spoon projectiles, plate shards, dish-cover dust.  
  **Animations:** Utensil throw, hide behind dishes, exposed panic, dish pile break, defeat with cutlery spill.  
  **Concise visual description:** Kitchen thief with stolen utensils strapped around outfit, dish-cover armor, sharp grin, chaotic kitchen-villain silhouette.

---

## Candy Chaos Enemies

- **Gummy Bear Brute**  
  **Category:** Ground charger / heavy melee enemy.  
  **Theme:** Giant gummy candy brute.  
  **Specs:** Medium-to-large enemy, high health, straight-line charge behavior, slower turn speed.  
  **Effect:** Heavy contact damage and knockback.  
  **Projectile / VFX:** Gel shine, candy skid marks, gummy squash particles.  
  **Animations:** Idle wobble, charge windup, straight-line charge, wall bounce, stunned jiggle, gummy splat defeat.  
  **Concise visual description:** Large translucent gummy bear with glossy candy body, angry face, thick arms, heavy feet, internal shine highlights.

- **Cupcake Bomb**  
  **Category:** Chasing exploder enemy.  
  **Theme:** Frosted cupcake explosive.  
  **Specs:** Small-to-medium chaser, low health, accelerates toward player, explodes on contact.  
  **Effect:** Frosting explosion, area denial, possible sticky frosting residue.  
  **Projectile / VFX:** Frosting splat, sprinkle burst, warning flash.  
  **Animations:** Idle jiggle, chase run, fuse/warning pulse, explosion, frosting puddle fade.  
  **Concise visual description:** Cupcake with frosted top, sprinkles, angry wrapper face, tiny legs, glowing candy core or fuse.

- **Jellybean Sniper**  
  **Category:** Ranged shooter enemy.  
  **Theme:** Candy projectile sniper.  
  **Specs:** Small ranged enemy, low health, keeps distance, fires candy projectiles. Could use perch/position logic.  
  **Effect:** Long-range candy shots; pressures bounce routes and platforms.  
  **Projectile / VFX:** Jellybean bullets, sugar sparkle trail, candy hit pop.  
  **Animations:** Aim, charge shot, fire, reload, duck/stunned, defeat.  
  **Concise visual description:** Glossy jellybean body with candy goggles, tiny sugar-straw launcher, focused angry expression, compact ranged silhouette.

- **Cupcake-themed Character Variant**  
  **Category:** Variant enemy or mini-boss candidate.  
  **Theme:** Dessert mascot enemy.  
  **Specs:** Medium enemy, flexible role; could be melee, summoner, or cupcake-bomb spawner.  
  **Effect:** Can spawn smaller cupcake bombs or leave frosting hazards.  
  **Projectile / VFX:** Frosting swirls, sprinkles, cream puffs.  
  **Animations:** Frosting idle bounce, summon sprinkle toss, attack, hit squash, defeat frosting collapse.  
  **Concise visual description:** Cupcake character with tall frosting swirl head, sprinkle details, expressive face, tiny arms, wrapper body.

- **Candy Hoarder Variant**  
  **Category:** Boss-minion / elite variant.  
  **Theme:** Candy thief minion.  
  **Specs:** Medium-to-large enemy, higher health, can throw candy or guard hoarded dessert piles.  
  **Effect:** Throws explosive sweets or blocks switch routes.  
  **Projectile / VFX:** Candy wrappers, gumdrop bursts, frosting splashes.  
  **Animations:** Greedy idle, candy toss, hoard shield, hit reaction, candy spill defeat.  
  **Concise visual description:** Bulky candy-covered figure with gumdrops, wrappers, frosting stains, greedy expression, dessert-hoarder silhouette.

- **Dessert Hoarder**  
  **Category:** Boss enemy.  
  **Theme:** Candy hoarder on giant cake vehicle.  
  **Specs:** Separate boss class with vehicle phase, explosive candy throwing, sprinkler counterplay, and knock-off state.  
  **Effect:** Throws explosive candy while riding a giant rolling cake.  
  **Projectile / VFX:** Explosive candy, frosting bursts, sprinkler water effects, cake crumble.  
  **Animations:** Cake ride idle, candy throw, cake roll, sprinkler panic, knocked-off state, defeat.  
  **Concise visual description:** Candy hoarder covered in wrappers and frosting, greedy expression, bright dessert colors, giant cake vehicle detail.

---

## Egg Factory Frenzy Enemies

- **Angry Chicken**  
  **Category:** Ground chaser / melee pecker.  
  **Theme:** Factory chicken minion.  
  **Specs:** Small-to-medium enemy, fast ground movement, low-to-medium health, chases and pecks at close range.  
  **Effect:** Contact damage and quick peck hit; good for conveyor-belt pressure.  
  **Projectile / VFX:** Feather puffs, yolk splatter, dust from fast feet.  
  **Animations:** Idle cluck, chase run, peck attack, conveyor slip, stunned stars, feather burst defeat.  
  **Concise visual description:** Angry white chicken with red comb, sharp beak, tiny wings, fast running legs, yolk splatter details.

- **Eggshell Drone**  
  **Category:** Flying bomber enemy.  
  **Theme:** Cracked egg factory drone.  
  **Specs:** Small flying enemy, hovers above player, drops yolk bombs downward. Needs flying AI and timed bomb cooldown.  
  **Effect:** Creates yolk traps or damage zones below.  
  **Projectile / VFX:** Falling yolk bomb, shell shards, yellow splat puddle.  
  **Animations:** Hover, bomb hatch open, drop, reload, cracked damage state, crash defeat.  
  **Concise visual description:** Flying cracked eggshell drone with propeller or tiny wings, yellow yolk core, angry sensor eye, dangling yolk bomb.

- **Frying Pan**  
  **Category:** Slam hazard enemy.  
  **Theme:** Industrial pan trap.  
  **Specs:** Large hazard enemy, mostly stationary or moving vertically, timed slam cycle. Can be treated as enemy, hazard, or both.  
  **Effect:** Heavy slam damage and knockback; creates unsafe timing windows.  
  **Projectile / VFX:** Impact shock ring, yolk splat, metal clang sparks.  
  **Animations:** Hover warning, shake, slam down, impact pause, lift reset, disabled state.  
  **Concise visual description:** Heavy black frying pan with angry face on pan surface, long handle, yolk stains, dents, downward slamming silhouette.

- **Chicken Variant**  
  **Category:** Armored chaser variant.  
  **Theme:** Egg-factory chicken guard.  
  **Specs:** Medium enemy, more health than Angry Chicken, slightly slower, may resist knockback.  
  **Effect:** Chases and body-blocks; can peck or shoulder-bash.  
  **Projectile / VFX:** Eggshell armor chips, feather puffs.  
  **Animations:** Armored walk, chase, peck/bash, armor crack, stunned, defeat.  
  **Concise visual description:** Larger chicken with eggshell armor, hazard-stripe band, angry eyes, flapping wings, industrial factory look.

- **Cracked Egg Creature**  
  **Category:** Small ground minion / slime-like chaser.  
  **Theme:** Living cracked egg.  
  **Specs:** Small enemy, low health, erratic movement, can emerge from cracked egg hazards.  
  **Effect:** Contact damage or slippery yolk trail.  
  **Projectile / VFX:** Yolk drips, shell chips, goo trail.  
  **Animations:** Shell wobble, hatch/pop, scuttle, splat hit, yolk puddle defeat.  
  **Concise visual description:** Small cracked egg monster with white shell body, gooey yellow yolk interior, tiny legs, startled angry eyes.

- **Omelet Overlord**  
  **Category:** Boss enemy.  
  **Theme:** Egg factory spatula boss.  
  **Specs:** Separate boss class with platform-flip attacks, defense-cracking phases, and anti-conveyor arena logic.  
  **Effect:** Flips player off platforms; defenses can be cracked by Egg Launcher.  
  **Projectile / VFX:** Spatula swing arc, shell-crack shield effect, yolk splash.  
  **Animations:** Stern idle, spatula windup, platform flip, defense crack, vulnerable state, defeat with omelet splat.  
  **Concise visual description:** Egg factory boss with spatula weapon, apron, cracked egg armor, yolk stains, black-yellow hazard accents.

---

## Citrus Cascade Enemies

- **Squeezing Machine**  
  **Category:** Stationary projectile machine enemy.  
  **Theme:** Industrial citrus juicer hazard.  
  **Specs:** Medium stationary or semi-mobile machine, timed juice shots, moderate durability if destructible.  
  **Effect:** Shoots juice jets that damage or push the player.  
  **Projectile / VFX:** Orange juice stream, splash cone, pressurized nozzle mist.  
  **Animations:** Press open/close, charge squeeze, juice spray, reload, disabled smoke/juice leak.  
  **Concise visual description:** Metal juicer body with orange halves caught in press, angry gauge face, juice nozzle, gray-and-orange industrial silhouette.

- **Lemon Bat**  
  **Category:** Flying swooper enemy.  
  **Theme:** Sour citrus bat.  
  **Specs:** Small flying enemy, zigzag flight path, swoops down to attack.  
  **Effect:** Contact damage and aerial movement disruption.  
  **Projectile / VFX:** Citrus droplets, yellow motion streaks, sour sparkle hit.  
  **Animations:** Zigzag flap, aim pause, swoop, recovery climb, stunned spin, defeated citrus burst.  
  **Concise visual description:** Lemon-shaped bat with yellow citrus body, small wings, sour angry face, pointed ears, juice droplets.

- **Orange Peel Trap**  
  **Category:** Rolling ground hazard.  
  **Theme:** Curled orange rind obstacle.  
  **Specs:** Small-to-medium rolling hazard, predictable platform path, low or no health.  
  **Effect:** Contact damage, trip/knockdown, forces jump timing.  
  **Projectile / VFX:** Peel curl streaks, orange zest particles, rolling spin marks.  
  **Animations:** Curl idle, roll loop, bounce on wall, unravel stun, peel-snap defeat.  
  **Concise visual description:** Curled orange rind with glossy peel texture, green leaf detail, circular rolling form, spinning motion marks.

- **Citrus Bat Variant**  
  **Category:** Stronger flying variant.  
  **Theme:** Lemon/lime aerial enemy.  
  **Specs:** Small-to-medium flying enemy, faster swoop, sharper zigzag, possibly higher health.  
  **Effect:** Contact damage and aerial chase pressure.  
  **Projectile / VFX:** Lime-orange sparkle trail, juice droplets.  
  **Animations:** Fast flap, zigzag dash, sour screech, stun, citrus-splash defeat.  
  **Concise visual description:** Lime-and-lemon bat with segmented citrus body, translucent wings, sharp sour expression, bright juice highlights.

- **Juice Machine Hazard**  
  **Category:** Environmental machine enemy.  
  **Theme:** Juice-processing pipe hazard.  
  **Specs:** Stationary machine, timed spray, can be destructible or switch-controlled.  
  **Effect:** Shoots or leaks juice streams that push or damage the player.  
  **Projectile / VFX:** Juice jet, warning pressure gauge, orange leak.  
  **Animations:** Pressure build, nozzle shake, spray loop, pressure release, broken leak state.  
  **Concise visual description:** Small juice machine with pipe body, orange juice tank, spraying nozzle, warning stripe details, angry indicator light.

- **Juice Jacker**  
  **Category:** Boss enemy.  
  **Theme:** Citrus thief with juicer gun.  
  **Specs:** Separate boss class with ranged stream attacks, reload vulnerability, and pushback hazard patterns.  
  **Effect:** Sprays juice streams and becomes vulnerable during reload pauses.  
  **Projectile / VFX:** Orange juice streams, splash waves, citrus mist, reload steam.  
  **Animations:** Aim juicer gun, stream spray, recoil, reload pause, vulnerable stagger, defeat juice spill.  
  **Concise visual description:** Citrus thief boss with orange-and-lime outfit, juicer gun, juice tank backpack, sour grin, bright juice-factory silhouette.

---

## Bakery Bonanza Enemies

- **Flour Bag Monster**  
  **Category:** Visibility debuff enemy.  
  **Theme:** Living flour sack.  
  **Specs:** Medium enemy, slow movement, low-to-medium health, emits flour clouds.  
  **Effect:** Obscures visibility and may slow/blind the player or enemies inside the cloud.  
  **Projectile / VFX:** Flour puff cloud, white dust ring, powder particles.  
  **Animations:** Sack idle slump, inhale puff windup, flour cloud burst, cough/stunned, sack-collapse defeat.  
  **Concise visual description:** Lumpy flour sack monster with tied cloth top, angry stitched face, powder leaking from seams, soft dust cloud silhouette.

- **Rolling Muffin Tray**  
  **Category:** Rolling platform hazard enemy.  
  **Theme:** Bakery tray loaded with muffins.  
  **Specs:** Medium moving hazard, rolls across platforms, predictable path, may be stunnable.  
  **Effect:** Contact damage and knockback; can disrupt conveyor traversal.  
  **Projectile / VFX:** Tray rattle lines, crumb trail, metal sparks.  
  **Animations:** Rattle idle, roll loop, muffin bounce, wall clank, stunned tray tilt, spill defeat.  
  **Concise visual description:** Metal baking tray filled with angry muffins, small wheels, warm oven highlights, rattling motion marks.

- **Burning Muffin**  
  **Category:** Ground charger / fire enemy.  
  **Theme:** Overbaked flaming muffin.  
  **Specs:** Small-to-medium chaser, fast burst movement, low health, fire contact damage.  
  **Effect:** Charges and deals fire damage; may leave brief scorch marks.  
  **Projectile / VFX:** Small flames, ember trail, orange heat shimmer.  
  **Animations:** Flame idle, charge windup, fire dash, burnout pause, extinguished/stunned, crumb-and-ember defeat.  
  **Concise visual description:** Angry muffin with charred top, small flames, glowing orange cracks, wrapper body, tiny charging legs.

- **Muffin Enemy Variant**  
  **Category:** Basic bakery minion.  
  **Theme:** Small muffin creature.  
  **Specs:** Small enemy, low health, simple chase or patrol behavior.  
  **Effect:** Contact damage, group pressure.  
  **Projectile / VFX:** Crumbs, flour dust, small bounce marks.  
  **Animations:** Idle bounce, hop walk, bite/body bump, hit crumble, defeat crumb pop.  
  **Concise visual description:** Small golden-brown muffin with paper wrapper body, crumb texture, angry face, little feet.

- **Oven/Muffin Machine Hazard**  
  **Category:** Environmental machine enemy.  
  **Theme:** Industrial bakery machine.  
  **Specs:** Stationary or conveyor-mounted hazard, medium durability if destructible, timed attack cycle.  
  **Effect:** Launches muffins, emits heat, or blocks routes.  
  **Projectile / VFX:** Muffin projectile, oven glow, smoke puff, flour dust.  
  **Animations:** Door glow, conveyor feed, muffin launch, overheat shake, disabled smoke.  
  **Concise visual description:** Compact oven machine with glowing orange door, conveyor slot, muffin launcher detail, metal frame, flour dust.

- **Muffin Mastermind**  
  **Category:** Boss enemy.  
  **Theme:** Muffin smuggler boss.  
  **Specs:** Separate boss class with explosive muffin throws, baking-tray cover, and expose-then-attack windows.  
  **Effect:** Throws explosive muffins and hides behind piles of baking trays.  
  **Projectile / VFX:** Explosive muffin arcs, tray clatter, flour smoke, oven-orange blast.  
  **Animations:** Sneaky idle, muffin throw, hide behind trays, tray break, exposed panic, defeat with muffins spilling from hat.  
  **Concise visual description:** Bakery boss with muffin-filled hat, tray armor, flour-dusted outfit, explosive muffin details, sly smuggling expression.
