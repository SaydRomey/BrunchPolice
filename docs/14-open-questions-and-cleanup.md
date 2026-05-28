# Open Questions and Cleanup

# 19. Current Design Conflicts / Cleanup Queue

| Area                 | Conflict                                                                | Current Treatment                                                      |
| -------------------- | ----------------------------------------------------------------------- | ---------------------------------------------------------------------- |
| Boss names           | Legacy gendered names vs inclusive names                                | Inclusive names are canonical; legacy names kept for reference only    |
| Casey title          | Cutlery Thief vs Cutlery Carl                                           | Canonical title should be Cutlery Thief; Cutlery Carl kept legacy      |
| Evidence             | Several levels have empty evidence sections                             | Preserve as `TBD Evidence`; do not delete                              |
| Weapon taxonomy      | Some weapons appear as power-ups, temporary weapons, and reward weapons | Keep all; mark duplicates as `Needs merge`                             |
| Visual styles        | Character sprites are pixel art; level refs are painterly/cartoon       | Treat as concept references until final art style guide is defined     |
| Boss variants        | Multiple possible boss sprites for Kitchen and Syrup                    | Keep all as variants until selected                                    |
| Grease Canyon reward | Bacon Gun is critical but reward/progression placement unclear          | Mark `Needs progression decision`                                      |
| Enemy vs hazard      | Frying pans, rolling pins, ladles can be enemies or hazards             | Preserve both interpretations until implementation taxonomy is defined |

---


# 17. Additional / Future Level Ideas Already Present

These are not part of the eight-level current roster but must not be lost.

## 17.1 Back Alley / Garbage Bin / Street Theme

- Culprit smuggles food in closed trash containers to retrieve later.
- Trash can parkour.

## 17.2 Street / Alley / Road Levels

- Enemies:
  - Small angry pigs.
  - Traffic obstacles.
  - Food trucks.
- Hazards:
  - Slippery oil spills.
  - Falling food debris.
- Power-ups:
  - Bacon grease slide.
  - Syrup stickiness for temporary wall climbing.

## 17.3 Toilet / Pipes Levels

- Enemies:
  - Germ monsters.
  - Toilet paper snakes.
- Hazards:
  - Overflowing toilets.
  - Gushing water pipes.
- Power-ups:
  - Plunger jump.
  - Sanitizer spray that clears enemies.

## 17.4 General Kitchen Level Ideas

- Enemies:
  - Angry chefs.
  - Rolling pins.
  - Knife-throwing sous chefs.
- Hazards:
  - Hot stoves.
  - Falling pots and pans.
- Power-ups:
  - Shield of Cutlery.
  - Dish Soap Speed Boost.

---


# 20. Recommended Next Reorganization Pass

The next document pass should split this inventory into clean working docs without losing any content:

1. `00-master-index.md`
2. `01-core-game-loop.md`
3. `02-investigation-system.md`
4. `03-dialogue-system.md`
5. `04-interaction-system.md`
6. `05-player-combat-health.md`
7. `06-weapons-index.md`
8. `07-powerups-and-status-effects.md`
9. `08-enemy-taxonomy.md`
10. `09-boss-index.md`
11. `10-levels/grease-canyon.md`
12. `10-levels/pastry-palace.md`
13. `10-levels/sticky-syrup-swamp.md`
14. `10-levels/kitchen-mayhem.md`
15. `10-levels/candy-chaos.md`
16. `10-levels/egg-factory-frenzy.md`
17. `10-levels/citrus-cascade.md`
18. `10-levels/bakery-bonanza.md`
19. `11-inclusion-and-representation.md`
20. `12-visual-style-guide.md`
21. `13-implementation-architecture.md`
22. `14-open-questions-and-cleanup.md`

---


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
