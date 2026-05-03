# Master Index

**Status:** Reorganized working document set generated from `master-brunch-police-design-inventory.md`.

## Document Map

1. [`01-core-game-loop.md`](01-core-game-loop.md)
2. [`02-investigation-system.md`](02-investigation-system.md)
3. [`03-dialogue-system.md`](03-dialogue-system.md)
4. [`04-interaction-system.md`](04-interaction-system.md)
5. [`05-player-combat-health.md`](05-player-combat-health.md)
6. [`06-weapons-index.md`](06-weapons-index.md)
7. [`07-powerups-and-status-effects.md`](07-powerups-and-status-effects.md)
8. [`08-enemy-taxonomy.md`](08-enemy-taxonomy.md)
9. [`09-boss-index.md`](09-boss-index.md)
10. [`10-levels/grease-canyon.md`](10-levels/grease-canyon.md)
11. [`10-levels/pastry-palace.md`](10-levels/pastry-palace.md)
12. [`10-levels/sticky-syrup-swamp.md`](10-levels/sticky-syrup-swamp.md)
13. [`10-levels/kitchen-mayhem.md`](10-levels/kitchen-mayhem.md)
14. [`10-levels/candy-chaos.md`](10-levels/candy-chaos.md)
15. [`10-levels/egg-factory-frenzy.md`](10-levels/egg-factory-frenzy.md)
16. [`10-levels/citrus-cascade.md`](10-levels/citrus-cascade.md)
17. [`10-levels/bakery-bonanza.md`](10-levels/bakery-bonanza.md)
18. [`11-inclusion-and-representation.md`](11-inclusion-and-representation.md)
19. [`12-visual-style-guide.md`](12-visual-style-guide.md)
20. [`13-implementation-architecture.md`](13-implementation-architecture.md)
21. [`14-open-questions-and-cleanup.md`](14-open-questions-and-cleanup.md)

## Source and Identity

## 0. Source Coverage

This inventory consolidates material from the current project files and newly added implementation files:

### Core Design Files
- `README.md`
- `game-design-doc.md`
- `character-and-level-design.md`
- `interaction-system.md`
- `dialogue-system.md`
- `lgbtq+.md`

### Level Files
- `grease-canyon.md`
- `pastry-palace.md`
- `sticky-syrup-swamp.md`
- `kitchen-mayhem.md`
- `candy-chaos.md`
- `egg-factory-frenzy.md`
- `citrus-cascade.md`
- `bakery-bonanza.md`

### Weapon Files
- `weapons.md`
- `weapons-bacon-gun.md`
- `weapons-level-reward.md`
- `weapons-level-specific.md`

### Combat / AI / Implementation Files
- `visual-feedback.md`
- `projectile-manager.md`
- `invincibility-frames.md`
- `health-component.md`
- `damage-calculation.md`
- `enemy-states.md`
- `enemy-spawner.md`
- `enemy-ai-specific-examples.md`
- `enemy-ai-movement.md`
- `enemy-ai-environment-interactions.md`

### Visual Reference Inputs From Conversation
The concept images supplied in the chat are treated as current visual reference material. They are assigned below by level.

---


## 1. Canonical Game Identity

| Field | Current Canonical Value |
|---|---|
| Game Title | **Brunch Police** |
| Genre | Action-adventure with platforming and investigative elements |
| Hub Style | Isometric / top-down brunch buffet hub |
| Level Style | 2D side-scrolling platformer levels |
| Engine | Godot |
| Programming Direction | Godot + C++ / GDNative-style architecture from current docs |
| Tone | Quirky, humorous, lighthearted, food-themed |
| Visual Direction | Bright cartoon/pixel hybrid, exaggerated food props, wacky platform environments |
| Audio Direction | Relaxing brunch hub music; faster quirky level music; food splats, sizzling grease, dialogue snippets |

---


## 4. Current Level Roster Overview

| Order | Level | Canonical Culprit | Crime | Primary Fantasy |
|---:|---|---|---|---|
| 1 | Grease Canyon | Bailey “Bacon Bandit” Brown | Takes an entire plate of bacon | Bacon platforms, grease pits, pig enemies, bacon tornado |
| 2 | Pastry Palace | Cameron “Croissant Crook” Cline | Sneaks croissants into their purse | Croissant platforms, dough mixers, pastries, sticky syrup |
| 3 | Sticky Syrup Swamp | Skyler “Syrup Scoundrel” Sugars | Dumps syrup all over the buffet | Syrup waterfalls, pancake rafts, bees, syrup cannon |
| 4 | Kitchen Mayhem | Casey “Cutlery Thief” Canes | Steals forks, spoons, and knives | Back-kitchen chaos, knives, pots, pans, chefs |
| 5 | Candy Chaos | Drew “Dessert Hoarder” Sweet | Hoards all desserts at the buffet | Candy bridges, chocolate lava, gumdrops, rolling cake |
| 6 | Egg Factory Frenzy | Morgan “Omelet Overlord” Eggman | Takes all the eggs for a giant omelet | Conveyors, yolk traps, chickens, egg machines |
| 7 | Citrus Cascade | Jordan “Juice Jacker” Squeeze | Steals all orange juice bottles | Juice waterfalls, citrus platforms, juicers, lemon bats |
| 8 | Bakery Bonanza | Quinn “Muffin Mastermind” Munch | Hides muffins in their hat | Ovens, dough platforms, flour clouds, muffin enemies |

---


## Preservation Checklist

# 21. Canonical Preservation Checklist

Before adding new mechanics, verify the following remain represented:

- [ ] All eight current levels.
- [ ] All canonical inclusive boss names.
- [ ] All legacy names retained only as reference.
- [ ] All crimes.
- [ ] All level elements.
- [ ] All enemies.
- [ ] All hazards.
- [ ] All boss mechanics.
- [ ] All power-ups.
- [ ] All weapons from `weapons.md`.
- [ ] All temporary level weapons.
- [ ] All level reward weapons.
- [ ] Bacon Gun special rules.
- [ ] Evidence items and TBD evidence gaps.
- [ ] Hub investigation loop.
- [ ] Dialogue system.
- [ ] Interaction system.
- [ ] Health component.
- [ ] Damage calculation.
- [ ] I-frames.
- [ ] Visual feedback blinking.
- [ ] Projectile manager.
- [ ] Enemy states.
- [ ] Enemy spawner.
- [ ] Enemy AI movement.
- [ ] Enemy environment interactions.
- [ ] LGBTQ+ inclusion ideas.
- [ ] Other/future level ideas.
- [ ] Visual reference assignments.

---
