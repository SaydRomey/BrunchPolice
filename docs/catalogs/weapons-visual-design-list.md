# Brunch Police Weapon Visual Design List

This is a consolidated working list of current weapons for visual design and later GDScript implementation planning.

Note: The specs below are design-facing, not balance values.  
That means they describe the weapon's intended feel, role, behavior, visual logic, animation needs, and implementation hooks.  
They are not final gameplay numbers like exact damage, cooldown, knockback force, projectile speed, or status duration.

---

## Global / Grease Canyon Weapons

- **Brunch Fork**
  - **Category:** Main-hand default
  - **Theme:** Standard brunch police tool
  - **Specs / Effect:** Fast pokes, low damage, reliable baseline attack
  - **Projectile / VFX:** Small silver stab spark
  - **Animations:** Quick jab, charged fork lunge
  - **Concise Visual Description:** Oversized shiny fork with rounded cartoon handle and clean pixel outline

- **Bacon Gun**
  - **Category:** Ranged main-hand or special weapon
  - **Theme:** Bacon-strip launcher
  - **Specs / Effect:** Low damage, strong control; wraps or immobilizes enemies
  - **Projectile / VFX:** Curled bacon strip projectile with oily trail, red-brown spin frames, bacon wrap effect on hit
  - **Animations:** Recoil pop, muzzle grease puff, bacon strip unfurling midair
  - **Concise Visual Description:** Chunky breakfast blaster with griddle-metal barrel, bacon magazine, and orange grease highlights

- **Extra Bacon Shield**
  - **Category:** Off-hand defense
  - **Theme:** Protective bacon slab
  - **Specs / Effect:** Absorbs one hit or blocks bacon debris
  - **Projectile / VFX:** Golden bacon shimmer, grease sparkle burst on impact
  - **Animations:** Bacon strips snap into a shield shape, wobble when hit, crumble or fade after use
  - **Concise Visual Description:** Crossed glossy bacon strips forming a small shield badge

- **Grease Slide Trail**
  - **Category:** Utility / movement effect
  - **Theme:** Slick grease dash
  - **Specs / Effect:** Dash trail slows enemies and may stun specific targets
  - **Projectile / VFX:** Golden-brown smear trail, bubbling grease pixels, heat shimmer
  - **Animations:** Player slide streak, trail fade, enemy slip loop
  - **Concise Visual Description:** Short glossy grease streak with bright yellow highlights and darker brown edge pixels

---

## Pastry Palace Weapons

- **Croissant Cutter**
  - **Category:** Main-hand blade
  - **Theme:** Crescent pastry slicer
  - **Specs / Effect:** Quick slices; charged attack cleaves through multiple foes
  - **Projectile / VFX:** Crescent-shaped butter slash, pastry crumbs
  - **Animations:** Short diagonal slice, wide charged crescent sweep
  - **Concise Visual Description:** Golden croissant-shaped blade with toasted edges and a cream-colored handle

- **Whipped Cream Shield**
  - **Category:** Off-hand shield
  - **Theme:** Cream defense
  - **Specs / Effect:** Absorbs damage and slows nearby enemies with cream splashes
  - **Projectile / VFX:** White cream splat ring, soft puff particles
  - **Animations:** Shield inflates, jiggles on hit, splashes outward
  - **Concise Visual Description:** Round dollop shield with swirled whipped cream top and pale-blue shadow pixels

- **Baguette Maul**
  - **Category:** Two-handed heavy weapon
  - **Theme:** Bread club
  - **Specs / Effect:** Quick strikes, charged crushing blows, special shockwave knockback
  - **Projectile / VFX:** Crumb burst, ground shock ring
  - **Animations:** Overhead lift, heavy slam, bread-flex squash
  - **Concise Visual Description:** Long crusty baguette club with toasted scoring marks and reinforced butter-gold bands

- **Cake Cutter Dagger**
  - **Category:** Main-hand fast blade
  - **Theme:** Dessert knife
  - **Specs / Effect:** Light slices; charged multi-hit combo for rolling enemies
  - **Projectile / VFX:** Small frosting streaks
  - **Animations:** Rapid stab combo, spinning flourish
  - **Concise Visual Description:** Tiny triangular cake-slicer blade with frosting-pink handle

