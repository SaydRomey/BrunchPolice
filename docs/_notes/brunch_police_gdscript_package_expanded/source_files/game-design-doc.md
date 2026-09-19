
# Game Concept Document: Brunch Police

## Overview

| **Game Title**      | Brunch Police                                                       |
| ------------------- | ------------------------------------------------------------------- |
| **Genre**           | Action-adventure with platforming and investigative elements.       |
| **Style**           | 2D platformer for levels, isometric/top-down for hub (brunch area). |
| **Target Audience** | Players who enjoy quirky humor, lighthearted gameplay, and food.    |
| **Game Engine**     | Godot (for its ease of use with 2D and isometric games).            |

---

## Core Gameplay

### 1. Main Gameplay Loop

1. Brunch Area (Isometric/Top-down Hub):
- Players act as the "unofficial Brunch Police."
- Roam around a bustling brunch buffet.
- Interact with NPCs:
  - Dialogue to gather clues about suspicious behavior.
  - Inspect plates for suspicious activities.
  - Accuse NPCs if evidence (plate inspection) supports it:
  - Incorrect accusations result in humorous NPC responses.
  - Correct accusations initiate the Culprit Fleeing Sequence.

2. Culprit Fleeing Sequence:
- Accused NPC flees into one of three themed exit areas:
  - Main Exit: Leads to street-themed platformer levels.
  - Bathroom: Leads to toilet/pipes-themed platformer levels.
  - Kitchen: Leads to staff-only/kitchen platformer levels.
- Transition into a wacky, action-packed 2D platforming level.

3. Platformer Levels:
- Navigate themed environments while avoiding or defeating enemies.
- Use weapons and power-ups to progress.
- Collect evidence items (e.g., bacon strips, cutlery, or receipts).
- Confront and defeat the level boss (culprit) in a unique boss fight.

4. Return to Brunch Area:
- After defeating the culprit, return to the brunch hub to continue investigating other NPCs.

---

### 2. Level Design

#### Hub World (Brunch Buffet):
- Isometric or top-down.
- NPCs with distinct personalities and routines (e.g., picky eaters, hoarders, sneaky thieves).
- Areas: Buffet tables, seating areas, drinks station, dessert bar, etc.

#### Platformer Levels:

[See Character and Level Desing Document](./character-and-level-design.md)

- Kitchen Levels:
  - Enemies: Angry chefs, rolling pins, knife-throwing sous chefs.
  - Hazards: Hot stoves, falling pots and pans.
  - Power-ups: Shield of Cutlery, Dish Soap Speed Boost.

- Boss Fights:
  - Unique mechanics for each culprit.

> Example: Bacon hoarder uses a "bacon tornado" attack, 
> requiring precise jumps and timing to counter.

---

## Game Features

### 1. Investigative Gameplay

#### Dialogue system to question NPCs.
- Plate inspection mechanic:
  - Close-up view of plates with dynamic objects (e.g., stacked bacon, sneaky croissant in a bag).

- Accusation system:
  - Based on observed clues and interactions.

### 2. Platforming Gameplay

- Varied enemies with themed designs and mechanics.
- Unique hazards and traps per level.
- Collectibles that tie into the theme of each level (e.g., bacon strips, stolen forks).

### 3. Weapons and Power-ups

#### Weapons:
- Bacon Gun: Fires strips of bacon to immobilize enemies.
- Syrup Shooter: Slows down enemies.

#### Power-ups:
- Bacon Grease Slide: Dash move that leaves a slowing trail.
- Extra Bacon: Grants a temporary bacon shield.
- Syrup Boots: Prevent slipping on hazards.

---

## Visual and Audio Design

### 1. Visual Style

- Cartoonish, humorous art style.
- Bright, colorful brunch area with detailed food and decor.
- Platformer levels have exaggerated, wacky designs:
  - Example: Giant bacon strips as platforms, syrup waterfalls, oversized kitchen utensils.

### 2. Audio Design
- Whimsical and lighthearted soundtrack:
- Relaxing brunch music in the hub.
- Fast-paced, quirky tunes for platformer levels.
- Dynamic sound effects:
  - Food splats, sizzling grease, NPC dialogue snippets.

---

## Development Requirements

### 1. Tools

- Game Engine: Godot (for 2D and isometric development).

- Art Tools:
  - Aseprite (for pixel art or 2D assets).

- Audio Tools:
  - Audacity or FMOD (for sound effects and music).

- Version Control: Git/GitHub (for team collaboration).

### 2. Skillsets Needed

- Game Design:
  - Level design and balancing.
  - Mechanic design (investigation, platforming, power-ups).

- Programming:
  - Proficient in GDScript (or C# if using Godot).
  - Experience with 2D physics and AI behavior.

- Art and Animation:
  - 2D sprite creation.
  - Animation for characters, enemies, and effects.

- Sound Design:
  - Composing dynamic music tracks.
  - Creating humorous sound effects.

- Writing:
  - Engaging and funny dialogue for NPCs.
  - Creative level introductions and boss fight descriptions.

---

## Development Plan

### Phase 1: Pre-production

1. Define scope and game mechanics.
2. Create concept art for hub, levels, and characters.
3. Design initial levels and enemies on paper.
4. Set up GitHub repository and project structure.

### Phase 2: Prototype

1. Develop basic isometric hub world with NPC interactions.
2. Build one platformer level with:
  - Simple enemies.
  - Basic power-ups and hazards.
3. Test mechanics and refine core gameplay.

### Phase 3: Production

1. Expand NPC roster and dialogue options.
2. Create additional platformer levels and unique boss fights.
3. Implement weapons, power-ups, and collectibles.
4. Add animations and sound effects.

### Phase 4: Testing

1. Conduct playtesting to identify bugs and improve balancing.
2. Polish visuals and audio.

### Phase 5: Launch

1. Package game for distribution.
2. Release on PC (Steam/itch.io).

---

## Post-launch Ideas

- DLCs or Updates:
  - New themes: Dinner buffet, dessert station.
  - Additional levels and NPCs.

- Multiplayer Mode:
  - Co-op platforming or competitive brunch policing.

- Customization:
  - Unlockable outfits for the Brunch Police character.

---

Brunch Police aims to be a quirky and engaging game blending humor, 
investigation, and creative platforming challenges.

---
