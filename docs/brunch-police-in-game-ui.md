# Brunch Police In-Game UI Design

## Overview

The in-game UI for **Brunch Police** should feel like a playable version of the pause-menu concept: a mix of **brunch receipt**, **police case file**, **diner order ticket**, and **cartoon food-crime HUD**.

The UI should be readable, playful, and functional without covering too much of the screen. Since the game includes both an **investigation hub** and **2D platforming chase levels**, the UI should adapt depending on the gameplay mode.

The main design goal is:

```text
Make the player feel like they are actively working as a ridiculous food detective.
```

---

## Core UI Style

The UI should look like it belongs inside a brunch-crime world.

Use:

```text
Chunky pixel-art panels
Cream-colored receipt paper
Coffee-brown outlines
Egg-yolk yellow highlights
Bacon-red warning accents
Syrup-amber meters
Tiny food-police icons
Rubber-stamp labels
Grease stains and crumbs as decoration
```

The UI should not feel futuristic, medieval, or overly serious. It should feel like the player is managing a messy brunch investigation.

The main visual language should be:

```text
Police badge + brunch receipt + diner ticket + detective notebook
```

A useful design rule:

```text
If the UI element gives gameplay information, make it look like a brunch object.
If the UI element gives investigation information, make it look like police paperwork.
```

---

## Main HUD Layout

The standard HUD should be light, readable, and mostly corner-based.

```text
 ------------------------------------------------
| Badge / Health        Current Objective        |
| Fork + Offhand        Evidence Count           |
|                                                |
|                                                |
|                                                |
|              Gameplay Area                     |
|                                                |
|                                                |
| Interaction Prompt              Mini Case Note |
 ------------------------------------------------
```

Avoid crowding the center of the screen. Most information should sit in the corners.

Recommended layout:

```text
Top-left: Health / status
Top-center: Current objective
Top-right: Evidence
Bottom-left: Weapons / abilities
Bottom-right: Interaction prompts
Center/bottom: Dialogue, inspection, accusation overlays
```

---

## Top-Left UI: Health and Player Status

The top-left should show the player’s basic survival information.

Instead of a generic health bar, use a **Brunch Police badge meter** or a food-themed health display.

Possible health styles:

```text
Coffee Cup Meter
Pancake Stack Health
Donut Heart Icons
Badge Durability Meter
```

Recommended version:

```text
[Police Badge Icon] Pancake Stack: 4 / 5
```

Each health point could be represented by a mini pancake. When the player takes damage, a pancake gets bitten.

Example:

```text
Pancakes: [Full] [Full] [Full] [Full] [Empty]
```

Status effects should appear under health as tiny food-condition icons.

Examples:

```text
[ Syrup Drop ] Sticky
[ Grease Drop ] Slippery
[ Bacon Shield ] Protected
[ Citrus Slice ] Energized
[ Flame Icon ] Burning
[ Dizzy Icon ] Stunned
```

---

## Top-Center UI: Current Objective

The top-center should show the current task in a small **diner-ticket banner**.

Example in the hub:

```text
CASE OBJECTIVE:
Question suspicious brunch guests
```

Example during plate inspection:

```text
CASE OBJECTIVE:
Inspect the plate for stolen bacon
```

Example during a chase level:

```text
CHASE OBJECTIVE:
Catch Barry “Bacon Bandit” Brown
```

Example during a boss fight:

```text
BOSS OBJECTIVE:
Dodge the Bacon Tornado, then counterattack
```

The objective should appear when it changes, stay visible for a few seconds, then shrink into a smaller reminder.

Possible styles:

```text
==============================
ORDER UP: Find 3 clues
==============================
```

or:

```text
[ ACTIVE CASE ] Find the bacon thief
```

---

## Top-Right UI: Evidence and Collectibles

The top-right should show evidence progress. This is one of the most important HUD areas because evidence connects the investigation and platforming systems.

Basic version:

```text
Evidence: 4 / 10
```

More thematic version:

```text
CASE EVIDENCE
[Bacon Strip Icon] 4 / 10
```

Recommended level-specific collectible icons:

```text
Grease Canyon: Bacon Strips
Sticky Syrup Swamp: Syrup Receipts
Citrus Cascade: Juice Bottles
Bakery Bonanza: Muffin Wrappers
Candy Chaos: Candy Clues
Kitchen Mayhem: Stolen Utensils
Egg Factory Frenzy: Cracked Shells
Pastry Palace: Croissant Crumbs
```