- **Frost Edge Knife**
  - **Category:** Main-hand status blade
  - **Theme:** Chilled pastry knife
  - **Specs / Effect:** Quick hit slows; charged hit briefly freezes one enemy
  - **Projectile / VFX:** Icy frosting crystals, blue-white hit spark
  - **Animations:** Crisp slash, charged frost pulse
  - **Concise Visual Description:** Silver knife with frosted blue edge and white icing detail

- **Jam Jar Grenade**
  - **Category:** Off-hand throwable
  - **Theme:** Sticky jam bomb
  - **Specs / Effect:** Small AoE slow
  - **Projectile / VFX:** Arcing red jar, glass pop, sticky red puddle
  - **Animations:** Throw arc, jar wobble, splash expansion
  - **Concise Visual Description:** Tiny jam jar with red contents, gold lid, and warning label

- **Butter Spray Can**
  - **Category:** Off-hand debuff tool
  - **Theme:** Slippery butter aerosol
  - **Specs / Effect:** Sprays nearby enemies, disables attacks or makes them slip
  - **Projectile / VFX:** Yellow mist cone, butter droplets
  - **Animations:** Spray burst, enemy slip spin
  - **Concise Visual Description:** Small yellow spray can with butter pat icon

- **Bakery Mixer Staff**
  - **Category:** Two-handed control weapon
  - **Theme:** Mixer wand staff
  - **Specs / Effect:** Quick swing, charged spin pulls enemies inward, special launches dough projectile
  - **Projectile / VFX:** Rotating dough spiral, beige dough blob
  - **Animations:** Mixer head spin-up, vacuum swirl, dough launch recoil
  - **Concise Visual Description:** Long staff capped with a shiny hand-mixer head

- **Layer Cake Greatsword**
  - **Category:** Two-handed heavy blade
  - **Theme:** Cake slab sword
  - **Specs / Effect:** Heavy swing, charged cleave, special ground shockwave
  - **Projectile / VFX:** Frosting slash arc, cake crumbs
  - **Animations:** Slow windup, wide cleave, downward cake slam
  - **Concise Visual Description:** Tall layered cake blade with frosting stripes and wafer-like handle

- **Bread Slicer**
  - **Category:** Main-hand or heavy slicing weapon
  - **Theme:** Industrial bread cutter
  - **Specs / Effect:** High-speed short-range slicing, strong against bread and pastry enemies
  - **Projectile / VFX:** Stacked slice afterimages, crumb spray
  - **Animations:** Rapid saw-blade slice, forward cutting dash
  - **Concise Visual Description:** Compact bread-saw blade with silver teeth and toasted-bread guard

- **Whipped Cream Cannon**
  - **Category:** Ranged weapon
  - **Theme:** Cream launcher
  - **Specs / Effect:** Fires cream shots that slow or cover enemies
  - **Projectile / VFX:** White cream blobs, splat decals, soft puff clouds
  - **Animations:** Pump charge, cannon recoil, cream glob arc
  - **Concise Visual Description:** Pastry piping bag mounted on a small brass cannon frame

---

## Sticky Syrup Swamp Weapons

- **Butter Knife**
  - **Category:** Main-hand blade
  - **Theme:** Slippery butter spreader
  - **Specs / Effect:** Quick slashes; charged attack applies slippery debuff
  - **Projectile / VFX:** Yellow smear trail, butter shine
  - **Animations:** Swipe, spread, enemy slide loop
  - **Concise Visual Description:** Dull silver butter knife with a glossy butter pat stuck near the tip

- **Sticky Net**
  - **Category:** Off-hand trap
  - **Theme:** Syrup net
  - **Specs / Effect:** Throws trap that immobilizes enemies
  - **Projectile / VFX:** Amber net arc, sticky splash on landing
  - **Animations:** Net toss, unfurl, enemy stuck struggle
  - **Concise Visual Description:** Honey-colored mesh net tied to a pancake-brown handle

- **Syrup Cannon**
  - **Category:** Two-handed ranged weapon
  - **Theme:** Heavy syrup artillery
  - **Specs / Effect:** Quick small syrup globs, charged syrup pool, special syrup explosion
  - **Projectile / VFX:** Amber globs, puddle decals, explosive syrup burst
  - **Animations:** Pump recoil, charge swell, cannon kickback
  - **Concise Visual Description:** Barrel-like syrup launcher with sticky drips and pancake-metal fittings

