# Brunch Police Pause Menu UI

## Overview

For **Brunch Police**, the pause menu should feel like a mix of a **brunch receipt**, a **police case file**, and a **cartoon diner menu**. It should be playful, food-themed, and readable, but still fast to use because the game switches between investigation, dialogue, accusation, and platforming.

The pause menu should feel like the player opened a **messy brunch detective file**, not a standard fantasy RPG menu. It should be useful, funny, and fast. The player should immediately understand: **“I am still investigating brunch crimes, even while paused.”**

---

## Core Structure

The best structure is a **semi-transparent overlay** over the frozen game, with the active scene blurred or darkened behind it.

The menu itself should appear as a large **clipboard / brunch bill / detective notebook** panel in the center, with small food stains, grease marks, syrup drips, and stamped labels.

### Main Pause Menu Layout

```text
PAUSED: BRUNCH PATROL

[ Resume Patrol ]

[ Case Notes ]
[ Evidence ]
[ Suspects ]
[ Loadout ]
[ Controls ]
[ Settings ]

[ Return to Buffet / Return to Hub ]
[ Main Menu ]
```

The first option should always be **Resume Patrol** or **Resume Chase**, depending on the current mode. It should be large, highlighted, and instantly readable.

---

## Context-Sensitive Pause Menus

The pause menu should adapt slightly depending on where the player pauses.

---

## Hub Pause Menu

In the **brunch hub**, the menu should focus on investigation.

```text
PAUSED: BUFFET CASE FILE

Resume Patrol
Case Notes
Suspect List
Evidence Collected
Plate Inspection Log
Dialogue Clues
Settings
Main Menu
```

This fits the hub gameplay, where the player talks to NPCs, inspects plates, gathers clues, and accuses culprits.

---

## Platforming Chase Pause Menu

In a **platforming chase level**, the menu should focus more on action.

```text
PAUSED: CULPRIT CHASE

Resume Chase
Retry from Checkpoint
Evidence Collected
Weapon / Power-up Info
Level Objective
Controls
Settings
Return to Buffet
Main Menu
```

### Example: Grease Canyon

```text
Case: Bacon Bandit
Objective: Catch Barry Brown
Evidence: Bacon Strips 4 / 10
Weapon: Bacon Gun
Power-up: Grease Slide
Checkpoint: Sizzling Bacon Platforms
```

This gives the player useful context without making the pause menu feel like a generic settings screen.

---

## Visual Style

The UI should use **chunky pixel-art panels**, rounded rectangular buttons, and exaggerated breakfast-police theming.

Possible visual elements include:

- Diner receipt paper
- Police tape
- Syrup-gloss highlights
- Egg-yolk selection markers
- Bacon-strip dividers
- Stamped labels such as **EVIDENCE**, **SUSPECT**, **ACCUSE?**, or **CASE PAUSED**

Avoid a dark, serious police-menu style. The game’s tone is humorous and food-based, so even the pause screen should feel slightly ridiculous.

---

## Color Palette

The color palette should stay bright and warm.

```text
Cream / pancake beige: main panel background
Dark coffee brown: text and outlines
Egg yolk yellow: highlights
Ketchup red: warnings and selected danger options
Bacon red-orange: active button accents
Syrup amber: hover states and animated drips
```

---

## Button Design

The button style should be readable and tactile. Each button could look like a **paper receipt line item** or a **diner menu selection**, with the highlighted option marked by a tiny animated fork, magnifying glass, badge, or sunny-side-up egg cursor.

### Example With Food Cursor

```text
🍳 Resume Patrol
   Case Notes
   Evidence
   Settings
```

If emojis are not used in the actual game UI, use pixel icons instead.

```text
[egg icon] Resume Patrol
[magnifier icon] Case Notes
[plate icon] Evidence
[bacon icon] Loadout
[gear icon] Settings
```

---

## Recommended Layout

The menu should not be too large or complex. Brunch Police has action-platforming sections, so the pause menu should be quick.

Use a **left-side vertical list** for navigation and a **right-side info card** for details.

```text
 ------------------------------------------------
| PAUSED: BRUNCH POLICE                          |
|------------------------------------------------|
| Resume Patrol        | Current Case            |
| Case Notes           | Culprit: Bacon Bandit   |
| Evidence             | Evidence: 4 / 10        |
| Suspects             | Weapon: Bacon Gun       |
| Loadout              | Objective: Catch him    |
| Controls             |                         |
| Settings             |                         |
| Main Menu            | [stamped: IN PROGRESS]  |
 ------------------------------------------------
```

---

## Animation Direction

Use small animations, but keep them subtle.

Recommended animation ideas:

- The pause panel pops in with a quick squash-and-stretch animation.
- The selected button bounces slightly.
- Syrup drips slowly slide down the panel edges.
- A rubber-stamp effect appears when opening the menu: **PAUSED** or **CASE FILE OPENED**.
- Level-specific decoration animates lightly in the background.

Examples:

- In **Grease Canyon**, the menu might have sizzling grease bubbles.
- In **Sticky Syrup Swamp**, the border could look sticky and slow.
- In **Candy Chaos**, the highlights could sparkle like sugar.

---

## Audio Direction

Audio should match the UI.

Suggested sounds:

- Opening pause menu: **receipt rip**, **police radio blip**, or **fork tap**
- Moving between options: small **plate clink**
- Confirming an option: **rubber stamp** sound
- Backing out: **paper flip** sound

---

## Level-Specific Pause Menu Skins

The pause menu should support the game’s changing level themes. The base structure stays the same, but the decorative skin changes by level.

```text
Grease Canyon: bacon strips, grease bubbles, red-orange border
Pastry Palace: flaky pastry corners, powdered sugar dust
Sticky Syrup Swamp: amber syrup drips, slow gooey animations
Kitchen Mayhem: steel counter panels, knife-and-fork icons
Candy Chaos: candy cane dividers, frosting highlights
Egg Factory Frenzy: cracked egg borders, yolk buttons
Citrus Cascade: orange slices, juice splashes
Bakery Bonanza: bread crust frame, flour-dust texture
```

---

## Settings Menu

The settings section should be simple.

```text
Audio
Video
Controls
Accessibility
Language
Back
```

---

## Accessibility Options

Accessibility should include:

- Text size
- Screen shake toggle
- Flashing effects toggle
- Colorblind-friendly highlights
- Subtitle toggles
- Input remapping

---

## Design Rule

The pause menu should feel like the player opened a **messy brunch detective file**, not a generic system menu.

It should be:

- Fast to navigate
- Readable during action-heavy sections
- Strongly tied to the brunch-police theme
- Flexible enough to support both hub investigation and chase levels
- Visually funny without reducing usability