Example level HUD:

```text
[ Evidence Bag ] Bacon Strips: 4 / 10
```

When the player collects evidence, the item should fly toward the top-right evidence bag with a small stamp animation.

Possible messages:

```text
CLUE BAGGED!
EVIDENCE ADDED
CASE UPDATED
```

The evidence UI should remain readable but secondary during action.

---

## Bottom-Left UI: Weapons and Abilities

The bottom-left should show the player’s equipped weapon setup.

Because the game has a main-hand weapon and possible off-hand item, this UI should look like a small **utensil tray**.

Example:

```text
MAIN HAND      OFF HAND
[ Fork ]       [ Bacon Gun ]
```

Recommended layout:

```text
 --------------------------------
| Main Hand:  Fork               |
| Off Hand:   Bacon Gun          |
| Cooldown:   ████░░             |
 --------------------------------
```

For platforming levels, the weapon UI matters more. It should show:

```text
Main-hand weapon
Off-hand weapon or item
Ammo or cooldown
Charge meter if applicable
Temporary weapon duration
```

Example with the Bacon Gun:

```text
[ Fork Icon ] Main
[ Bacon Gun Icon ] Offhand
Bacon Wrap Cooldown: ███░░
```

Example with the Lollipop Hammer:

```text
[ Lollipop Hammer Icon ]
Heavy Weapon: Two-Handed
Charge: █████░
```

If a weapon uses both hands, the UI should clearly replace both weapon slots:

```text
TWO-HANDED
[ Lollipop Hammer ]
```

This prevents confusion when the player cannot use an off-hand item.

---

## Bottom-Right UI: Context Prompt

The bottom-right should show context-sensitive actions.

This connects directly to the interaction system.

Examples in the hub:

```text
[E] Talk
[E] Inspect Plate
[E] Accuse
[E] Pick Up Clue
```

Examples in platforming levels:

```text
[E] Activate Checkpoint
[E] Pick Up Weapon
[E] Open Shortcut
[E] Read Sign
```

The prompt should look like a small receipt sticker or table tent.

Example:

```text
┌──────────────────┐
│ E  Talk to NPC    │
└──────────────────┘
```

Controller examples:

```text
[A] Talk
[X] Inspect
[Y] Accuse
```

The prompt should only appear when the player is close enough to interact. It should not stay visible at all times.

---

## Hub Investigation UI

The hub UI should be calmer and more investigative than the action-level UI.

The player should see:

```text
Health / badge status
Current case objective
Nearby interaction prompt
Small case notebook indicator
Suspicion / clue progress
```

Recommended hub HUD:

```text
 ------------------------------------------------
| Badge: Pancakes 5 / 5       Case: Missing Bacon |
|                                                |
|                                                |
|              Brunch Buffet Hub                |
|                                                |
|                                                |
| [E] Talk to Barry       Evidence: 2 / 5        |
 ------------------------------------------------
```

The hub should not show too many combat elements unless enemies or hazards are nearby.

A useful hub-specific UI element would be a small **Case Notebook** button:

```text
TAB: Case Notes
```

When opened, it could show a compact overlay:

```text
CASE NOTES
Suspects: 4
Evidence: 2 / 5
Strongest Lead: Barry has extra bacon
```

---

## NPC Dialogue UI

Dialogue should use a large but clean box at the bottom of the screen.

It should look like a **diner placemat mixed with a detective transcript**.

Example:

```text
 ------------------------------------------------
| Barry “Bacon Bandit” Brown                    |
|------------------------------------------------|
| “I have no idea where the bacon went, officer.” |
|                                                |
|  1. Ask about his plate                        |
|  2. Ask where he was earlier                   |
|  3. Accuse him                                 |
 ------------------------------------------------
```

Recommended structure:

```text
NPC Portrait | Name / Nickname
Dialogue text
Player choices
```

Example:

```text
[Barry Portrait]
Barry “Bacon Bandit” Brown

“I only took a normal amount of bacon.
A completely legal amount.”

> Ask about the bacon pile
  Ask about the greasy fingerprints
  End conversation
```

Dialogue choices should use a highlight cursor shaped like one of the following:

```text
Fork
Magnifying glass
Egg yolk
Police badge
```

The **Accuse** option should look more serious and visually distinct.

Example:

```text
[ACCUSE] Barry of bacon theft
```

Use ketchup-red or stamp-red for accusation choices.

---

## Plate Inspection UI