- **Honey Comb Blade**
  - **Category:** Main-hand blade
  - **Theme:** Honeycomb serrated weapon
  - **Specs / Effect:** Fast stab; charged hit coats enemies for longer slow
  - **Projectile / VFX:** Honey trail, hex sparkle particles
  - **Animations:** Stab, honey drip, sticky hit pause
  - **Concise Visual Description:** Golden honeycomb-edged blade with hex-pattern holes

- **Maple Saber**
  - **Category:** Main-hand blade
  - **Theme:** Glowing maple syrup sword
  - **Specs / Effect:** Quick slashes; charged slicing arc cuts through syrup golems
  - **Projectile / VFX:** Amber crescent arc, maple shine
  - **Animations:** Saber swipe, charged arc release
  - **Concise Visual Description:** Translucent maple-orange saber with dark syrup handle

- **Sugar Cube Bomb**
  - **Category:** Off-hand throwable
  - **Theme:** Crystallized sugar bomb
  - **Specs / Effect:** Hardens syrup and freezes or locks enemies in place
  - **Projectile / VFX:** White cube bounce, crystal burst
  - **Animations:** Toss, cube crack, sugar crust spreading
  - **Concise Visual Description:** Chunky white sugar cube with sparkle pixels and fuse dot

- **Sticky Syrup Globe**
  - **Category:** Off-hand throwable
  - **Theme:** Syrup trap orb
  - **Specs / Effect:** Explodes into sticky traps that hold enemies
  - **Projectile / VFX:** Amber orb splat, circular sticky puddle
  - **Animations:** Lob, wobble, syrup ring expansion
  - **Concise Visual Description:** Glossy round syrup bubble with dark caramel outline

- **Molasses Mallet**
  - **Category:** Two-handed heavy weapon
  - **Theme:** Dense syrup hammer
  - **Specs / Effect:** Overhead smash, charged syrup pool, special explosive trap impact
  - **Projectile / VFX:** Dark molasses splash, ground crack, sticky crater
  - **Animations:** Slow lift, heavy drop, recoil bounce
  - **Concise Visual Description:** Oversized dark-brown mallet with dripping molasses head

- **Caramel Whip**
  - **Category:** Two-handed reach weapon
  - **Theme:** Elastic caramel lash
  - **Specs / Effect:** Sweep enemies, charged pull, special caramel wave knockback
  - **Projectile / VFX:** Caramel ribbon arc, sticky wave
  - **Animations:** Whip snap, pull reel, wave lash
  - **Concise Visual Description:** Long glossy caramel strand coiled around a short handle

- **Syrup Launcher**
  - **Category:** Ranged weapon
  - **Theme:** Portable syrup sprayer
  - **Specs / Effect:** Medium-range syrup shots that slow or leave puddles
  - **Projectile / VFX:** Smaller syrup blobs than Syrup Cannon
  - **Animations:** Shoulder-fire recoil, syrup drip reload
  - **Concise Visual Description:** Compact syrup bottle launcher with pump nozzle

---

## Kitchen Mayhem Weapons

- **Chef's Cleaver**
  - **Category:** Main-hand blade
  - **Theme:** Kitchen chopping weapon
  - **Specs / Effect:** Quick swings; charged attack creates chopping wave
  - **Projectile / VFX:** Silver chop arc, cutting-board impact line
  - **Animations:** Short chop, charged overhead cleave
  - **Concise Visual Description:** Broad metal cleaver with wooden handle and reflective blade pixels

- **Hot Lid**
  - **Category:** Off-hand shield
  - **Theme:** Pan-lid parry
  - **Specs / Effect:** Blocks damage and pushes enemies back when hit
  - **Projectile / VFX:** Steam puff, metal clang spark
  - **Animations:** Raise lid, recoil bounce, parry shove
  - **Concise Visual Description:** Round gray pot lid with orange heat glow underneath

- **Rolling Pin Roller**
  - **Category:** Two-handed rolling weapon
  - **Theme:** Rolling pin ram
  - **Specs / Effect:** Fast roll, charged flattening attack, special massive knockback
  - **Projectile / VFX:** Dust trail, flattened enemy squash effect
  - **Animations:** Roll forward, charge windup, impact bounce
  - **Concise Visual Description:** Large wooden rolling pin with metal handles

