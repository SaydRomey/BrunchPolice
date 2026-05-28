# Bakery Bonanza Environment Design

## Identity

Bakery Bonanza is a warm, production-line bakery level built around rising dough, ovens, flour clouds, trays, and baked-goods machinery.

---

## Platform Types

| Platform               | Behavior                                       | Gameplay Use                             |
| ---------------------- | ---------------------------------------------- | ---------------------------------------- |
| Rising dough platforms | Expand or lift over time.                      | Timed vertical traversal.                |
| Conveyor trays         | Moving platforms that carry the player.        | Route movement through bakery machinery. |
| Oven ledges            | Stable but near heat hazards.                  | Risk/reward positioning.                 |
| Flour-covered shelves  | Low-friction or visibility-obscured platforms. | Movement and readability challenge.      |
| Bread-loaf platforms   | Soft, slightly bouncy platforms.               | Basic traversal with bounce variation.   |
| Muffin stacks          | Vertical clustered platforms.                  | Climbing routes and secret placement.    |

---

## Hazards

| Hazard            | Type                     | Behavior                              |
| ----------------- | ------------------------ | ------------------------------------- |
| Oven flames       | Damage hazard            | Activate in timed bursts.             |
| Falling trays     | Damage / platform hazard | Drop after warning rattles.           |
| Flour clouds      | Visibility hazard        | Obscure enemies and platforms.        |
| Rolling baguettes | Moving hazard            | Roll across floors or slopes.         |
| Dough traps       | Soft hazard              | Slow the player or briefly hold them. |
| Hot racks         | Damage hazard            | Stationary or moving heated surfaces. |

---

## Interactions

| Interaction                 | Description                                |
| --------------------------- | ------------------------------------------ |
| Time rising dough platforms | Ride expanding dough upward.               |
| Clear flour clouds          | Restores visibility and reveals clues.     |
| Ride conveyor trays         | Moves through oven and packaging sections. |
| Use oven mitt switches      | Temporarily disables heat hazards.         |
| Push bread carts            | Creates moving cover or platforms.         |
| Break pastry crates         | Reveals collectibles or route shortcuts.   |

---

## Background Storytelling

| Layer           | Details                                                                    |
| --------------- | -------------------------------------------------------------------------- |
| Far background  | Large ovens, bakery arches, warm bread silhouettes.                        |
| Mid background  | Muffin smuggling routes, hidden hat-shaped muffin piles, flour footprints. |
| Near background | Conveyor belts, tray racks, flour sacks, oven doors.                       |
| Foreground      | Flour dust, oven glow, crumbs, tray motion.                                |

---

## Ambiance

### Audio

- Oven hums.
- Dough rising sounds.
- Flour puffs.
- Tray rattles.
- Bread-cart wheels.
- Baguette rolling thumps.

### Visual

- Warm oven glow.
- Flour dust clouds.
- Soft bread tones.
- Heat shimmer near ovens.
- Golden bakery palette.

---

## Recommended Level Formula

- Primary traversal gimmick: rising dough platforms.
- Surface modifier: flour visibility and dough slowdown.
- Moving hazard: rolling baguettes or falling trays.
- Verticality tool: rising dough and muffin stacks.
- Boss-relevant mechanic: using oven mitt switches or flour clearing to expose safe lanes.