Plate inspection should have its own screen or close-up overlay.

This should feel like the player is examining a crime scene.

Example layout:

```text
 ------------------------------------------------
| PLATE INSPECTION: Barry's Plate                |
|------------------------------------------------|
|                                                |
|          [ Large close-up plate view ]         |
|                                                |
| Clues Found:                                   |
| - Extra bacon grease                           |
| - Hidden croissant crumbs                      |
| - Suspicious syrup trail                       |
|                                                |
| [Rotate Plate] [Inspect Item] [Back]           |
 ------------------------------------------------
```

The UI should show a close-up of the plate with clickable or selectable suspicious objects.

Use small labels such as:

```text
SUSPICIOUS
CLUE?
EVIDENCE
NORMAL FOOD
```

When the player finds something important, use a stamp animation:

```text
CLUE FOUND
```

or:

```text
EVIDENCE BAGGED
```

The plate inspection UI should include:

```text
Plate owner
Clue count
Highlighted suspicious items
Inspect button prompt
Back button
```

---

## Accusation UI

The accusation screen should feel like a dramatic but funny police moment.

It should not be a simple yes/no box. It should feel like the player is filing a ridiculous brunch charge.

Example:

```text
 ------------------------------------------------
| FILE ACCUSATION                                |
|------------------------------------------------|
| Suspect: Barry “Bacon Bandit” Brown            |
| Charge: Excessive Bacon Hoarding               |
| Evidence:                                      |
| [ ] Greasy fingerprints                        |
| [ ] Plate stacked with bacon                   |
| [ ] Witness saw him near buffet                |
|                                                |
| Confidence: Medium                             |
|                                                |
| [ Confirm Accusation ] [ Keep Investigating ]  |
 ------------------------------------------------
```

The player should be able to select evidence before accusing. This makes the accusation feel connected to investigation instead of random guessing.

Wrong accusation message:

```text
FALSE ALARM!
Barry: “That is brunch profiling.”
```

Correct accusation message:

```text
CULPRIT CONFIRMED!
Barry is fleeing!
```

A correct accusation can transition directly into the chase sequence.

---

## Chase / Platforming Level UI

The platforming UI should be faster, tighter, and more action-focused.

Recommended platformer HUD:

```text
 ------------------------------------------------
| Health: Pancakes 4 / 5      Catch: Bacon Bandit|
| Weapon: Fork + Bacon Gun    Evidence: 4 / 10   |
|                                                |
|                                                |
|              2D Platforming Level              |
|                                                |
|                                                |
| Checkpoint Saved!                Ability Ready |
 ------------------------------------------------
```

The platforming UI should show:

```text
Health
Current weapon
Cooldown or ammo
Evidence count
Current objective
Boss/chase progress if relevant
Checkpoint messages
Temporary power-up timer
```

If the level is a chase, add a **culprit distance meter**.

Example:

```text
Bacon Bandit Distance:
YOU ███████░░░ CULPRIT
```

or:

```text
Culprit Escape Meter
██████░░░░
```

If the meter fills, the culprit gets away or the player loses progress.

This should only appear in chase sections, not every platforming level.

---

## Boss Fight UI

Boss fights need a special UI layer.

Example:

```text
 ------------------------------------------------
| Player Health: Pancakes 4 / 5                  |
|                                                |
| Barry “Bacon Bandit” Brown                     |
| ████████████████░░░░                           |
|                                                |
| Objective: Dodge Bacon Tornado                 |
 ------------------------------------------------
```

Boss health should appear at the top or bottom center.

Use a thematic boss bar:

```text
CULPRIT RESISTANCE
Barry “Bacon Bandit” Brown
████████████░░░░
```

Instead of generic **Boss HP**, use something that fits the tone:

```text
Culprit Stubbornness
Brunch Crimes Remaining
Bacon Bandit Panic Meter
Culprit Stamina
```

Recommended label:

```text
CULPRIT STAMINA
```

Boss phase messages should appear as stamped alerts:

```text
BACON TORNADO INCOMING
JUICE SPRAY RELOADING
SYRUP FLOOD RISING
```

---

## Power-Up UI

Power-ups should appear near the weapon UI or under health.

Example:

```text
[ Bacon Shield ] 8s
[ Syrup Boots ] 12s
[ Vitamin Boost ] +1 Health
```

Power-ups should use circular timers or shrinking bars.

Example:

```text
BACON SHIELD
██████░░ 6s
```