- **Paring Knife**
  - **Category:** Main-hand fast blade
  - **Theme:** Close-range precision knife
  - **Specs / Effect:** Quick slices; charged stab deals high single-target damage
  - **Projectile / VFX:** Tiny silver glints
  - **Animations:** Quick jab combo, forward lunge
  - **Concise Visual Description:** Small sharp kitchen knife with dark handle and bright highlight

- **Chef's Skewer**
  - **Category:** Main-hand piercing weapon
  - **Theme:** Long metal skewer
  - **Specs / Effect:** Safe-range stabs; charged throw impales enemies
  - **Projectile / VFX:** Straight silver projectile, impact pin effect
  - **Animations:** Thrust, aim pose, thrown spin
  - **Concise Visual Description:** Thin metal skewer with red handle cap

- **Pepper Grinder**
  - **Category:** Off-hand debuff item
  - **Theme:** Pepper cloud
  - **Specs / Effect:** Blinds enemies temporarily
  - **Projectile / VFX:** Black-gray pepper dust cone/cloud
  - **Animations:** Crank twist, dust puff, enemy eye-squint loop
  - **Concise Visual Description:** Wooden pepper mill with dark pepper particles at nozzle

- **Hot Sauce Flask**
  - **Category:** Off-hand throwable
  - **Theme:** Fire sauce bomb
  - **Specs / Effect:** Burn damage over time
  - **Projectile / VFX:** Red bottle arc, orange flame splash
  - **Animations:** Throw, bottle burst, fire tick flicker
  - **Concise Visual Description:** Small red hot sauce bottle with flame label

- **Stock Pot Shield**
  - **Category:** Two-handed defensive weapon
  - **Theme:** Huge cooking pot
  - **Specs / Effect:** Shield bash, charged spin knockback, special stun slam
  - **Projectile / VFX:** Metal ring wave, steam burst
  - **Animations:** Bash, pot spin, downward slam
  - **Concise Visual Description:** Oversized steel stock pot held sideways like a shield

- **Chopping Board Axe**
  - **Category:** Two-handed heavy weapon
  - **Theme:** Cutting-board axe
  - **Specs / Effect:** Chopping strike, charged multi-enemy cleave, special shockwave
  - **Projectile / VFX:** Wood chip burst, chop arc
  - **Animations:** Axe swing, board slam, ground wave
  - **Concise Visual Description:** Cutting board mounted as an axe blade with a cleaver edge

- **Dishwasher Sprayer**
  - **Category:** Ranged utility weapon
  - **Theme:** High-pressure water sprayer
  - **Specs / Effect:** Pushes enemies back and neutralizes flying kitchen hazards
  - **Projectile / VFX:** Blue-white water jet, splash impact
  - **Animations:** Hose recoil, spray loop, mist fade
  - **Concise Visual Description:** Silver dish sprayer nozzle with flexible black hose

- **Rolling Pin**
  - **Category:** Main-hand or two-handed blunt weapon
  - **Theme:** Simple rolling pin weapon
  - **Specs / Effect:** Blunt hits, stun, or shove
  - **Projectile / VFX:** Small dust puffs
  - **Animations:** Swing, roll jab, charged bonk
  - **Concise Visual Description:** Compact wooden rolling pin with bright edge highlights

---

## Egg Factory Frenzy Weapons

- **Egg Beater**
  - **Category:** Main-hand spinning weapon
  - **Theme:** Handheld beater
  - **Specs / Effect:** Quick spinning attacks; charged attack stuns enemies
  - **Projectile / VFX:** Circular whisk blur, yolk flecks
  - **Animations:** Spin-up, hit loop, stun spark
  - **Concise Visual Description:** Small metal egg beater with twin rotating loops

- **Yolk Bomb**
  - **Category:** Off-hand throwable
  - **Theme:** Yolk explosive
  - **Specs / Effect:** Slows and damages on impact
  - **Projectile / VFX:** Yellow bomb arc, yolk puddle splash
  - **Animations:** Toss, wobble, splat burst
  - **Concise Visual Description:** Round yolk-filled bomb with cracked eggshell casing

- **Frying Pan**
  - **Category:** Two-handed heavy weapon
  - **Theme:** Massive pan
  - **Specs / Effect:** Quick slams, charged overhead smash, special AoE shockwave
  - **Projectile / VFX:** Black pan impact ring, eggy splatter
  - **Animations:** Pan swing, overhead windup, ground slam
  - **Concise Visual Description:** Oversized black frying pan with yolk-yellow highlights

