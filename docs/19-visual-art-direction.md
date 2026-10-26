# Visual Art Direction and Animation

## Primary look

Bright, characterful pixel art with deliberate silhouettes and physical-food materials: flaky pastry, glossy syrup, copper, metal, porcelain, fizzing citrus, sizzling grease and dusty flour. Lighting supports depth but does not blur functional collision surfaces. Pixel sprites use nearest-neighbor filtering and a consistent pixel scale.

## Visual grammar

| Gameplay role | Visual treatment |
|---|---|
| Solid platform | Strong upper contour and material-readable surface |
| Collapsing platform | Visible warning deformation/cracks before state change |
| Damaging area | Contrasting edge, active warning motion, sound cue |
| Launcher | Clear direction arrow/nozzle and repeated pulse animation |
| Interactable | Outlined focus, icon/verb prompt, activation response |
| Weak point | Strong exposed-state contrast, reaction and recovery cue |
| Collectible evidence | Case-tag silhouette and identifiable sparkle/outline |
| NPC | Recognizable silhouette, portrait expression variants |

## World palette anchors

Grease: bacon red, warm orange, gold. Pastry: cream, frosting pink, baked browns. Syrup: amber, caramel, moss green. Kitchen: porcelain white, steel gray, stove orange. **Caffeine: espresso `#251A18`, copper `#C98447`, foam `#FFF1D5`, teal `#5A938C`, warning red `#C45E45`.** Egg: white shell, yolk yellow, factory metal. Citrus: orange/lime, fresh teal, juice gold. Bakery: crust brown, oven heat orange, flour white.

## Animation delivery

Sprite sheet should document frame size, pivot, intended FPS, state naming, anticipation/active/recovery intervals, loop behavior and hit/VFX events. All combat animations expose a reproducible hit frame. Effects never cover a required jump landing silhouette for an extended period. UI decorative animation is independent of game-state feedback.

## Level 5 machinery

Caffeine Craze uses a mechanically coherent **coffee shop → enormous espresso engine** progression. Copper pipes, pressure gauges, giant mugs, milk-foam platforms, grinder drums, valve handles and different nozzle directions must visually communicate function. Pressure phases use gauge needle position, vibration and a pulsing shape pattern besides warm warning colors.