Temporary movement effects should appear near the player briefly, then move to the HUD.

Example pickup message:

```text
SYRUP BOOTS EQUIPPED
No slipping for 12 seconds
```

Then it becomes a small icon under the health bar.

---

## Mini-Map / Area UI

The game probably does not need a full mini-map in every level.

For the hub, a small map could help because the brunch buffet may have multiple stations.

Use a compact **buffet map** style:

```text
BUFFET MAP
[ Seating ]
[ Drinks ]
[ Dessert ]
[ Bacon Station ]
[ Exit ]
```

For platforming levels, use signs and objective markers instead of a full map.

Recommended approach:

```text
Hub: small optional mini-map
Platforming levels: no mini-map, only objective markers
```

---

## Notification UI

Notifications should appear as little paper slips, evidence tags, or rubber stamps.

Examples:

```text
CLUE FOUND
CHECKPOINT SAVED
NEW SUSPECT ADDED
WEAPON PICKED UP
CASE UPDATED
CULPRIT FLEEING
```

Visual styles:

```text
Rubber stamp
Receipt slip
Diner ticket
Evidence tag
```

Example:

```text
[ CASE UPDATED ]
Barry was seen near the bacon tray.
```

Notifications should slide in briefly, then disappear.

Do not stack too many notifications at once. If multiple events happen, queue them.

---

## Level-Specific UI Skins

The base HUD should stay consistent, but each level can lightly reskin the borders, icons, and decorative elements.

```text
Grease Canyon:
Bacon-red borders, grease bubbles, sizzling warning icons

Sticky Syrup Swamp:
Amber syrup drips, sticky slow-effect meters

Citrus Cascade:
Orange slice icons, juice splash transitions, citrus-yellow highlights

Bakery Bonanza:
Flour-dust panels, bread crust borders, muffin-wrapper clue icons

Candy Chaos:
Candy-cane dividers, glossy sugar highlights, gumdrop warning icons

Kitchen Mayhem:
Metal counter panels, utensil icons, stove-heat danger warnings

Egg Factory Frenzy:
Cracked egg borders, yolk meters, shell-fragment collectibles

Pastry Palace:
Powdered sugar dust, croissant corners, pastry crumb evidence
```

The UI should never completely change between levels. Only the decorations should change. Players should always know where health, evidence, weapons, and prompts are.

---

## Recommended Full HUD Examples

### Hub HUD

```text
 ------------------------------------------------
| Badge: Pancakes 5 / 5       CASE: Missing Bacon|
|                                                |
|                                                |
|              Brunch Buffet Hub                |
|                                                |
|                                                |
| [E] Talk to Barry        Evidence: 2 / 5       |
| TAB: Case Notes                                |
 ------------------------------------------------
```

### Chase / Platforming HUD

```text
 ------------------------------------------------
| Badge: Pancakes 4 / 5      Catch: Bacon Bandit |
| Fork + Bacon Gun          Evidence: Bacon 4/10 |
|                                                |
|                                                |
|              Grease Canyon Level              |
|                                                |
|                                                |
| Bacon Wrap: Ready         Checkpoint Saved     |
 ------------------------------------------------
```

### Boss Fight HUD

```text
 ------------------------------------------------
| Badge: Pancakes 3 / 5                          |
|                                                |
| CULPRIT STAMINA: Barry “Bacon Bandit” Brown    |
| ████████████░░░░░░                             |
|                                                |
| Objective: Dodge the Bacon Tornado             |
|                                                |
| Fork + Bacon Gun       Bacon Wrap: ███░░       |
 ------------------------------------------------
```

---

## UI Priority

The most important UI elements are:

```text
1. Health
2. Current objective
3. Interaction prompt
4. Evidence count
5. Weapon / ability status
6. Dialogue choices
7. Accusation evidence
8. Boss or chase progress
```

Do not show everything at once. The UI should adapt to the situation.

In the hub, emphasize:

```text
Clues
NPCs
Dialogue
Accusations
Plate inspection
```

In platforming levels, emphasize:

```text
Health
Weapons
Evidence collectibles
Hazards
Boss/chase progress
```

---

## Final Direction

The in-game UI should be functional first, then funny.

The style should be:

```text
Pixel-art diner ticket
Police case file
Receipt paper
Food-stained notebook
Bright brunch colors
Chunky readable icons
```

The UI should support the game’s joke without getting in the way of gameplay. It should be amusing in presentation, but reliable in layout.