- **Eggshell Knife**
  - **Category:** Main-hand light blade
  - **Theme:** Cracked eggshell dagger
  - **Specs / Effect:** Stab; charged hit cracks enemies open and stuns
  - **Projectile / VFX:** Shell shard spark
  - **Animations:** Jab, crack-hit pause, stun flash
  - **Concise Visual Description:** Jagged white eggshell blade with yellow handle

- **Egg Scrambler Blade**
  - **Category:** Main-hand spinning blade
  - **Theme:** Egg-scrambler cutter
  - **Specs / Effect:** Spin damage; charged spin creates AoE
  - **Projectile / VFX:** Circular yellow-white blur, yolk spiral
  - **Animations:** Blade spin, rapid charge, AoE whirl
  - **Concise Visual Description:** Short sword with rotating whisk-like blade head

- **Salt Shaker**
  - **Category:** Off-hand debuff item
  - **Theme:** Drying salt burst
  - **Specs / Effect:** Drains health over time or weakens yolk enemies
  - **Projectile / VFX:** White salt spray, sparkle dust
  - **Animations:** Shake, salt cone, enemy dry-out flicker
  - **Concise Visual Description:** Small silver-top salt shaker with white pixel grains

- **Egg Yolk Grenade**
  - **Category:** Off-hand throwable
  - **Theme:** Slippery yolk grenade
  - **Specs / Effect:** Creates slippery area and knocks enemies down
  - **Projectile / VFX:** Yellow splat puddle, slip stars
  - **Animations:** Throw, pop, puddle spread
  - **Concise Visual Description:** Cracked egg grenade with exposed orange yolk core

- **Omelet Spatula**
  - **Category:** Two-handed flipping weapon
  - **Theme:** Giant spatula
  - **Specs / Effect:** Flips single or multiple enemies; special knockback shockwave
  - **Projectile / VFX:** Flip arc, white motion streak
  - **Animations:** Scoop, flip, slam
  - **Concise Visual Description:** Oversized metal spatula with black handle and yolk stains

- **Egg Beater Staff**
  - **Category:** Two-handed staff
  - **Theme:** Long staff with spinning beaters
  - **Specs / Effect:** Quick spin damage, charged yolk explosion, special AoE scramble
  - **Projectile / VFX:** Spinning egg rings, yellow burst
  - **Animations:** Staff twirl, spin charge, scramble explosion
  - **Concise Visual Description:** Long pole tipped with rotating whisk blades

- **Egg Whisk**
  - **Category:** Main-hand or two-handed spinning counter weapon
  - **Theme:** Compact whisk
  - **Specs / Effect:** Scrambles egg drones and yolk bombs; charged AoE spin
  - **Projectile / VFX:** White/yellow spiral, cracked shell particles
  - **Animations:** Rapid spin loop, charged whirl
  - **Concise Visual Description:** Metal balloon whisk with yellow handle and egg splatter

- **Egg Launcher**
  - **Category:** Ranged weapon
  - **Theme:** Egg cannon
  - **Specs / Effect:** Cracks boss defenses and damages enemies
  - **Projectile / VFX:** Egg projectile, shell-crack explosion
  - **Animations:** Load egg, recoil shot, shell pop
  - **Concise Visual Description:** Chunky egg-carton launcher with hazard stripes and egg chamber

---

## Citrus Cascade Weapons

- **Orange Zester**
  - **Category:** Main-hand blade/tool
  - **Theme:** Citrus grater cutter
  - **Specs / Effect:** Fast acidic cuts; charged attack blinds enemies
  - **Projectile / VFX:** Orange zest sparks, acid droplets
  - **Animations:** Rapid scrape, charged zest flash
  - **Concise Visual Description:** Small zester blade with orange handle and grated peel bits

- **Juice Squeezer**
  - **Category:** Off-hand utility item
  - **Theme:** Citrus press
  - **Specs / Effect:** Creates slippery patches that trip enemies
  - **Projectile / VFX:** Juice squirt, yellow puddle
  - **Animations:** Squeeze press, juice spray, puddle spread
  - **Concise Visual Description:** Handheld lemon squeezer with lime-green hinge

- **Citrus Blaster**
  - **Category:** Two-handed ranged weapon
  - **Theme:** Juice cannon
  - **Specs / Effect:** Quick acidic streams, charged AoE splash, special pushes enemies back
  - **Projectile / VFX:** Orange juice beam, splash cone, pushback wave
  - **Animations:** Stream fire, charge bulb swelling, blast recoil
  - **Concise Visual Description:** Bright orange-and-lime blaster with juicer nozzle

