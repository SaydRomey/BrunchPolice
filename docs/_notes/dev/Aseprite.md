
# Aseprite - Notes

## Basic Steps Overview

<details><summary>Click to reveal basic steps overview</summary>

### 🎮 Step 1: Decide Your Visual Style
Before you start drawing:
  - Pixel size: Common styles are 8x8, 16x16, or 32x32 tiles. 
    For a 2D platformer, 16x16 or 32x32 is usually ideal.  
  - Theme/mood: Is it bright and cartoonish? Dark and moody? 
    Food-themed (e.g., waffles as platforms)?

*📌 Let’s say you’re doing 16x16 tiles and a fun brunch-themed world.*

---

### 🧱 Step 2: Create a Tileset
Tilesets are reusable images that make up the level (ground, platforms, walls, etc.).

✅ In Aseprite:
1. Open Aseprite → `File > New`
2. Set canvas size (e.g. 128x128 for 16 tiles at 16x16 each).
3. Use Grid: `View > Grid > Grid Size` → set it to 16x16
4. Enable `View > Snap to Grid`

Now draw:
  - Ground tile
  - Platform edges (left, middle, right)
  - Walls
  - Slopes (optional)
  - Decorative tiles (grass, eggs, bacon, syrup)

🎨 Keep a limited color palette (4–8 colors to start), which helps keep your style consistent and readable.

---

### 🧍 Step 3: Design the Player Sprite
✅ Start with:
  - Size: 16x16 or 32x32
  - Design a static pose first
  - Think of brunch-themed ideas (e.g., an egg cop, or toast in a uniform)

Then, animate:

#### 🔄 Basic Player Animations:
- Idle (2–4 frames): small motion, blinking
- Run (6–8 frames): exaggerate leg motion
- Jump (1–3 frames): squat → lift → air
- Fall (1 frame is enough)

Use Aseprite's timeline and frame tags for animation.

---

### 👾 Step 4: Enemies
Make 1–2 enemy types:
  - Example: Angry waffle, syrup blob, croissant ninja

Give them:
  - Idle animation
  - Walk/patrol
  - Attack or death/explode

Start simple. You can polish later.

---

### ✨ Step 5: Collectibles / UI
Draw:
  - Brunch coins (pancake stacks, mimosa glasses, etc.)
  - Power-ups (coffee, bacon shield)
  - Hearts/HP bar
  - Menu icons

Use Aseprite layers for icons vs. text.

---

### 📦 Step 6: Exporting to Godot
1. Sprite Sheets:
    - File > Export Sprite Sheet in Aseprite
    - Use "By Tag" or "By Frame"
    - Check JSON export if you want metadata

2. Import into Godot:
    - Use AnimatedSprite2D or Sprite2D + AnimationPlayer
    - Set region if using a tilesheet
    - Godot 4.2 has an updated Tileset editor – use it for your tiles

---

### 💡 Tips
- Use [Lospec](https://lospec.com/palette-list) for premade color palettes
- Always test animations in-game – how it feels matters more than how it looks standing still
- Keep a naming convention like: player_idle.png, enemy_waffle_walk.json, tileset_brunch.png

</details>

---

## 🎨 GOAL: Animate an Idle Loop in Aseprite
A basic Idle Animation is usually:
  - 2 to 4 frames
  - Small, subtle motions (bobbing, blinking, hand movement, etc.)
  - ~6–12 FPS

---

### ✅ Step-by-Step in Aseprite

1. Create Your Base Frame
    - Open Aseprite → `File > New`
    - Set canvas: 32x32 or 48x48 (depending on your original sprite size)
    - Draw (or paste) your player character in a neutral standing pose
    - Name the layer: `Body`

2. Set Up the Timeline
    - At the bottom, make sure the Timeline is visible (`Window > Timeline`)
    - Duplicate the frame (Right click on Frame 1 → `Duplicate Frame`)
    - Do this until you have 3 or 4 frames

3. Add Subtle Animation  
  Pick a few from below (you don’t need all):
    - Body bob: Slightly raise the entire character by 1 pixel in frame 2, then back down in frame 3
    - Arm sway: Nudge the arms 1px in alternating directions
    - Blinking eyes: Add a 2–3 frame blink every 1.5–2 seconds
    - Badge shimmer: Add a sparkle or shine frame to the egg badge
    - Mustache twitch?: Just for fun!

💡 Pro tip: Use onion skinning (`Alt + O` or toggle from the toolbar) to line up changes.

4. Adjust Timing
  - Set frame durations:
    - Right click frame → `Properties`
    - Use 100–150ms for normal frames, 50–80ms for quick blinks

5. Preview Your Animation
  - Hit `Enter` or `Play` at the bottom
  - Tweak timing/poses until it feels alive, not robotic

---

### 🧁 Export It
To export your animation:
1. `File > Export Sprite Sheet`
2. Sheet Type: `By Rows`
3. Include Frame Tags if you want to separate animations later
4. Or use `File > Export As > GIF` for testing or sharing

---

