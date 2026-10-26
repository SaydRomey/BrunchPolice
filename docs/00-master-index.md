# Brunch Police — Master Documentation Index

> **Official game specification · Edition 1.0 · Godot 4 / GDScript**
>
> This index defines the authoritative game structure, names, level order, 
> system boundaries, and required integration contracts.  
> 
> Specifications are authoritative design targets; 
> engineering completion is tracked separately by acceptance tests.

## Game identity

| Field                | Specification                                                                                                 |
| -------------------- | ------------------------------------------------------------------------------------------------------------- |
| Title                | **Brunch Police**                                                                                             |
| Genre                | Comic action-adventure, social investigation, and precision 2D platforming                                    |
| World structure      | Isometric/top-down buffet investigation hub → side-view chase level → boss → hub resolution                   |
| Engine and scripting | Godot 4.x, GDScript, scenes (`.tscn`) and reusable data resources (`.tres`)                                   |
| Core pillars         | Readable platforming, evidence-based accusations, food-themed combat, expressive encounters, reusable content |
| Tone                 | Whimsical, slapstick, readable, affirming; mischief rather than cruelty                                       |
| Art                  | Crisp pixel-art sprites, bold silhouettes, food-material color coding, receipt/clipboard UI                   |
| Saves                | Versioned, slot-based, cross-world game state; checkpoint-local respawn                                       |
| Naming               | Culprits use gender-neutral given names and singular they/them by default                                     |

## Eight worlds

| #   | World              | Culprit                         | Signature play                          | Design file                                 |
| --- | ------------------ | ------------------------------- | --------------------------------------- | ------------------------------------------- |
| 1   | Grease Canyon      | Bailey “Bacon Bandit” Brown     | Hot grease, ropes, bacon tornado        | [World 01](worlds/01-grease-canyon.md)      |
| 2   | Pastry Palace      | Cameron “Croissant Crook” Cline | Mixers, frosting, pastry cover          | [World 02](worlds/02-pastry-palace.md)      |
| 3   | Sticky Syrup Swamp | Skyler “Syrup Scoundrel” Sugars | Sticky surfaces, pancake rafts          | [World 03](worlds/03-sticky-syrup-swamp.md) |
| 4   | Kitchen Mayhem     | Casey “Cutlery Thief” Canes     | Cutlery, falling pans, cover            | [World 04](worlds/04-kitchen-mayhem.md)     |
| 5   | Caffeine Craze     | Marlowe “Mocha Menace” Mugs     | Pressure-cycle steam and vertical lifts | [World 05](worlds/05-caffeine-craze.md)     |
| 6   | Egg Factory Frenzy | Morgan “Omelet Overlord” Eggman | Conveyors, egg machinery                | [World 06](worlds/06-egg-factory-frenzy.md) |
| 7   | Citrus Cascade     | Jordan “Juice Jacker” Squeeze   | Juice jets, slip, launchers             | [World 07](worlds/07-citrus-cascade.md)     |
| 8   | Bakery Bonanza     | Quinn “Muffin Mastermind” Munch | Ovens, flour, dough lifts               | [World 08](worlds/08-bakery-bonanza.md)     |

## Design specifications

1. [Product vision and game pillars](01-product-vision.md)
2. [Core game loop](02-core-game-loop.md)
3. [Investigation and cases](03-investigation-and-cases.md)
4. [Dialogue and narrative events](04-dialogue-and-narrative.md)
5. [Interaction system](05-interaction-system.md)
6. [Player, traversal, and camera](06-player-and-traversal.md)
7. [Combat, health, and feedback](07-combat-and-health.md)
8. [Weapons and equipment](08-weapons-and-equipment.md)
9. [Items, pickups, and status effects](09-items-and-status-effects.md)
10. [Enemies and AI](10-enemies-and-ai.md)
11. [Bosses and encounters](11-bosses-and-encounters.md)
12. [World structure and progression](12-world-progression.md)
13. [Quests, objectives, and evidence tracking](13-quests-and-objectives.md)
14. [UI, menus, and HUD](14-ui-ux.md)
15. [Saving and persistence](15-save-and-persistence.md)
16. [Scene flow and transitions](16-game-flow-and-routing.md)
17. [Godot component contracts](17-architecture-and-contracts.md)
18. [Controls and accessibility](18-controls-and-accessibility.md)
19. [Visual identity and animation](19-visual-art-direction.md)
20. [Audio direction](20-audio-direction.md)
21. [Testing and acceptance](21-testing-and-acceptance.md)
22. [Content production standards](22-content-production.md)
23. [Narrative, representation, and localization](23-narrative-and-localization.md)
24. [Data schemas and IDs](24-data-schemas.md)
25. [Level composition and tooling](25-level-authoring.md)
26. [Milestones and release gates](26-production-roadmap.md)
27. [Terminology](27-glossary.md)
28. [Hub navigation and minimap](28-hub-navigation-and-minimap.md)
29. [Events, timers and scoring](29-events-timers-and-scoring.md)
30. [Side activities and minigames](30-side-activities-and-minigames.md)
31. [Checkpoints, retries and difficulty](31-checkpoints-retries-and-difficulty.md)

## Reference catalogs

- [Reusable level elements](reference/level-elements.md)
- [Enemy behavior roster](reference/enemy-roster.md)
- [Weapon visual and behavior roster](reference/weapon-roster.md)
- [Design acceptance matrix](reference/acceptance-matrix.md)

## Document conventions

**Rule:** a required gameplay contract or art constraint. 

**Default (tuning):** an editable starting value. 

**Content target:** designed but awaiting authoring or playtest approval. 

**Prototype:** a scene or script exists and must pass runtime QA. 

**Blocked:** a required integration does not yet have an accepted implementation.

Stable content IDs use snake_case. 

Display names are localized text and must never be used as save identifiers. 

Each gameplay feature specifies input, state change, output/feedback, and failure handling. 

No individual level may silently override a shared component's interface.