- **Citrus Saber**
  - **Category:** Main-hand blade
  - **Theme:** Acid saber
  - **Specs / Effect:** Acidic slashes; charged attack creates acid spray
  - **Projectile / VFX:** Lime-orange slash arc, acid mist
  - **Animations:** Saber swipe, charged spray release
  - **Concise Visual Description:** Glowing citrus-colored saber with transparent juice blade

- **Peeler Knife**
  - **Category:** Main-hand status blade
  - **Theme:** Citrus peeler
  - **Specs / Effect:** Quick slices; charged hit applies peeling damage-over-time
  - **Projectile / VFX:** Curling peel trail
  - **Animations:** Slice, peel-strip curl, debuff tick
  - **Concise Visual Description:** Curved peeler knife with orange peel ribbon wrapped around it

- **Zest Grenade**
  - **Category:** Off-hand throwable
  - **Theme:** Citrus spray bomb
  - **Specs / Effect:** Blinds and damages enemies
  - **Projectile / VFX:** Burst of zest shards and juice mist
  - **Animations:** Toss, flash-pop, blind stars
  - **Concise Visual Description:** Small orange grenade with lemon-slice pin

- **Lime Shield**
  - **Category:** Off-hand shield
  - **Theme:** Lime rind defense
  - **Specs / Effect:** Absorbs damage and sprays lime juice when struck; reduces enemy attack speed
  - **Projectile / VFX:** Green juice counter-splash
  - **Animations:** Shield raise, sour spray, wobble
  - **Concise Visual Description:** Round lime-slice shield with rind border and juicy segments

- **Juicer Staff**
  - **Category:** Two-handed staff
  - **Theme:** Crushing juicer polearm
  - **Specs / Effect:** Crush attack, charged juice wave, special all-direction acid spray
  - **Projectile / VFX:** Juice ripple wave, radial droplets
  - **Animations:** Staff press, wave release, spin spray
  - **Concise Visual Description:** Long staff topped with metal citrus press

- **Orange Flail**
  - **Category:** Two-handed heavy weapon
  - **Theme:** Spiked orange flail
  - **Specs / Effect:** Swing damage, charged orange projectile, special pulp slow field
  - **Projectile / VFX:** Spinning orange ball, pulp splatter
  - **Animations:** Chain spin, launch, pulp spread
  - **Concise Visual Description:** Spiked orange fruit ball on chain with green handle

- **Zester Shooter**
  - **Category:** Ranged weapon
  - **Theme:** High-speed zest gun
  - **Specs / Effect:** Fires zest to blind enemies and neutralize juice hazards
  - **Projectile / VFX:** Thin orange peel darts, hazard-drying sparkle
  - **Animations:** Rapid shots, reload shake, peel streaks
  - **Concise Visual Description:** Compact grater-gun with orange peel ammo strip

---

## Candy Chaos Weapons

- **Lollipop Blade**
  - **Category:** Main-hand blade
  - **Theme:** Candy sword
  - **Specs / Effect:** Quick candy slices; charged attack creates sticky traps
  - **Projectile / VFX:** Pink sugar slash, sticky candy puddle
  - **Animations:** Slice, charged spin, trap drop
  - **Concise Visual Description:** Sharpened lollipop disc on a candy-stick handle

- **Sugar Shield**
  - **Category:** Off-hand shield
  - **Theme:** Sugar crystal defense
  - **Specs / Effect:** Blocks attacks and releases sugar bursts when struck
  - **Projectile / VFX:** White crystal burst, sparkle ring
  - **Animations:** Shield raise, crackle impact, burst pulse
  - **Concise Visual Description:** Translucent sugar-crystal shield with candy-red rim

- **Candy Floss Launcher**
  - **Category:** Two-handed ranged weapon
  - **Theme:** Cotton candy cloud gun
  - **Specs / Effect:** Quick sticky bursts, charged sticky explosions, special candy storm
  - **Projectile / VFX:** Pink-blue fluff clouds, sticky cloud linger
  - **Animations:** Fluff charge, cannon puff, storm swirl
  - **Concise Visual Description:** Cotton-candy cannon with spinning sugar drum

