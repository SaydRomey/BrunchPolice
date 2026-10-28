# Godot 4: Build a Reusable 2D Platformer Level Elements Kit

**A practical, step-by-step implementation guide based on the BP2 Level Elements Catalog**  
**Target:** Godot **4.7.2**, GDScript, 2D side-scrolling platformer  
**Deliverable:** A reusable `addons/level_elements_kit/` directory with Inspector-configurable elements, optional debug labels, themed visual presets, and standardized player/level integration.

> **Companion files:** `godot_level_elements_kit.zip` contains a starting implementation, 15 reusable scene templates, 8 thematic color presets, and a separate demonstration project. The guide explains how to construct and evolve it. The code is provided as a starter implementation, not as a formally tested production framework; run the validation checklist in your Godot build before shipping.

---

## Contents

1. [What your catalog tells us to build](#1-what-your-catalog-tells-us-to-build)
2. [Recommended architecture](#2-recommended-architecture)
3. [Project prerequisites and setup](#3-project-prerequisites-and-setup)
4. [Create a portable kit directory](#4-create-a-portable-kit-directory)
5. [Design the universal element contract](#5-design-the-universal-element-contract)
6. [Create Inspector-editable visuals and a debug label](#6-create-inspector-editable-visuals-and-a-debug-label)
7. [Build the first static platform](#7-build-the-first-static-platform)
8. [Create one-way platforms](#8-create-one-way-platforms)
9. [Build moving platforms](#9-build-moving-platforms)
10. [Build collapsing platforms](#10-build-collapsing-platforms)
11. [Build conveyor platforms](#11-build-conveyor-platforms)
12. [Build bounce pads and launchers](#12-build-bounce-pads-and-launchers)
13. [Build hazards, timed hazards, and surface zones](#13-build-hazards-timed-hazards-and-surface-zones)
14. [Build switches, checkpoints, pickups, destructibles, and exits](#14-build-switches-checkpoints-pickups-destructibles-and-exits)
15. [Create thematic appearances and variants](#15-create-thematic-appearances-and-variants)
16. [Integrate an existing player and level manager](#16-integrate-an-existing-player-and-level-manager)
17. [Map the BP2 catalog to reusable systems](#17-map-the-bp2-catalog-to-reusable-systems)
18. [Add the missing systems that a real platformer needs](#18-add-the-missing-systems-that-a-real-platformer-needs)
19. [Editor workflow and authoring guidelines](#19-editor-workflow-and-authoring-guidelines)
20. [Testing and debugging checklist](#20-testing-and-debugging-checklist)
21. [Make the kit portable between projects](#21-make-the-kit-portable-between-projects)
22. [Production roadmap and acceptance criteria](#22-production-roadmap-and-acceptance-criteria)
23. [Common mistakes and remedies](#23-common-mistakes-and-remedies)
24. [Reference documentation](#24-reference-documentation)

---

## 1. What your catalog tells us to build

### 1.1 Review of the supplied BP2 catalog

The uploaded **BP2 Level Elements Catalog** organizes environmental content into **17 tagging categories**, shared reusable platforms, shared hazards, and **eight themed environments**:

1. Grease Canyon
2. Pastry Palace
3. Sticky Syrup Swamp
4. Kitchen Mayhem
5. Candy Chaos
6. Egg Factory Frenzy
7. Citrus Cascade
8. Bakery Bonanza

The catalog's most important architectural clue is its **Cross-Level Reuse Map**. Grease, dishwater, yolk, and juice can all be different-looking slippery surfaces; syrup, frosting, caramel, and pulp can all share sticky-surface behavior. Likewise, pancake rafts, pan lifts, citrus wedge lifts, and conveyor trays are mostly instances of moving-platform behavior. **Do not implement an independent script for every food-themed object.**

### 1.2 The first reusable behavior families

| Foundation / behavior        | Examples from your catalog                                           | Recommended implementation                                   |
| ---------------------------- | -------------------------------------------------------------------- | ------------------------------------------------------------ |
| Static platform              | Bacon strip, croissant, countertop, chocolate bar, egg carton, bread | `Node2D` root + `StaticBody2D` child                         |
| One-way platform             | Thin ledges, shelves, floating slices                                | Static platform with one-way collision enabled               |
| Moving platform              | Pancake raft, pan lift, sorting tray, citrus wedge lift              | `AnimatableBody2D` child, physics-timed motion               |
| Wiggling platform            | Bacon, dough, pancakes                                               | Animated visual only; collision remains stable               |
| Collapsing platform          | Eggshell, pastry, pancake, brittle candy, dough                      | Static collider + top-contact trigger + warning/reset states |
| Conveyor                     | Egg Factory belt, kitchen or bakery tray                             | `StaticBody2D.constant_linear_velocity`                      |
| Bounce / launcher            | Gumdrop, buttered pancake, juice fountain                            | Top-contact `Area2D`, launch vector                          |
| Slippery / sticky surface    | Grease, dishwater, frosting, syrup, caramel, pulp                    | `Area2D` modifier zone + player movement contract            |
| Damage hazard                | Grease pit, lava, acid, spikes, flame                                | `Area2D` with damage signal                                  |
| Periodic hazard              | Splash, burner, press, oven flame                                    | Damage-zone state machine: idle, warn, active                |
| Switch / valve               | Syrup valve, citrus valve, reversible conveyor switch                | `Area2D` + reusable `toggled` signal                         |
| Destructible                 | Dish cover, baking tray cover, brittle obstacles                     | Health component + destroyed signal                          |
| Background / foreground prop | Bacon clouds, mixing bowls, flags, pipes, mist                       | Non-colliding `Node2D` visuals                               |
| Ambiance                     | Sizzling grease, mixer whirr, flour particles                        | Audio and particle sub-scenes                                |

**Scope distinction:** The starter kit implements the foundational items listed in Section 4. Advanced rope physics, complex articulated crushers, enemy spawners, and boss-specific logic are planned extensions, not finished features.

### 1.3 Priorities: what should exist first?

**Milestone 0 — Editor foundation:** portable directory, shared class, Inspector fields, art/placeholder support, debug label, resize-safe collisions.

**Milestone 1 — Traversal:** static, one-way, moving, collapsing, conveyor, bounce.

**Milestone 2 — Interactivity:** damage zone, timed hazard, sticky/slippery zones, switches, checkpoints, collectibles, destructibles, exit/transition trigger.

**Milestone 3 — BP2-specific mechanics:** ropes, pushback jets, rotating mixers and blades, rolling/falling hazards, visibility clouds, timed spawners, boss arena controls, advanced ambiance.

**Milestone 4 — Authoring tools and polish:** preset browser, editor gizmos, localization-ready names, save integration, collision linting, performance budgets, automated tests.

Building in this order means a playable graybox level is available early, before any theme art exists.

---

## 2. Recommended architecture

### 2.1 Separate three concerns

Each level element should have:

1. **Shared metadata and appearance:** ID, human-readable name, category, size, color/texture or preset, visible debug label.
2. **Behavior and physics:** static collision, platform movement, damage, launch, or signal emission.
3. **Level-specific configuration:** placed position, travel vector, timing, texture or preset, unique identifier, connection to a switch, etc.

Think of the system as:

```text
Reusable behavior scene (.tscn)
    + root script / behavior class (.gd)
    + optional theme preset (.tres)
    + per-instance Inspector overrides
    = a fully configured level element
```

Example:

```text
movingplatform.tscn + le_moving_platform.gd
    travel = (260, 0)
    speed_px_per_second = 90
    display_name = "Citrus Wedge Lift"
    visual_preset = citrus_cascade.tres
```

Another element can reuse exactly the same scene with a completely different title, color, image, speed, and route.

### 2.2 Why a `Node2D` wrapper root?

Godot's collision objects have different base types. Static ground uses `StaticBody2D`; transport platforms benefit from `AnimatableBody2D`; hazards and pickups use `Area2D`. A single script cannot simultaneously extend all those native classes. A shared **`Node2D` root class** permits one consistent Inspector experience while the appropriate physics object lives in a child node.

The trade-off is one extra node per element. For most hand-placed platformer objects this is a reasonable price for consistency and portability. For *thousands of repeated terrain tiles*, use `TileMapLayer` instead (Section 19).

### 2.3 The universal scene shape

```text
StaticPlatform (Node2D, script: le_platform_base.gd)
├── Body (StaticBody2D)
│   └── CollisionShape2D (RectangleShape2D)
└── DebugLabel (Label)
```

The root script draws a colored rectangle or a supplied texture centered on the origin. Designers can later attach additional decorative children (for example `Sprite2D`, `AnimatedSprite2D`, `GPUParticles2D`, lights). **Moving-platform exception:** its `Node2D` root stays at the authored anchor; the `AnimatableBody2D` child moves, the root-drawn placeholder is offset to follow it, and additional moving art plus `DebugLabel` belong under `Body`. This keeps the physics body and collision in sync.

### 2.4 Native nodes and responsibilities

| Node                 | Responsibility                                        | Not for                                      |
| -------------------- | ----------------------------------------------------- | -------------------------------------------- |
| `Node2D`             | Placement, metadata, editor-friendly common scripting | Physical blocking by itself                  |
| `StaticBody2D`       | Ground, walls, conveyor contact                       | Velocity-estimated moving lifts              |
| `AnimatableBody2D`   | Kinematic moving level geometry                       | Fully physically simulated debris            |
| `Area2D`             | Overlap, trigger, status zones                        | Solid standing surface                       |
| `RigidBody2D`        | Rolling/colliding physics props                       | Precisely scripted paths                     |
| `CollisionShape2D`   | Shape for a parent collision object                   | Decorative art                               |
| `Label`              | Debug text in world space                             | HUD text that must remain screen-fixed       |
| `TileMapLayer`       | Large painted static terrain                          | Unique complex behaviors on each placed tile |
| `Resource` (`.tres`) | Shared appearance or behavioral configuration         | A physical object without a scene            |

---

## 3. Project prerequisites and setup

### Step 3.1 — Select an engine version

Use **Godot 4.7.2** or another compatible Godot 4.x release. The official archive lists 4.7.2 stable on August 18, 2026, whereas 4.8 beta is a prerelease as of October 24, 2026. The code is GDScript 4, **not** Godot 3 GDScript.

### Step 3.2 — Back up your project

Start with a Git repository and a `.gitignore` that excludes Godot's generated `.godot/` directory. Commit the existing game before introducing the kit.

### Step 3.3 — Choose units and a base grid

A workable initial convention:

- 1 world unit = 1 2D pixel at base resolution.
- Use a 16px or 32px grid for grayboxing.
- Typical sample platform size: `Vector2(128, 24)`.
- Player body in the sample: `22 × 34` world pixels.
- Avoid changing `CollisionShape2D.scale`; set rectangle shape **size** instead.
- Keep physics movement in `_physics_process(delta)`, and define speeds in pixels/second.

Tune these to your actual character; the sample numbers are not implied requirements of the BP2 catalog.

### Step 3.4 — Name the collision layers

In **Project → Project Settings → Layer Names → 2D Physics**, assign:

| Layer # | Name           | Typical members                          |
| ------- | -------------- | ---------------------------------------- |
| 1       | `World`        | Solid platforms, walls, moving platforms |
| 2       | `Player`       | Your player `CharacterBody2D`            |
| 3       | `Enemy`        | Enemies and damaging actors              |
| 4       | `Interactable` | Optional advanced interactions           |
| 5       | `Projectile`   | Optional projectiles                     |

Configure physical **platform Body** nodes on layer `World`; configure the **player** on layer `Player` with a mask containing `World`; configure the kit's trigger `Area2D` nodes with mask `Player`. The starter scenes use **layer bit 1** for World, **layer bit 2** for Player, and `Area2D` mask `2`. Change these when importing into a game with a different layer layout.

> Layers describe where an object exists; masks describe what an object detects. Setting an `Area2D` mask to Player does *not* make it solid.

### Step 3.5 — Add input actions

The companion demo uses Godot's default `ui_left`, `ui_right`, and `ui_accept` actions. To support **manually activated switches**, create `interact` in **Project Settings → Input Map** and assign `E` or your preferred gamepad button. Auto-activation does not need that action.

---

## 4. Create a portable kit directory

### Step 4.1 — Add this folder to the project

```text
res://
├── addons/
│   └── level_elements_kit/
│       ├── scripts/
│       │   ├── le_element_2d.gd
│       │   ├── le_visual_preset.gd
│       │   ├── le_platform_base.gd
│       │   ├── le_moving_platform.gd
│       │   ├── le_conveyor_platform.gd
│       │   ├── le_collapsing_platform.gd
│       │   ├── le_bounce_pad.gd
│       │   ├── le_damage_zone.gd
│       │   ├── le_periodic_hazard.gd
│       │   ├── le_surface_zone.gd
│       │   ├── le_switch.gd
│       │   ├── le_checkpoint.gd
│       │   ├── le_collectible.gd
│       │   ├── le_destructible_platform.gd
│       │   └── le_exit_portal.gd
│       ├── scenes/
│       │   ├── staticplatform.tscn
│       │   ├── onewayplatform.tscn
│       │   ├── movingplatform.tscn
│       │   ├── collapsingplatform.tscn
│       │   ├── conveyorplatform.tscn
│       │   ├── bouncepad.tscn
│       │   ├── damagezone.tscn
│       │   ├── periodichazard.tscn
│       │   ├── surfacezone.tscn
│       │   ├── switch.tscn
│       │   ├── checkpoint.tscn
│       │   ├── collectible.tscn
│       │   ├── destructibleplatform.tscn
│       │   ├── exitportal.tscn
│       │   └── backgroundprop.tscn
│       └── presets/
│           ├── grease_canyon.tres
│           ├── pastry_palace.tres
│           ├── sticky_syrup_swamp.tres
│           ├── kitchen_mayhem.tres
│           ├── candy_chaos.tres
│           ├── egg_factory_frenzy.tres
│           ├── citrus_cascade.tres
│           └── bakery_bonanza.tres
├── demo/                     # Optional; not part of the transferable library
└── project.godot              # Your host game's settings
```

**Two installation paths:**

- **Fastest:** Extract the companion ZIP, open that directory as a Godot project, inspect the demo, then copy only `addons/level_elements_kit/` into your real game.
- **Manual:** Create the structure above in Godot's FileSystem dock, then implement each step from the GDScript scripts and scene trees described below. The companion source files provide the complete code for the first implementation.

**Important:** A portable collection of `.tscn` and `.gd` files works when placed under `addons/` even without `plugin.cfg`. A true `EditorPlugin` is optional and only needed later for custom docks, palette browsers, or special editor UI. You do **not** need to enable an editor plugin merely to instantiate these scenes.

### Step 4.2 — Prefer one-way dependencies

All kit scripts and `.tscn` files should reference **only other files within `addons/level_elements_kit/`**, Godot built-ins, or explicitly documented external interfaces. The demo may depend on the kit, but the kit must not depend on the demo or your BP2 game project.

---

## 5. Design the universal element contract

### Step 5.1 — Use one base `class_name`

Create `scripts/le_element_2d.gd`, marked `@tool`, extending `Node2D`, with `class_name LE_Element2D`. All example element scripts either extend this type or its `LE_PlatformBase` subclass.

### Step 5.2 — Standardize the Inspector fields

Every scene should provide at least:

| Inspector group | Exported property                | Purpose                                                                |
| --------------- | -------------------------------- | ---------------------------------------------------------------------- |
| Identity        | `element_id: String`             | Stable or level-local identifier (e.g. `egg_press_03`)                 |
| Identity        | `display_name: String`           | Human-readable title/debug text                                        |
| Identity        | `category: String`               | Tag matching the BP2 catalog categories                                |
| Appearance      | `element_size: Vector2`          | Visual dimensions; also drives rectangle collision for supported types |
| Appearance      | `visual_preset: LE_VisualPreset` | Shared thematic color/texture resource                                 |
| Appearance      | `show_placeholder: bool`         | Draw built-in colored/texture rectangle                                |
| Appearance      | `fill_color: Color`              | Direct placeholder color without a preset                              |
| Appearance      | `art_texture: Texture2D`         | Per-instance art texture override                                      |
| Appearance      | `texture_tint: Color`            | Texture tint                                                           |
| Debug Label     | `show_label_in_editor: bool`     | Design-time visibility                                                 |
| Debug Label     | `show_label_in_game: bool`       | Runtime visibility independent of editor setting                       |
| Debug Label     | `label_position_mode`            | Above / Below / Center / Custom                                        |
| Debug Label     | `label_offset: Vector2`          | Fine adjustment in local coordinates                                   |
| Debug Label     | `label_color: Color`             | Text color                                                             |
| Debug Label     | `label_font_size: int`           | Readable on-screen size                                                |

Each concrete element adds its own **Behavior** group: `travel`, `warning_seconds`, `damage`, `launch_velocity`, `belt_velocity`, etc. Name these consistently; avoid hidden magic constants in scripts.

### Step 5.3 — Preserve source catalog taxonomy

These are the **17 category tags from the attached document**:

```text
platform
moving_platform
collapsing_platform
slippery_surface
sticky_surface
hazard
soft_hazard
launcher
rope
switch
destructible
background_prop
foreground_fx
ambience_audio
boss_arena_element
evidence_prop
inclusive_detail
```

The starter base class also includes an `other` catch-all Inspector option for new concepts. Category tags are **metadata**, not an alternative to actual behavior scripts.

### Step 5.4 — Define a signal-first approach

Elements should inform the rest of the game using signals and/or optional methods on actors:

```gdscript
signal actor_hit(actor: Node2D, damage: int)
signal actor_launched(actor: Node2D, launch_velocity: Vector2)
signal toggled(is_on: bool)
signal reached(actor: Node2D, respawn_position: Vector2)
signal exit_requested(actor: Node2D, target_level_key: String)
```

This is critical to portability. The kit should not hard-code a player named `Player`, a global `GameManager`, your BP2 quest state, or a specific scene path for the next level.

---

## 6. Create Inspector-editable visuals and a debug label

This is the central feature of your request.

### Step 6.1 — Turn on editor execution

The first line of `le_element_2d.gd` should be:

```gdscript
@tool
extends Node2D
class_name LE_Element2D
```

`@tool` runs the script in the Godot editor so changing an exported color, texture, size, or label can update the scene **before running the game**. Subclasses of a `@tool` class should also use `@tool` when their editor behavior must run.

### Step 6.2 — Export editable properties

A minimal version of the mechanism looks like this:

```gdscript
@export_group("Identity")
@export var display_name: String = "Level Element":
    set(value):
        display_name = value
        _refresh()

@export_group("Appearance")
@export var element_size: Vector2 = Vector2(128, 24):
    set(value):
        element_size = value
        _refresh()

@export var fill_color: Color = Color.CORNFLOWER_BLUE:
    set(value):
        fill_color = value
        _refresh()
```

The full file in the kit adds presets, text formatting, show/hide toggles, texture rendering, and label positioning. A setter calls `_refresh()` whenever an exported value changes. The actual implementation guards against early calls before nodes are in the scene tree.

### Step 6.3 — Add `DebugLabel` to each scene

1. Open `staticplatform.tscn` (or create a new `Node2D` scene).
2. Add a `Label` node as a **direct child of the root**.
3. Rename it exactly `DebugLabel`.
4. Set its **Mouse → Filter** to **Ignore** so it does not obstruct editor/game input.
5. Leave its saved text as a fallback; the `@tool` script replaces it with `display_name` and optionally `[element_id]`.

The base script obtains the label using:

```gdscript
var label := get_node_or_null("DebugLabel") as Label
```

The text becomes:

```text
Citrus Wedge Lift [citrus_lift_02]
```

### Step 6.4 — Implement separate editor/game visibility

```gdscript
label.visible = show_label_in_editor if Engine.is_editor_hint() else show_label_in_game
```

Examples:

| Design setting       | Editor appearance  | Running game |
| -------------------- | ------------------ | ------------ |
| Editor ON, Game OFF  | Debug name visible | Hidden       |
| Editor ON, Game ON   | Visible            | Visible      |
| Editor OFF, Game OFF | Hidden             | Hidden       |
| Editor OFF, Game ON  | Hidden             | Visible      |

This is better than one `visible` toggle when you need detailed level-editing labels but clean gameplay screenshots.

### Step 6.5 — Implement label placement

The kit offers four placement modes:

- **Above:** center of label at `(-element_size.y / 2) - 18` vertically.
- **Below:** center of label at `(element_size.y / 2) + 18` vertically.
- **Center:** center of object.
- **Custom:** center plus `label_offset`.

All modes additionally apply `label_offset`, which means you can use **Above** and still move the label 20 pixels left/right or closer/further away.

The base script recalculates the label's size after a text or font change, then centers the label around its chosen anchor. You do **not** need to manually edit the `Label.position` on every scene instance.

### Step 6.6 — Implement placeholder drawing

The shared `_draw()` function:

1. Calculates `Rect2(-element_size * 0.5, element_size)`.
2. Draws a theme preset's or direct placeholder's fill color.
3. Draws a supplied `art_texture` when present, stretched to that rectangle.
4. Adds a thin border so placeholders remain legible.
5. Skips the built-in visual completely if `show_placeholder == false`.

To attach elaborate animated art later, set **Show Placeholder = OFF** and use child `Sprite2D`, `AnimatedSprite2D`, particles, or a composed visual sub-scene. The collider remains unchanged.

### Step 6.7 — Inspect the result

Drag `staticplatform.tscn` into a new scene, select its root, and try all of these **without running the game**:

- Rename to `Sizzling Bacon Strip`.
- Set `element_id = grease_ledge_01`.
- Change `element_size` to `(192, 20)`.
- Change `fill_color` to dark red.
- Toggle editor label off and back on.
- Set label position to **Below** and offset to `(20, 5)`.
- Assign a texture from the FileSystem dock to `art_texture`.

Expected result: visuals and debug text update immediately, and the platform can still be edited as a single scene instance.

> **Safety:** `@tool` executes inside the editor process. Avoid runtime gameplay, spawning/removing arbitrary nodes, and physics interactions while `Engine.is_editor_hint()` is `true`. Godot explicitly warns that editor-time scripts can modify open scenes destructively.

---

## 7. Build the first static platform

### Step 7.1 — Create the scene

In Godot, create a new scene with this exact tree:

```text
StaticPlatform (Node2D)
├── Body (StaticBody2D)
│   └── CollisionShape2D
└── DebugLabel (Label)
```

Choose a **RectangleShape2D** resource for `CollisionShape2D`, and set its initial size to `(128, 24)`.

### Step 7.2 — Keep rectangle resources instance-safe

Select the `RectangleShape2D` resource and enable **Resource → Local to Scene** in its Inspector. This matters because the root script changes `RectangleShape2D.size` in the editor; you want one platform's width change **not** to resize every other placed platform.

The starter `.tscn` files explicitly set `resource_local_to_scene = true` for their rectangle shapes.

### Step 7.3 — Attach the platform base script

Create `le_platform_base.gd`:

```gdscript
@tool
extends LE_Element2D
class_name LE_PlatformBase

@export_group("Collision")
@export var solid: bool = true:
    set(value):
        solid = value
        _refresh()

@export var one_way: bool = false:
    set(value):
        one_way = value
        _refresh()

func _refresh() -> void:
    super._refresh()
    if not is_inside_tree():
        return
    var collider := get_node_or_null("Body/CollisionShape2D") as CollisionShape2D
    if collider == null:
        return
    var rect := collider.shape as RectangleShape2D
    if rect != null:
        rect.size = element_size
    collider.one_way_collision = one_way
    if not Engine.is_editor_hint():
        collider.disabled = not solid
```

Attach this script to the **root `Node2D`**, not to `Body`. The root owns the Inspector fields, label, and placeholder art. The `StaticBody2D` child handles world collision.

### Step 7.4 — Configure the body

- `Body.collision_layer`: **World** (layer 1).
- `Body.collision_mask`: can be `0` for a passive platform; the player mask includes World.
- `Body.position`: `(0, 0)`.
- `CollisionShape2D.position`: `(0, 0)`.
- `CollisionShape2D.scale`: `(1, 1)`.

### Step 7.5 — Test two independent scene instances

1. Drag two copies of `staticplatform.tscn` into your level.
2. Name one **Chocolate Ledge**, width `160`, color brown.
3. Name the other **Bacon Ledge**, width `240`, color red.
4. Save and reopen the level scene.
5. Check that each retains its own size and color and that the collision matches its visible rectangle.

**Acceptance test:** A platform can be configured from the parent level's Inspector without opening or duplicating its source scene.

---

## 8. Create one-way platforms

Instead of a different behavior implementation, use the same `LE_PlatformBase`.

### Step 8.1 — Make a dedicated default scene

Duplicate `staticplatform.tscn`, rename it `onewayplatform.tscn`, and set root Inspector **One Way = ON**. The companion pack already includes this template.

### Step 8.2 — Understand the collision setting

In Godot 4, `CollisionShape2D.one_way_collision` allows collision from the configured front side while passing through from the opposite direction. With an unrotated horizontal platform, this supports jumping through from below and landing on top.

**Test:** jump upward from below, pass through the ledge, then fall onto it. If this does not work, inspect collision shape orientation, layers, player collision and one-way margin. **Drop-through** on command is a separate player feature, not included by turning one-way collision on.

---

## 9. Build moving platforms

Your catalog repeatedly needs moving platforms: pancake rafts, frying-pan lifts, sorting trays, citrus wedge lifts, and conveyor trays.

### Step 9.1 — Create the scene tree

```text
MovingPlatform (Node2D, le_moving_platform.gd)
└── Body (AnimatableBody2D)
    ├── CollisionShape2D (RectangleShape2D, Local to Scene ON)
    └── DebugLabel (Label)
```

Use an **`AnimatableBody2D`**, because Godot estimates its motion velocity for interaction with other bodies. The starter uses its `sync_to_physics = true` default.

### Step 9.2 — Add motion properties

```gdscript
@export_group("Motion")
@export var travel: Vector2 = Vector2(200, 0)
@export_range(1, 1000, 1) var speed_px_per_second: float = 90.0
@export var motion_enabled: bool = true
```

The scene's placed position is its starting point. `travel` is an **offset relative to that point**, not an absolute target coordinate.

### Step 9.3 — Move on the physics tick

The kit's `le_moving_platform.gd`:

- Inherits `LE_PlatformBase`.
- Keeps the placed root `Node2D` stationary as the starting anchor, recording `Body.position` in `_ready()`.
- Advances distance by `speed_px_per_second * delta` in `_physics_process()`.
- **Moves `Body.position`, not the root `position`**, to notify `AnimatableBody2D` correctly with `sync_to_physics = true`.
- Draws the starter placeholder at the body's offset; `DebugLabel` is parented to `Body` so it follows the collision.
- Parents any additional moving artwork under `Body`, not under the stationary root.
- Reverses direction at the end of the `travel` vector.
- Supports `set_enabled(bool)` so switches can pause movement.
- Does **not** animate the platform during editor inspection.

Example configurations:

| Object               |        Travel | Speed |
| -------------------- | ------------: | ----: |
| Frying-pan elevator  |   `(0, -220)` |  `70` |
| Pancake raft         |    `(300, 0)` |  `55` |
| Citrus wedge lift    | `(160, -160)` |  `85` |
| Factory sorting tray |    `(400, 0)` | `120` |

### Step 9.4 — Test rider movement

- A player standing on the platform should travel with it.
- A jumping player should be able to leave it normally.
- Motion should be frame-rate independent.
- Test 30, 60, and 120 rendering FPS; physics movement still uses fixed ticks.
- For reliable player contact, verify your player calls `move_and_slide()` and uses `CharacterBody2D` platform-following behavior. Some custom controllers override the default platform velocity handling.
- Test moving vertically against ceilings and walls to avoid accidental player crushing.

**Upgrade later:** replace the two-endpoint `travel` model with a `Path2D`/`PathFollow2D` route or explicit waypoint Resource for curved, looped, or multi-stop motion. This is especially useful for rails and transport machinery. Avoid abruptly teleporting a rideable platform back to its start while someone is standing on it.

---

## 10. Build collapsing platforms

Your catalog has brittle pastry floors, cracked eggshells, sinking pancakes, brittle candy glass, and collapsing dough.

### Step 10.1 — Scene tree

```text
CollapsingPlatform (Node2D, le_collapsing_platform.gd)
├── Body (StaticBody2D)
│   └── CollisionShape2D
├── Trigger (Area2D)
│   └── CollisionShape2D
└── DebugLabel (Label)
```

### Step 10.2 — Place the top trigger

The kit uses a thin **8px strip** immediately **above the platform**. For height `h`, its local Y position is `-h/2 - 4`. The trigger rectangle width follows `element_size.x`. This better approximates “the player stands on it” than an `Area2D` covering the whole object, which would fire from side contact too.

Set the Trigger's collision mask to **Player** and its layer to `0`.

### Step 10.3 — Implement the state sequence

```text
READY
   │ player enters top trigger
   ▼
WARNING   (warning_started signal; optional shake/cracks/sound)
   │ warning_seconds elapses
   ▼
COLLAPSED (collision disabled; visual hidden)
   │ respawn_seconds elapses
   ▼
READY     (visual restored; collision restored)
```

The kit's script exports `warning_seconds` and `respawn_seconds`, uses timer awaits, and emits `warning_started`, `collapsed`, and `restored`. It uses `set_deferred("disabled", true)` when changing a collision shape during gameplay.

### Step 10.4 — Add a proper warning visual

In the first implementation, connect `warning_started` to one of the following:

- A short `AnimationPlayer` shake.
- An `AnimatedSprite2D` cracking animation.
- A temporary warning color and a sound effect.
- Dust crumbs emitted from `GPUParticles2D`.

The starter implements timing and collision state, **not** a polished crack animation. The warning must be visually obvious before using the platform in a difficult level.

### Step 10.5 — Add variants using the same script

- Eggshell: fast break, medium restore.
- Sinking pancake: longer warning, descending visual during warning.
- Sugar glass: near-instant break, shard effect.
- Bakery dough: sagging warning and puff on collapse.

These should be thematic variations, not copies of the behavior code.

---

## 11. Build conveyor platforms

The catalog uses factory conveyor belts and bakery trays, with switches that reverse their direction.

### Step 11.1 — Start from a static platform

```text
ConveyorPlatform (Node2D, le_conveyor_platform.gd)
├── Body (StaticBody2D)
│   └── CollisionShape2D
└── DebugLabel (Label)
```

### Step 11.2 — Configure contact velocity

`StaticBody2D` provides `constant_linear_velocity`: the body stays in place visually but imparts velocity to contacting physics bodies.

```gdscript
@export var belt_velocity: Vector2 = Vector2(100, 0)

func _apply_belt() -> void:
    if not is_inside_tree():
        return
    var body := get_node("Body") as StaticBody2D
    body.constant_linear_velocity = belt_velocity if belt_enabled else Vector2.ZERO
```

The starter additionally exports `belt_enabled`, `set_enabled(bool)`, and `reverse()`.

### Step 11.3 — Add belt art and directional readability

Use animated belt arrows, roller rotation, or a scrolling material to convey direction. The starter changes physics contact velocity; **it does not provide scrolling belt visuals**.

### Step 11.4 — Test with more than one actor type

Godot physics contact velocity works best when actors use compatible physics movement. Verify your `CharacterBody2D` player *and* your enemy or box controllers handle it as intended. A manually scripted actor that ignores floor/platform motion may need explicit conveyor integration.

---

## 12. Build bounce pads and launchers

Use this family for gumdrops, pancakes, soft bread, and juice-fountain launchers.

### Step 12.1 — Scene tree

```text
BouncePad (Node2D, le_bounce_pad.gd)
├── Body (StaticBody2D)
│   └── CollisionShape2D
├── Trigger (Area2D)
│   └── CollisionShape2D   # narrow strip above pad
└── DebugLabel (Label)
```

### Step 12.2 — Export the launch vector

```gdscript
@export var launch_velocity: Vector2 = Vector2(0, -520)
```

Godot's default 2D coordinates have **positive Y downward**. Therefore `(0, -520)` launches upward. `(260, -420)` launches diagonally up and right.

### Step 12.3 — Use a player capability contract

The script calls `body.apply_launch(launch_velocity)` when available. If that method does not exist but the detected body is `CharacterBody2D`, it falls back to assigning `body.velocity = launch_velocity`.

Implement this in your player for the most predictable integration:

```gdscript
func apply_launch(new_velocity: Vector2) -> void:
    velocity = new_velocity
```

If your controller recalculates vertical velocity or blocks external impulses each tick, adapt that controller to preserve the launch velocity. Later, add a cooldown or active-contact check for bounce pads that should repeatedly launch a player while overlapping.

### Step 12.4 — Debug labels for launchers

Consider setting the display name to `Gumdrop Pad (↑)` and placing the debug label above it. As an optional next step, add a `@tool` editor gizmo to draw the actual `launch_velocity` arrow; that is a more accurate level-authoring aid than text alone.

---

## 13. Build hazards, timed hazards, and surface zones

### 13.1 Static damage zone

```text
DamageZone (Node2D, le_damage_zone.gd)
├── Area (Area2D)
│   └── CollisionShape2D
└── DebugLabel (Label)
```

Export `damage` and `active`. On body entry, emit:

```gdscript
actor_hit.emit(body, damage)
if body.has_method("receive_damage"):
    body.call("receive_damage", damage, global_position)
```

This separates the **effect** from your game's specific health UI, invincibility logic, knockback, sound, or respawn implementation.

Useful presets: acid pool, molten chocolate, sugar spikes, boiling grease, hot griddle, and blade hitbox.

**Important:** The starter deals damage on **entry**, not automatically every frame while inside the hazard. For continuous pools, add a per-actor hit interval/cooldown if repeated damage is part of your design; do not call damage every physics tick.

### 13.2 Timed damage zone

The provided `periodichazard.tscn` and `le_periodic_hazard.gd` extend the damage zone with:

1. `idle_seconds` — inactive, safe.
2. `warning_seconds` — telegraph, still non-damaging.
3. `attack_seconds` — active damaging overlap.
4. Loop back to idle.

The starter switches placeholder colors from idle to warning to danger. Attach animations and sounds for real production readability. This is a basis for burner flames, grease splashes, pop-candy bursts, oven fires, and steam/juice timed jets.

For a crusher, rotating blade, or falling projectile, **the spatial motion and collision are separate mechanics**: reuse the same warning/active concept, but implement the moving geometry using the appropriate body and transform logic.

### 13.3 Sticky and slippery surface zone

```text
SurfaceZone (Node2D, le_surface_zone.gd)
├── Area (Area2D)
│   └── CollisionShape2D
└── DebugLabel (Label)
```

Export two separate dimensions:

| Field                 | Interpretation                                    | Example           |
| --------------------- | ------------------------------------------------- | ----------------- |
| `speed_multiplier`    | Multiply desired walking speed                    | `0.45` for syrup  |
| `traction_multiplier` | Multiply acceleration/deceleration responsiveness | `0.20` for grease |

**Sticky example:** `speed_multiplier = 0.45`, `traction_multiplier = 0.60`.

**Slippery example:** `speed_multiplier = 1.00`, `traction_multiplier = 0.18`.

The zone uses optional actor methods:

```gdscript
func enter_surface(token: int, speed_factor: float, traction_factor: float) -> void:
    # Save modifier for this particular area.
    pass

func exit_surface(token: int) -> void:
    # Remove exactly this area's modifier.
    pass
```

The supplied demo player implements these functions and combines multiple overlapping modifiers. The kit passes each source zone's runtime instance ID as the `token`, so two overlapping zones can be removed independently.

**Surface zones are not floors.** A syrup puddle `Area2D` should be placed above or overlapping a solid platform/terrain collider. If you want it to be a physical platform too, compose it with a static platform scene.

### 13.4 Soft hazards and visibility clouds

For flour, mist, smoke, or steam: start with non-colliding visual effects that have `show_placeholder = false`, then optionally add an `Area2D` for status effects. The gameplay-side `camera_visibility_multiplier` or temporary opacity changes should be expressed as a separate effect contract. Avoid making lethal hazards unreadable beneath clouds.

---

## 14. Build switches, checkpoints, pickups, destructibles, and exits

These are not all “platforms,” but they are worth building early because they allow reusable pieces to form playable levels.

### 14.1 Switches and valves

The kit's `switch.tscn` has a root wrapper plus an `Area2D` and `DebugLabel`. It exports `auto_activate_on_touch` and `starts_on`, and emits `toggled(is_on: bool)`.

Connect a switch to a conveyor in the **level scene's script**:

```gdscript
func _ready() -> void:
    $Switch.toggled.connect($Conveyor.set_enabled)
    $Conveyor.set_enabled(false)
```

Now entering the switch enables/disables the conveyor. You can connect to multiple targets, or invert the bool with a small adapter method.

For Egg Factory **Reversible Conveyor Switch**, connect the switch's signal to an adapter that calls the conveyor's `reverse()` only when appropriate; do not assume `set_enabled()` means “reverse.” For syrup and citrus valves, connect the signal to a flow controller or launcher controller.

For a manual switch, disable automatic activation, create the `interact` input action, and press it while overlapping the area. Extend the sample's one-body-in-range logic if multiple players can use a switch.

### 14.2 Checkpoints and respawning

`checkpoint.tscn` emits `reached(actor, respawn_position)` and optionally calls `actor.set_checkpoint(...)`. The exported `respawn_offset` lets you position the actual spawn point above a flag/marker so the player does not respawn inside its collider.

Your player or game controller is responsible for saving that position and respawning after damage or a pit fall. The kit does not own player lives or save files.

### 14.3 Collectibles and evidence props

`collectible.tscn` exports `item_id` and `score_value`, emits `collected(actor, item_id, score_value)` and then frees itself.

Use it for coins, bonus items, ingredients, and BP2 **evidence props**. For persistent evidence across saves, assign a **unique item ID** and have a save manager record collected IDs; the sample does not persist them.

### 14.4 Destructible barriers

`destructibleplatform.tscn` exports `max_health`, accepts `receive_damage(amount, source)`, emits `health_changed` and `destroyed`, then disables collision when health reaches zero.

This covers dish-pile and baking-tray boss cover as basic destructible geometry. Add damage hit reactions, particles, and boss-specific consequences through the `destroyed` signal in the hosting level, rather than introducing boss logic into the reusable kit.

### 14.5 Level exits

`exitportal.tscn` exports `target_level_key` and emits `exit_requested(actor, target_level_key)`. The host game's LevelManager resolves that key to an actual level file. This avoids hardcoding BP2 levels into a library intended for other platformers.

### 14.6 Why these additions matter

These five interaction types are **recommended additions** for a useful generic kit. Your document already explicitly contains switches, evidence, destructibles, boss arena triggers, and related interactions; checkpoints, standard collectibles, and level exits are broader platformer infrastructure added to support a complete gameplay loop.

---

## 15. Create thematic appearances and variants

### Step 15.1 — Introduce a preset Resource

The kit includes:

```gdscript
@tool
extends Resource
class_name LE_VisualPreset

@export var theme_name: String = "Custom"
@export var fill_color: Color = Color(0.31, 0.64, 0.91)
@export var texture: Texture2D
@export var texture_tint: Color = Color.WHITE
```

The actual script includes property setters that emit `changed`, so an open element updates when you change a shared preset's color or texture. The base element listens for that signal and redraws itself.

### Step 15.2 — Create a preset resource in the editor

1. In `addons/level_elements_kit/presets/`, right-click → **New Resource**.
2. Search for `LE_VisualPreset`.
3. Save as `grease_canyon.tres`.
4. Give it a descriptive name, base color, texture (optional), and texture tint.
5. Repeat for your other themes, or use the eight color-only `.tres` files already provided.

The starter's themes deliberately use **placeholder colors**, not final food textures.

### Step 15.3 — Apply a theme to an instance

1. Open a level.
2. Drag in `movingplatform.tscn`.
3. Select its root.
4. Drag `citrus_cascade.tres` onto **Appearance → Visual Preset**.
5. Change the display name to `Citrus Wedge Lift`.
6. Set `travel = (0, -180)` and adjust the speed.
7. Optionally assign an `art_texture` directly; a per-instance texture takes precedence over the preset texture.

In the supplied implementation, **preset fill color takes precedence over root fill color** while a preset is assigned. Clear `visual_preset` to use the instance's direct `fill_color`. This explicit rule avoids ambiguity about visual overrides.

### Step 15.4 — Understand shared Resource edits

A referenced `.tres` is shared: editing `citrus_cascade.tres` updates every instance that uses it. That is desirable when retheming a whole level. For a one-off variant, make the preset unique or create another `.tres` rather than unintentionally editing a shared asset.

### Step 15.5 — Consider themed PackedScene variants

If a designer places Bacon Platforms very frequently, create a variant scene that **inherits from** `staticplatform.tscn` and defaults to the Grease Canyon preset and your chosen label. A variant can be named `bacon_strip_platform.tscn` and still inherit the common physics/script behavior.

**Recommended split:**

- Use `.tres` for reusable **appearance data**.
- Use `.tscn` for reusable **arrangements of nodes, visual FX, and behavior**.
- Use per-instance exported values for **placement-specific properties**.
- Use `class_name` scripts for shared **behavior contracts**.

### Step 15.6 — Art production upgrades

The sample `draw_texture_rect` stretches one texture across the element rectangle. That is fine for sketches and flat sprites, but production platforms may need:

- `Sprite2D` and `AnimatedSprite2D` for characterful art.
- `NinePatchRect` (CanvasItem/UI treatment) or a custom 2D mesh/shader for stretch-safe borders.
- A repeated/tiled material for long metal belts or countertops.
- `TileMapLayer` terrain for long contiguous surfaces.
- Separate foreground lip, surface, underside, and shadow sprites for complex platform styling.
- A visual-only deformation animation for wobbling platforms; retain a simple stable hitbox.

Never let the food silhouette automatically determine an overly complex collision shape. Simplified physics is generally more readable and stable.

---

## 16. Integrate an existing player and level manager

This is the one part **intentionally not fully portable**: your actual player controller owns movement, health, scoring, and respawn. The kit defines **optional interfaces** so integration does not require rewriting your existing code.

### Step 16.1 — Player collision

If your player extends `CharacterBody2D`:

- Player collision layer: Player (bit 2 in sample).
- Player collision mask includes World (bit 1).
- Trigger Areas mask Player.
- Movement uses `_physics_process(delta)` and `move_and_slide()`.
- Consider `floor_snap_length` and moving-platform leave behavior if your controls need special treatment.

### Step 16.2 — Add optional actor methods

```gdscript
# Put equivalent methods in your own player script.
func apply_launch(launch: Vector2) -> void:
    velocity = launch

func receive_damage(amount: int, source: Vector2) -> void:
    # Apply health, invulnerability, knockback or respawn rules.
    pass

func set_checkpoint(world_position: Vector2) -> void:
    # Save the active checkpoint for respawn.
    pass

func enter_surface(token: int, speed_factor: float, traction_factor: float) -> void:
    # Store per-zone movement modifiers.
    pass

func exit_surface(token: int) -> void:
    # Remove that zone's modifier.
    pass
```

The actual companion demo includes minimal implementations of all of these. They illustrate the contract; do not replace your existing game-specific player architecture without reviewing its mechanics.

### Step 16.3 — Handle health responsibly

A production `receive_damage` implementation should account for:

- Temporary invincibility and repeated overlaps.
- Knockback direction.
- Damage type (`heat`, `acid`, `sharp`, `impact`) if equipment like Oven Mitts reduces selected damage.
- Death/respawn transition and save-state handling.
- Audio, particles, hit flash, and accessibility options.

**Suggested future interface:** extend the integer damage example with a reusable `LE_DamageInfo` Resource containing amount, damage type, source identifier, impulse, and invulnerability bypass flag. Introduce this *after* the simple hit API is working, to avoid unnecessary complexity at the beginning.

### Step 16.4 — Handle level exit events

```gdscript
func _on_exit_requested(_actor: Node2D, key: String) -> void:
    match key:
        "grease_canyon":
            get_tree().change_scene_to_file("res://levels/grease_canyon.tscn")
        "pastry_palace":
            get_tree().change_scene_to_file("res://levels/pastry_palace.tscn")
        _:
            push_warning("Unrecognized level key: " + key)
```

This example belongs in the **host game**, not inside `addons/level_elements_kit/`. A larger game should use a level registry or manager instead of an ever-growing `match` statement.

### Step 16.5 — Keep actor detection configurable in later versions

The starter restricts many interactions to `CharacterBody2D`, and triggers to the Player layer. This is enough for a one-player prototype. To use the same kit with enemies, companions, rigid physics crates, or multiplayer actors, add exported collision masks and an actor eligibility convention such as `is_in_group("damageable")`, `is_in_group("launchable")`, or explicit methods. Avoid matching a node's exact name.

---

## 17. Map the BP2 catalog to reusable systems

The following mapping uses **content from your supplied file**. Entries without a finished starter component are marked as an extension or a composition of simpler components.

### 17.1 Grease Canyon

| Catalog objects                                     | Reuse / implementation                                       |
| --------------------------------------------------- | ------------------------------------------------------------ |
| Sizzling Bacon Strip Platform                       | Static platform + Bacon preset                               |
| Bacon Wiggle Platform                               | Static platform + visual wobble `AnimationPlayer` extension  |
| Fat Drip Edge                                       | Decorative prop + drip particles (optional damaging variant) |
| Boiling Grease Pit                                  | Damage zone + animated liquid visuals                        |
| Grease Splash, Dripping Grease                      | Periodic hazard; moving-droplet extension for falling grease |
| Sausage-Link Rope                                   | Rope/climb system, Phase 3                                   |
| Sizzling Griddle                                    | Static platform + damage zone if hot                         |
| Giant Cracked Egg Sky Prop, Bacon Grease Blob Cloud | Background prop / parallax                                   |
| Bacon Comet                                         | Moving background prop / parallax motion                     |
| Bacon Spiral Column                                 | Static platform / boss arena obstacle                        |
| Bacon Tornado FX Loop                               | Boss FX + moving damage zone, Phase 3                        |
| Hanging Bacon Strip Hazard                          | Pendulum hazard, Phase 3                                     |
| Rainbow-Tinted Bacon Flag                           | Inclusive background prop                                    |
| Grease Canyon Ambiance                              | Audio and FX environment group                               |

### 17.2 Pastry Palace

| Catalog objects                    | Reuse / implementation                                    |
| ---------------------------------- | --------------------------------------------------------- |
| Croissant Platform, Donut Platform | Static platform + Pastry preset; customize art/hitbox     |
| Rotating Mixer Arm                 | Rotating platform / rotating hazard extension             |
| Giant Mixing Bowl                  | Background prop or arena geometry                         |
| Sticky Frosting Surface            | Surface zone (sticky)                                     |
| Brittle Pastry Floor               | Collapsing platform                                       |
| Falling Pastry                     | Telegraph + falling hazard extension                      |
| Cream Jet                          | Periodic hazard or status-inflicting projectile extension |
| Pastry Shelf                       | Static platform / decorative prop                         |
| Crumb Trail                        | Evidence/guide prop; possibly collectible sequence        |
| Powdered Sugar Particle, Ambiance  | Foreground particles + audio                              |

### 17.3 Sticky Syrup Swamp

| Catalog objects             | Reuse / implementation                                          |
| --------------------------- | --------------------------------------------------------------- |
| Pancake Raft                | Moving platform + syrup visuals                                 |
| Syrup-Coated Log            | Static platform + surface zone                                  |
| Pancake Stack               | Cluster or reusable scene composed of multiple static platforms |
| Buttered Pancake Bounce Pad | Bounce pad                                                      |
| Sinking Pancake             | Collapsing platform + optional sinking animation                |
| Deep Syrup Pool             | Damage zone or reset hazard                                     |
| Syrup Puddle                | Surface zone (sticky)                                           |
| Dripping Syrup              | Falling/timed hazard extension + optional persistent puddle     |
| Syrup Valve                 | Switch linked to flow/launcher/moving platform                  |
| Syrup Waterfall, Amber Mist | Background/foreground prop; optional zone collider              |
| Sticky Syrup Swamp Ambiance | Audio, haze and particles                                       |

### 17.4 Kitchen Mayhem

| Catalog objects           | Reuse / implementation                             |
| ------------------------- | -------------------------------------------------- |
| Countertop, Cutting Board | Static platform; sliding variant = moving platform |
| Pot Lid Platform          | Rotating/tilting platform extension                |
| Dish Rack Climb           | Static ledges or climbable structure extension     |
| Swinging Utensil          | Pendulum traversal/hazard extension                |
| Kitchen Cart              | RigidBody2D pushable platform extension            |
| Chopping Knife            | Periodic hazard + moving weapon visual/physics     |
| Steam Vent                | Periodic pushback + mist extension                 |
| Falling Pan               | Falling hazard extension                           |
| Burner Flame              | Periodic hazard                                    |
| Rolling Can               | RigidBody2D rolling hazard extension               |
| Dishwater Spill           | Surface zone (slippery)                            |
| Dish Pile Cover           | Destructible platform                              |
| Kitchen Mayhem Ambiance   | Audio + steam FX                                   |

### 17.5 Candy Chaos

| Catalog objects                             | Reuse / implementation                        |
| ------------------------------------------- | --------------------------------------------- |
| Gumdrop Platform                            | Bounce pad                                    |
| Candy Bridge                                | Static or collapsing platform                 |
| Chocolate Bar Platform, Cake Layer Platform | Static platform                               |
| Licorice Rope                               | Rope/climb system, Phase 3                    |
| Hard Candy Disc                             | Rotating platform extension                   |
| Chocolate Lava, Sugar Spike                 | Damage zone                                   |
| Brittle Candy Glass                         | Collapsing/destructible platform + shatter FX |
| Candy Ball Roller                           | Rolling hazard extension                      |
| Sticky Caramel Pool                         | Surface zone (sticky)                         |
| Pop Candy Burst                             | Periodic hazard                               |
| Sprinkler Switch                            | Switch linked to boss mechanism               |
| Candy Chaos Ambiance                        | Audio + particle FX                           |

### 17.6 Egg Factory Frenzy

| Catalog objects               | Reuse / implementation                            |
| ----------------------------- | ------------------------------------------------- |
| Conveyor Belt                 | Conveyor platform                                 |
| Cracked Eggshell Platform     | Collapsing platform                               |
| Frying-Pan Lift, Sorting Tray | Moving platform                                   |
| Egg-Carton Ledge              | Static platform                                   |
| Egg Chute                     | Reusable spawn/emitter extension                  |
| Crushing Press                | Crusher + timed hazard extension                  |
| Yolk Spill                    | Surface zone (slippery or sticky based on design) |
| Egg Bomb                      | Timed explosion/spawner extension                 |
| Shell Shards                  | Damage zone                                       |
| Reversible Conveyor Switch    | Switch + conveyor reverse integration             |
| Egg Factory Ambiance          | Machine/audio FX                                  |

### 17.7 Citrus Cascade

| Catalog objects                            | Reuse / implementation                          |
| ------------------------------------------ | ----------------------------------------------- |
| Orange-Slice Platform, Juice-Pipe Platform | Static platform                                 |
| Citrus Wedge Lift, Floating Peel Platform  | Moving platform                                 |
| Pulp Mat                                   | Surface zone (sticky)                           |
| Juice Fountain Launcher                    | Bounce pad / launcher with directional velocity |
| Orange Juice Stream                        | Conveyor/push movement + slippery surface zone  |
| Juice Jet                                  | Timed pushback extension                        |
| Citrus Acid Pool                           | Damage zone                                     |
| Rolling Orange Peel                        | Rolling hazard extension                        |
| Juicer Blade                               | Rotating hazard extension                       |
| Citrus Pipe Valve                          | Switch                                          |
| Citrus Cascade Ambiance                    | Mist, water and audio FX                        |

### 17.8 Bakery Bonanza

| Catalog objects                    | Reuse / implementation                         |
| ---------------------------------- | ---------------------------------------------- |
| Giant Oven, Oven Tower             | Background / composed structure                |
| Conveyor Tray, Muffin Conveyor     | Moving or conveyor platform, spawn visuals     |
| Rising Dough Platform              | Moving platform + scale/visual cycle extension |
| Collapsing Dough Platform          | Collapsing platform                            |
| Flour Cloud, Flour Puff            | Visibility effect / foreground FX extension    |
| Metal Stairs, Giant Bread Loaf     | Static platforms, optional bounce variation    |
| Bakery Pipe                        | Background structure / hazard source           |
| Hot Oven Flame                     | Periodic hazard                                |
| Falling Baking Tray                | Falling hazard extension                       |
| Rolling Muffin Tray                | Rolling hazard extension                       |
| Baking Tray Cover                  | Destructible platform                          |
| Oven Mitt Protection Zone / Pickup | Pickup + player damage-resistance contract     |
| Bakery Bonanza Ambiance            | Audio, glow and flour FX                       |

### 17.9 Read the Cross-Level Reuse Map as an implementation roadmap

Your catalog's final matrix groups: slippery surfaces, sticky surfaces, ropes/swings, launchers, rolling hazards, visibility blockers, and crushers. Turn each row into a **reusable behavior component** and each column into an **appearance/configuration preset**. This is the key to transferring the whole system to a future non-food platformer: new games need new theme presets and level designs, not copies of every behavior script.

---

## 18. Add the missing systems that a real platformer needs

The items below are **recommendations that expand beyond the uploaded catalog**, or advanced implementations of mechanisms it describes. Implement them as reusable components rather than game-level special cases.

### 18.1 Essential generic level infrastructure

| Addition                       | Why useful                                      | Suggested implementation                                   |
| ------------------------------ | ----------------------------------------------- | ---------------------------------------------------------- |
| Spawn point                    | Consistent initial player placement             | `Marker2D` + spawn identifier                              |
| Checkpoint                     | Recovery and level pacing                       | Included in starter                                        |
| Kill plane / reset zone        | Falling below level safely                      | Damage zone variant that requests respawn                  |
| Level exit / door              | Reusable progression                            | Included logical exit portal                               |
| One-way drop-through           | Standard 2D control                             | Player movement mechanic; temporarily ignore one-way floor |
| Timed door / gate              | Switch puzzles                                  | `AnimatableBody2D` + switch signal                         |
| Camera boundary / focus region | Prevent camera showing outside level            | `Area2D` trigger, host camera controller                   |
| Tutorial/hint sign             | In-editor note and player hint                  | Element metadata + localized text                          |
| Secret-area trigger            | Optional discovery                              | `Area2D` + found signal                                    |
| Generic trigger relay          | Connect multiple systems without tight coupling | `Area2D` or switch + emitted signal                        |
| Persistent collectible         | Save-supported evidence and pickups             | Collectible + host SaveManager                             |
| Breakable obstacle             | Route-gating and cover                          | Included destructible base                                 |

### 18.2 Advanced traversal systems

| Addition                        | Design notes                                                                                                                                       |
| ------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| Ladder/climb zone               | Player state machine enters climb mode; don't implement ladder behavior entirely inside the prop                                                   |
| Swing rope                      | Could use constrained physics with `RigidBody2D` joints, or a deterministic custom swing controller; requires player handoff and release mechanics |
| Wall-jump / wall-cling surface  | Player controller behavior plus metadata zone                                                                                                      |
| Directional launch zone         | Normalize a direction and set impulse magnitude; optionally preview arc in editor                                                                  |
| Rotating platform/disc          | Rotate carefully with proper physics interaction and player velocity transfer                                                                      |
| Falling platform / falling tray | Telegraph, then switch to a falling body or scripted descent                                                                                       |
| Waypoint/rail platform          | `Path2D`/waypoint Resource and optional pause/direction controls                                                                                   |
| Push/pull cart                  | `RigidBody2D` or constrained scripted movement; prevent unpredictable pileups                                                                      |
| Wind/steam/juice force field    | `Area2D` influence with player/rigidbody integration                                                                                               |

### 18.3 Advanced hazards and machinery

| Addition                   | Design notes                                                               |
| -------------------------- | -------------------------------------------------------------------------- |
| Pendulum hazard            | Explicit pivot + visual safe/danger regions                                |
| Rotating blade/mixer       | Rotating motion and matching damage hitbox                                 |
| Crusher                    | Telegraph → descend → contact/damage → recovery, with safe retreat spacing |
| Projectile emitter / chute | Exported `PackedScene`, interval, direction, speed, maximum count          |
| Rolling hazard             | `RigidBody2D` + well-defined spawn/despawn behavior                        |
| Explosion                  | Trigger/fuse, blast area, one-shot damage, cleanup                         |
| Debris                     | Mostly visual; limit active physics pieces to protect performance          |
| Visibility cloud           | Never make hazards visually indistinguishable from scenery                 |
| Status effect zone         | Slowed, slippery, heat resistance, blindness; stack by source token        |
| Boss arena control         | Door lock/unlock, hazard lanes, switch targets, encounter manager signals  |

### 18.4 Accessibility and debugging features

Recommended additional fields for future versions:

```text
editor_note: String          # Optional multiline designer comment
hazard_severity: enum        # None / Soft / Damage / Fatal
show_collision_preview: bool # Editor overlay only
show_motion_preview: bool    # Motion path and endpoint markers
show_launch_vector: bool     # Arrow + magnitude
colorblind_safe_cue: bool    # Pattern/icon cue, not color alone
accessibility_hint: String   # Designer guidance on readability
```

Debug labels should not become an accessibility substitute. For players, readable sprites, warning shapes/patterns, audio cues, contrast, and configurable effects are more important than debug-only text.

### 18.5 Audio and visuals should be optional components

Add `LE_AmbienceController` (background audio and effect configuration), `LE_OneShotFX` (triggered particles + sound), and optionally `LE_VisualState` (idle/warn/active/destroyed art states). Keep gameplay possible without these optional resources. This allows the behavior kit to remain usable in other genres/styles.

---

## 19. Editor workflow and authoring guidelines

### 19.1 Daily element-authoring workflow

For a new themed level:

1. Create a level scene with a predictable `Node2D` root.
2. Add `TileMapLayer` for bulk terrain if you have a tileset; add unique mechanics as scene instances.
3. Drag a reusable component `.tscn` from the kit's `scenes/` folder into the level scene.
4. Change **Identity → Display Name**.
5. Assign an informative **Element ID** for interactive/scripted objects.
6. Select the right **Category** tag.
7. Set **Appearance → Element Size** and either **Visual Preset**, **Fill Color**, or **Art Texture**.
8. Choose **Debug Label → Position Mode / Offset**; leave game visibility off unless testing.
9. Configure behavior (speed, travel, warning, launch, damage, etc.).
10. Connect required signals in the hosting level (switch targets, score, boss mechanisms, progression).
11. Save the level, run the scene, and inspect visible collision shapes.

### 19.2 A sample Inspector configuration

```text
MovingPlatform
  Identity
    Element ID           citrus_lift_02
    Display Name         Citrus Wedge Lift
    Category             moving_platform
  Appearance
    Visual Preset        citrus_cascade.tres
    Element Size         (160, 26)
    Art Texture          [optional citrus sprite]
    Show Placeholder     true
  Debug Label
    Show Label In Editor true
    Show Label In Game   false
    Position Mode        Above
    Label Offset         (0, -4)
    Label Font Size      13
  Collision
    Solid                true
    One Way              false
  Motion
    Travel               (0, -200)
    Speed Px Per Second  75
    Motion Enabled       true
```

### 19.3 Put unique IDs where they matter

`display_name` is for humans and can repeat. `element_id` is for stable references, save systems, event reporting, and editor debugging. It should be unique within an appropriate scope, typically a level. For example:

```text
candy_bridge_05
factory_conveyor_03
syrup_valve_A
bakery_evidence_12
```

The current starter does not automatically enforce uniqueness; add a validator later. Avoid using `Node.name` as a save-game identifier, because editor refactors and duplicated scene instances can change it.

### 19.4 When to use `TileMapLayer` instead of instances

Use individual scenes for objects with unique behaviors, settings, animations, signals, or designer notes. Use `TileMapLayer` for large repeated terrain surfaces with tile collision. You can mix the two: a tile layer creates the kitchen floor, while a single scene instance places a collapsing pastry tile or a timed burner on top.

### 19.5 Scene inheritance versus composition

- **Scene inheritance:** good for `StaticPlatform → BaconPlatform` when the variant primarily changes defaults and visuals.
- **Composition:** good for `StaticPlatform + SurfaceZone` or `StaticPlatform + DamageZone` when two independent behaviors coexist.
- **Script inheritance:** good for common platform collider synchronization and shared behavior interfaces.
- **Avoid giant “do everything” scripts:** a platform with `is_moving`, `is_slippery`, `is_hot`, `is_bouncy`, `is_breakable`, `is_a_switch` and dozens of interdependent branches will become hard to maintain.

---

## 20. Testing and debugging checklist

### 20.1 Visual/editor checks

- [ ] Drag a scene into a level without errors.
- [ ] Root Inspector shows Identity, Appearance, Debug Label, and relevant Behavior groups.
- [ ] Editing `display_name` updates text **in the editor**.
- [ ] `element_id` appears in the label when provided.
- [ ] `show_label_in_editor` and `show_label_in_game` work independently.
- [ ] Above/Below/Center/Custom and label offset remain correct after resizing.
- [ ] Changing direct fill color changes the placeholder.
- [ ] Changing texture updates the visual without editing source code.
- [ ] Applying a `.tres` theme changes the visual; changing a shared preset updates all intended instances.
- [ ] Setting `show_placeholder = false` allows custom child visual art without suppressing collision.

### 20.2 Collision and motion checks

- [ ] Static collider size matches the exported visual rectangle.
- [ ] Resizing one platform does **not** resize its siblings.
- [ ] Player stands on static ground and lands on one-way ledges from above.
- [ ] Player passes through one-way ledges from below.
- [ ] Moving platform carries the player at different speeds and in multiple directions.
- [ ] Conveyor direction and contact motion agree.
- [ ] Collapse waits for the warning interval, disables collision, and later restores.
- [ ] Bounce pad applies a predictable upward or directional launch.
- [ ] Hazard damages on entry; timed hazard is non-damaging during idle and warning.
- [ ] Sticky/slippery zones restore normal movement on exit.
- [ ] Switch toggles its intended target; no target path is hardcoded inside the reusable switch.
- [ ] Checkpoint respawns the player outside other collision geometry.
- [ ] Destroyed cover becomes non-solid.
- [ ] Pickups cannot be collected multiple times unintentionally.

### 20.3 Portability checks

- [ ] Copy only `addons/level_elements_kit/` to a brand-new Godot project.
- [ ] Let the editor import classes and resources; restart editor if required.
- [ ] Instantiate a static scene with no missing script/texture references.
- [ ] Confirm no dependency points into `/demo/` or old game-specific folders.
- [ ] Configure the new project's physics layers or remap kit scene masks.
- [ ] Integrate the new project's actor methods/signals without renaming its player class.
- [ ] Confirm that presets, animations, and any external art are contained in the transferred folder or explicitly documented dependencies.

### 20.4 Performance and QA

- [ ] Use the Godot **Debug → Visible Collision Shapes** option while running the game.
- [ ] Profile scenes with hundreds of elements; convert bulk static terrain to tile layers where appropriate.
- [ ] Watch for `@tool` editor errors and orphaned shape-resource references.
- [ ] Avoid one `Timer` per decorative leaf or excessive collision areas for purely cosmetic props.
- [ ] Test player motion at different physics and rendering frame rates.
- [ ] Test save/reload with per-instance Inspector overrides and local-to-scene resources.
- [ ] Test area overlap, disabling while physics is processing, and scene teardown during timed effects.

---

## 21. Make the kit portable between projects

### Step 21.1 — Treat the kit as a product boundary

Your reusable folder should have its own:

```text
addons/level_elements_kit/
  scripts/
  scenes/
  presets/
  art/          # When you add final transferable art
  audio/        # When you add transferable audio
  effects/      # Optional visual FX scenes
  README.md
  LICENSE       # Choose an appropriate license if sharing publicly
```

Do not store the kit's core resources under BP2-specific project folders like `res://levels/grease_canyon/` unless they are **level-specific instances** outside the kit.

### Step 21.2 — Use `class_name` with a namespace-like prefix

Godot 4 GDScript `class_name` registers a global class. Prefer `LE_...` names over common names such as `Platform`, `Switch`, and `DamageZone`; this reduces collisions when multiple games or plugins define similar classes.

### Step 21.3 — Copy and instantiate

1. Close the destination project or commit its current state.
2. Copy `addons/level_elements_kit/` into its `res://addons/` directory.
3. Launch or reload the destination project.
4. Verify that scripts and theme Resource classes load.
5. Instantiate `staticplatform.tscn` into a test scene.
6. Adjust collision layers if the host uses different bit assignments.
7. Add optional actor methods from Section 16 and test interactive elements.
8. Copy only your desired theme `.tres` presets; replace those with a new game's themes if needed.

### Step 21.4 — Version the kit independently

Start with semantic versions, e.g. `0.1.0` for the starter, `0.2.0` when advanced rope/push/crusher mechanics land, and `1.0.0` only when the API is stabilized and tests cover cross-project imports.

For teams using multiple games, promote the folder to a separate Git repository, Git submodule, or asset package. Document changes to signal signatures and exported field names: changing those can break scenes in importing games.

### Step 21.5 — Optional real EditorPlugin

A native **EditorPlugin** is worthwhile only when you need functionality beyond the existing Inspector and FileSystem dock, such as:

- Searchable element palette with category filters.
- Drag-and-drop preset instantiation from a custom dock.
- Level-wide batch toggles for debug labels.
- Validation warnings for duplicate IDs, missing art, unconnected switches, bad collider sizes, or unreachable jump gaps.
- Motion-path and launch-vector gizmos.
- Export documentation or an inventory of used elements.

At that point create `plugin.cfg` and a `@tool extends EditorPlugin` script under the addon directory. Until then, plain reusable PackedScenes are simpler and fully portable.

---

## 22. Production roadmap and acceptance criteria

| Phase | Build                                                                                     | Definition of done                                                                  |
| ----- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| 0     | Shared scene wrapper, editor preview, debug label, collision conventions                  | Designer places and customizes a static platform without code                       |
| 1     | Static, one-way, moving, collapsing, conveyor, bounce                                     | One complete platforming obstacle course using only reusable scenes                 |
| 2     | Damage, timed hazards, status zones, switches, checkpoints, pickups, exits, destructibles | A playable loop with failure, respawn, puzzle and exit                              |
| 3     | BP2-specific ropes, moving hazards, crushers, jets, spawners, clouds, boss props          | Every mechanism in the catalog maps to a reusable class or documented composite     |
| 4     | Theme presets, animations, particle/audio components                                      | Graybox elements reskinned into all eight environments without behavior duplication |
| 5     | Editor tools, tests, and packaging                                                        | Folder imports into a second project with documented layer/interface setup          |

### Recommended first vertical slice

Make a **Grease Canyon graybox** with the following: three static platforms, one one-way ledge, one moving platform, one collapsing platform, one grease damage pool, one bounce pad, one sticky/slippery patch, one switch, one checkpoint, one collectible evidence prop, and an exit. Then apply a different theme preset to every object and verify its behavior remains unchanged. This tests the architecture much more effectively than producing eight sets of static artwork first.

### Minimum success criteria

At the end of Milestone 2, a designer should be able to:

1. Drag an element from the kit into a new scene.
2. Edit **name, ID, size, color, texture/preset, behavior, label visibility, and label position** in the Inspector.
3. Place two instances with independent dimensions and settings.
4. Connect interaction events without modifying the element's source script.
5. Copy the kit to another Godot game and supply only collision-layer configuration plus optional actor integrations.

---

## 23. Common mistakes and remedies

| Symptom                                                           | Likely cause                                                                     | Fix                                                                                                     |
| ----------------------------------------------------------------- | -------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| Export changes do not appear live in editor                       | Script not `@tool`; child label missing; scene needs reload                      | Add `@tool` on active script and subclasses; check `DebugLabel` path; reopen scene                      |
| Changing one platform resizes every platform                      | Shared `RectangleShape2D` resource                                               | Enable `resource_local_to_scene` / make shape unique                                                    |
| Player falls through a platform                                   | Wrong layer/mask or disabled collider                                            | Verify World/Player bits, Body and CollisionShape2D                                                     |
| Area trigger never fires                                          | Trigger mask does not include Player; node is not a physics body                 | Check `Area2D.monitoring`, masks, and actor root type                                                   |
| Label is hidden in the running game                               | `show_label_in_game` defaults to false                                           | Enable the game toggle if you specifically want runtime debug text                                      |
| Label moves strangely                                             | Element size changed, child manually repositioned, scale applied                 | Keep root/shape scale at 1; adjust exported label offset                                                |
| Platform art moves but character doesn't follow                   | Static body used for moving geometry, or custom player ignores platform velocity | Use AnimatableBody2D and review controller's `CharacterBody2D` floor settings                           |
| Conveyor doesn't influence an actor                               | Actor ignores contact/floor velocity                                             | Integrate conveyor motion into custom controller or use physics-compatible body                         |
| Sticky area changes appearance but not speed                      | Player lacks `enter_surface` / `exit_surface` implementations                    | Add actor contract or connect signals to movement manager                                               |
| Switching presets edits all elements                              | `.tres` resources are shared                                                     | Make Unique or create a distinct variant preset                                                         |
| The theme texture appears stretched                               | Starter uses a single stretched rectangle                                        | Use tiled sprite, custom mesh/shader, or richer visual child scene                                      |
| Timed hazard does not hurt actor already inside during activation | Area overlap/monitoring logic requires testing on your engine/controller         | Test activation with stationary overlap; if necessary manually inspect overlapping bodies at activation |
| Import fails in a second game                                     | Hardcoded paths, class conflict or layer mismatch                                | Keep dependencies inside addon, prefix `class_name`, configure host layers                              |
| Switch does nothing                                               | No signal connection or target method                                            | Connect `toggled` in host level and ensure target accepts bool                                          |
| Level designer creates hundreds of identical scene platforms      | Instance approach overused                                                       | Migrate bulk terrain to `TileMapLayer`                                                                  |

---

## 24. Reference documentation

The external technical guidance below informed the Godot-specific recommendations. Consult the exact engine version's docs when a behavior differs from the demonstration.

- [Godot official release archive](https://godotengine.org/download/archive/) — version selection.
- [GDScript exported properties](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_exports.html) — `@export`, groups, enums, resources and setters.
- [Running code in the editor](https://docs.godotengine.org/en/stable/tutorials/plugins/running_code_in_the_editor.html) — `@tool`, editor safeguards.
- [Physics introduction](https://docs.godotengine.org/en/stable/tutorials/physics/physics_introduction.html) — body types, areas, collision layers/masks.
- [StaticBody2D](https://docs.godotengine.org/en/stable/classes/class_staticbody2d.html) — static platforms and contact velocity on conveyors.
- [AnimatableBody2D](https://docs.godotengine.org/en/stable/classes/class_animatablebody2d.html) — velocity-estimated moving platforms.
- [CharacterBody2D](https://docs.godotengine.org/en/stable/classes/class_characterbody2d.html) — `move_and_slide`, floor and platform behavior.
- [Using TileMaps](https://docs.godotengine.org/en/stable/tutorials/2d/using_tilemaps.html) — `TileMapLayer` for bulk terrain.
- [Making editor plugins](https://docs.godotengine.org/en/stable/tutorials/plugins/editor/making_plugins.html) — optional `plugin.cfg`, plugin scripts, docks and editor extensions.

**Source distinction:** The eight worlds and their named environment assets come from your uploaded BP2 catalog. The architecture, proposed class names, extra generic platformer components, implementation steps, and prioritization are engineering recommendations and starter-code designs derived from that catalog and Godot's engine capabilities.

---

### Final recommendation

Build and validate the **generic kit first**. Once you can instantiate, resize, retheme, label, and connect each functional base element from the Inspector, turn the BP2 examples into themed `.tres` presets and a limited number of `PackedScene` variants. This will give you the “place and tweak” authoring experience you want, while preserving a reusable codebase for the next platformer.