- **Gum Blade**
  - **Category:** Main-hand sticky blade
  - **Theme:** Chewing gum sword
  - **Specs / Effect:** Quick slash; charged attack immobilizes enemies
  - **Projectile / VFX:** Stretchy gum trail, bubble pop
  - **Animations:** Elastic slash, gum pullback, enemy stuck loop
  - **Concise Visual Description:** Glossy pink gum blade stretched over a small handle

- **Candy Cane Dagger**
  - **Category:** Main-hand fast blade
  - **Theme:** Hooked candy dagger
  - **Specs / Effect:** Quick stabs; charged spin hits nearby enemies
  - **Projectile / VFX:** Red-white spiral streak
  - **Animations:** Stab combo, candy spin
  - **Concise Visual Description:** Sharpened candy cane hook with peppermint stripes

- **Chocolate Bomb**
  - **Category:** Off-hand throwable
  - **Theme:** Chocolate explosive
  - **Specs / Effect:** AoE slow
  - **Projectile / VFX:** Brown chocolate splash, bubbling puddle
  - **Animations:** Toss, melt-pop, slow puddle spread
  - **Concise Visual Description:** Round chocolate truffle bomb with fuse sprinkle

- **Sugar Rush Injector**
  - **Category:** Off-hand buff item
  - **Theme:** Candy syringe
  - **Specs / Effect:** Temporarily boosts player attack speed
  - **Projectile / VFX:** Sugar sparkle aura, speed streaks
  - **Animations:** Quick inject, player flash, faster attack afterimages
  - **Concise Visual Description:** Candy-colored injector filled with glowing sugar syrup

- **Marshmallow Launcher**
  - **Category:** Two-handed ranged weapon
  - **Theme:** Marshmallow cannon
  - **Specs / Effect:** Fires sticky marshmallows; charged fires multiple; special detonates stuck marshmallows
  - **Projectile / VFX:** White marshmallow blobs, sticky attach decals, puff explosion
  - **Animations:** Single shot, multi-shot burst, detonation snap
  - **Concise Visual Description:** Soft candy launcher with marshmallow ammo tube

- **Candy Floss Hammer**
  - **Category:** Two-handed heavy weapon
  - **Theme:** Cotton candy hammer
  - **Specs / Effect:** Heavy smash, AoE swing, sticky explosion
  - **Projectile / VFX:** Fluff burst, sugar dust
  - **Animations:** Slow windup, wide swing, sticky slam
  - **Concise Visual Description:** Huge cotton-candy mallet head on striped stick

- **Lollipop Hammer**
  - **Category:** Two-handed heavy weapon
  - **Theme:** Giant lollipop crusher
  - **Specs / Effect:** Crushes gummy enemies, safely flings cupcake bombs
  - **Projectile / VFX:** Candy crack burst, sticky hit splat
  - **Animations:** Overhead smash, scoop-and-fling, heavy recoil
  - **Concise Visual Description:** Oversized round lollipop head with glossy red swirl and thick stick handle

- **Gummy Bear Grenade**
  - **Category:** Off-hand throwable
  - **Theme:** Gummy explosive
  - **Specs / Effect:** Bouncy grenade that bursts into sticky candy damage
  - **Projectile / VFX:** Bouncing gummy bear, colored gel explosion
  - **Animations:** Throw, bounce squash, gummy splat
  - **Concise Visual Description:** Small translucent gummy bear with angry face and fuse sparkle

---

## Bakery Bonanza Weapons

- **Dough Cutter**
  - **Category:** Main-hand blade
  - **Theme:** Bakery scraper
  - **Specs / Effect:** Fast cuts; charged attack creates flying dough slashes
  - **Projectile / VFX:** Beige dough crescent, flour dust
  - **Animations:** Scrape slash, charged dough wave
  - **Concise Visual Description:** Rectangular metal dough scraper with wooden handle

- **Flour Puff**
  - **Category:** Off-hand debuff item
  - **Theme:** Flour cloud
  - **Specs / Effect:** Creates cloud that blinds and slows enemies
  - **Projectile / VFX:** White dust cloud, visibility fade
  - **Animations:** Pouch squeeze, puff expansion, enemy cough loop
  - **Concise Visual Description:** Small flour pouch with tied top and white powder trail

- **Bread Roller**
  - **Category:** Two-handed heavy weapon
  - **Theme:** Bakery roller
  - **Specs / Effect:** Quick rolling attacks, charged flattening rolls, special spin knockback
  - **Projectile / VFX:** Crumb trail, squash impact
  - **Animations:** Forward roll, charged flatten, spin burst
  - **Concise Visual Description:** Thick bread-textured roller with golden crust ends

- **Rolling Pin Blade**
  - **Category:** Main-hand hybrid weapon
  - **Theme:** Rolling pin with blade edge
  - **Specs / Effect:** Spinning quick attack; charged stun
  - **Projectile / VFX:** Wooden spin blur, stun stars
  - **Animations:** Twirl, bonk, stun flash
  - **Concise Visual Description:** Short rolling pin with hidden metal edge

- **Dough Hook**
  - **Category:** Main-hand hook weapon
  - **Theme:** Mixer dough hook
  - **Specs / Effect:** Hooks and damages; charged pull brings enemies toward player
  - **Projectile / VFX:** Curved hook trail, pull line
  - **Animations:** Hook swipe, latch, reel-in
  - **Concise Visual Description:** Silver spiral dough hook with bakery-machine handle

- **Flour Cloud Bomb**
  - **Category:** Off-hand throwable
  - **Theme:** Flour smoke bomb
  - **Specs / Effect:** Blinds enemies and reduces accuracy
  - **Projectile / VFX:** White flour explosion, dust linger
  - **Animations:** Throw, powder pop, cloud drift
  - **Concise Visual Description:** Tied flour sack bomb with powder leaking from seams

- **Dough Ball Trap**
  - **Category:** Off-hand trap
  - **Theme:** Sticky dough snare
  - **Specs / Effect:** Immobilizes enemies
  - **Projectile / VFX:** Beige dough splat, sticky strands
  - **Animations:** Lob, bounce, flatten into trap
  - **Concise Visual Description:** Round dough ball with flour-dusted top

- **Oven Door Shield**
  - **Category:** Two-handed shield
  - **Theme:** Heavy oven door
  - **Specs / Effect:** Shield bash, charged multi-enemy knockback, special fire shockwave
  - **Projectile / VFX:** Orange heat wave, metal clang
  - **Animations:** Bash, door slam, fire pulse
  - **Concise Visual Description:** Large dark oven door with glowing orange window

- **Dough Roller Staff**
  - **Category:** Two-handed staff
  - **Theme:** Roller-on-pole
  - **Specs / Effect:** Rolls over enemies, charged flattening, special AoE spin
  - **Projectile / VFX:** Dough spiral, flour ring
  - **Animations:** Staff roll, windup, spinning sweep
  - **Concise Visual Description:** Long staff with cylindrical dough roller head

- **Dough Roller**
  - **Category:** Heavy rolling weapon
  - **Theme:** Industrial dough flattener
  - **Specs / Effect:** Flattens enemies, clears flour puffs, stuns rolling muffin trays
  - **Projectile / VFX:** Flatten squash, flour-clearing gust
  - **Animations:** Push roll, heavy press, tray-stun impact
  - **Concise Visual Description:** Larger wheeled bakery roller with dough stuck to the cylinder

- **Flour Blaster**
  - **Category:** Ranged weapon
  - **Theme:** Pressurized flour cannon
  - **Specs / Effect:** Fires flour bursts that blind, reveal safe lanes, or clear visual hazards
  - **Projectile / VFX:** White powder shot, lingering cloud cone
  - **Animations:** Pump charge, flour blast, nozzle recoil
  - **Concise Visual Description:** Compact flour sack mounted to a metal blower nozzle

---

## Implementation Notes for Later GDScript Planning

- Each weapon can be represented with a shared weapon data structure containing category, attack types, cooldown placeholder, projectile scene reference, status effect tags, and VFX scene references.
- Main-hand weapons generally need `quick_attack()` and `charged_attack()`.
- Off-hand items generally need `use_item()` or `utility_attack()`.
- Two-handed weapons generally need `quick_attack()`, `charged_attack()`, and `special_attack()`.
- Projectile weapons should define projectile scene, speed, lifetime, hitbox behavior, impact VFX, and status effect application.
- Melee weapons should define hitbox shape, active frames, swing arc, impact VFX, and knockback logic.
- Status weapons should define effect type, duration, stacking rules, immunity rules, and visual overlay.
- Shield weapons should define block angle or radius, absorbed damage behavior, parry behavior, impact animation, and break/fade state.
