# Level Elements Kit — API Reference

**Matches the `gd-2d-lib` addon in this package.** Every class, exported property, active method, and signal below is taken from its current GDScript. This is a source-level reference, not a claim that each scene has passed runtime validation.

## Shared assumptions

- Element roots generally inherit `LE_Element2D` and may contain `Body`, `Area`, `Trigger`, or `DebugLabel` children as described per script.
- Exported properties are editable in the Inspector; `@tool` refreshes selected visual/collision properties in the editor.
- A function beginning with `_` is an internal hook or helper. Documentation comments remain useful in source, but Godot may omit private methods from generated class help.
- The host game provides optional actor methods; the addon uses `has_method` where specified.

## LE_BouncePad

**File:** `scripts/le_bounce_pad.gd`

Platform launcher that gives landing characters a bounce velocity and optional timed jump boost. The optional boost requires the actor to implement get_base_jump_impulse() and start_bounce_boost_window(seconds, extra_impulse).

### Inspector properties

| Property                | Meaning                                                                       |
| ----------------------- | ----------------------------------------------------------------------------- |
| `launch_velocity`       | Immediate velocity given to a descending CharacterBody2D contacting the pad.  |
| `jump_boost_multiplier` | Maximum multiplier used to compute optional player-controlled bounce boost.   |
| `boost_window_seconds`  | Time window during which compatible players may trigger extra bounce impulse. |

### Signals

| Signal                                                           | Meaning                                                                                              |
| ---------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| `signal actor_launched(actor: Node2D, launch_velocity: Vector2)` | Emitted after the entering actor receives launch_velocity; parameters are actor and launch_velocity. |

### Methods

| Method signature                        | Description                                                                                                                                                                            |
| --------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `func _ready() -> void:`                | Configures the top Trigger and connects its body_entered callback during gameplay.                                                                                                     |
| `func _refresh() -> void:`              | Refreshes presentation/collision and synchronizes the top Trigger dimensions.                                                                                                          |
| `func _sync_trigger() -> void:`         | Sizes Trigger/CollisionShape2D to an 8px-high strip along the pad's upper surface.                                                                                                     |
| `func _on_enter(body: Node2D) -> void:` | Launches a descending CharacterBody2D. Uses optional apply_launch; otherwise sets velocity directly. Optionally requests a timed jump boost from the actor, then emits actor_launched. |

## LE_Checkpoint

**File:** `scripts/le_checkpoint.gd`

Trigger that publishes a respawn position on first or repeat player contact. Emits reached and optionally invokes actor.set_checkpoint(position); one_shot prevents repeated activations.

### Inspector properties

| Property         | Meaning                                                                  |
| ---------------- | ------------------------------------------------------------------------ |
| `respawn_offset` | Local offset from this node's global position used as the respawn point. |
| `one_shot`       | If true, only the first eligible overlap emits reached.                  |

### Signals

| Signal                                                     | Meaning                                                                     |
| ---------------------------------------------------------- | --------------------------------------------------------------------------- |
| `signal reached(actor: Node2D, respawn_position: Vector2)` | Emitted with actor and computed world-space respawn_position on activation. |

### Methods

| Method signature                         | Description                                                                                                                                  |
| ---------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| `func _ready() -> void:`                 | Synchronizes the Area shape and connects its player entry callback at runtime.                                                               |
| `func _refresh() -> void:`               | Updates base appearance and synchronizes checkpoint Area size.                                                                               |
| `func _sync_shape() -> void:`            | Matches the Area rectangle to [member element_size].                                                                                         |
| `func _on_enter(actor: Node2D) -> void:` | On an eligible CharacterBody2D, emits reached(actor, global_position + respawn_offset), and optionally calls actor.set_checkpoint(position). |

### State fields

| Field        | Purpose                                                                         |
| ------------ | ------------------------------------------------------------------------------- |
| `_activated` | Tracks whether the checkpoint has already fired, used when one_shot is enabled. |

## LE_CollapsingPlatform

**File:** `scripts/le_collapsing_platform.gd`

Platform that emits a warning, temporarily disables its collider and later restores itself. A Trigger area detects CharacterBody2D actors. Warning and respawn durations are configured in the Inspector.

### Inspector properties

| Property          | Meaning                                                               |
| ----------------- | --------------------------------------------------------------------- |
| `warning_seconds` | Time between player trigger and collider disappearing.                |
| `respawn_seconds` | Time the platform stays invisible and non-colliding before returning. |

### Signals

| Signal                   | Meaning                                                                |
| ------------------------ | ---------------------------------------------------------------------- |
| `signal warning_started` | Emitted before the warning wait begins.                                |
| `signal collapsed`       | Emitted when collision is disabled and the platform becomes invisible. |
| `signal restored`        | Emitted after the platform becomes visible and collision is restored.  |

### Methods

| Method signature                               | Description                                                                                                                                                                |
| ---------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `func _ready() -> void:`                       | Synchronizes Trigger size and connects body_entered outside the editor.                                                                                                    |
| `func _refresh() -> void:`                     | Refreshes shared presentation/collider settings and repositions the top-contact Trigger.                                                                                   |
| `func _sync_trigger() -> void:`                | Keeps the thin Trigger collision shape aligned with the top of the element's current width and height.                                                                     |
| `func _on_body_entered(body: Node2D) -> void:` | Starts a collapse when a CharacterBody2D enters and this platform is not already collapsing.                                                                               |
| `func _begin_collapse() -> void:`              | Emits warning_started, waits warning_seconds, disables collision and hides, waits respawn_seconds, then restores collision and visibility. Stops if removed from the tree. |

### State fields

| Field   | Purpose                                                    |
| ------- | ---------------------------------------------------------- |
| `_busy` | True while a collapse-and-respawn sequence is in progress. |

## LE_Collectible

**File:** `scripts/le_collectible.gd`

Pickup that emits an item identifier and score value, then removes itself. Collects when a CharacterBody2D enters its Area; the receiving game owns inventory and reward effects.

### Inspector properties

| Property      | Meaning                                                                            |
| ------------- | ---------------------------------------------------------------------------------- |
| `item_id`     | Logical identifier reported to a host inventory or evidence system when collected. |
| `score_value` | Optional score amount supplied with collected; scoring is handled by the host.     |

### Signals

| Signal                                                               | Meaning                                                                 |
| -------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| `signal collected(actor: Node2D, item_id: String, score_value: int)` | Emitted with actor, item_id, score_value immediately before queue_free. |

### Methods

| Method signature                         | Description                                                                                               |
| ---------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| `func _ready() -> void:`                 | Synchronizes its Area and connects entry detection at runtime.                                            |
| `func _refresh() -> void:`               | Refreshes base appearance and synchronizes pickup size.                                                   |
| `func _sync_shape() -> void:`            | Sets the pickup Area rectangle to the exported element dimensions.                                        |
| `func _on_enter(actor: Node2D) -> void:` | Emits collected(actor, item_id, score_value) for a CharacterBody2D, then queues this pickup for deletion. |

## LE_ConveyorPlatform

**File:** `scripts/le_conveyor_platform.gd`

Solid platform whose StaticBody2D contributes a surface velocity to contacting bodies. Disabling its belt sets surface velocity to zero; it does not disable collision. One-way collision is controlled separately by [member LE_PlatformBase.one_way].

### Inspector properties

| Property        | Meaning                                                                         |
| --------------- | ------------------------------------------------------------------------------- |
| `belt_velocity` | Contact movement vector supplied by Body.constant_linear_velocity when enabled. |
| `belt_enabled`  | Turn surface movement on or off without modifying collider solidity.            |

### Methods

| Method signature                         | Description                                                                                                                               |
| ---------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| `func _ready() -> void:`                 | Initializes the StaticBody2D belt surface velocity after normal platform setup.                                                           |
| `func _apply_belt() -> void:`            | Sets Body.constant_linear_velocity to the configured vector when enabled, otherwise Vector2.ZERO. It does not change the collision shape. |
| `func set_enabled(value: bool) -> void:` | Switch control endpoint. [param value] starts or stops belt transport without toggling solidity.                                          |
| `func reverse() -> void:`                | Negates belt_velocity, reversing the transport direction.                                                                                 |

## LE_DamageZone

**File:** `scripts/le_damage_zone.gd`

Area2D trigger that applies a configured hit when a body enters while active. Emits actor_hit, and optionally calls receive_damage(damage, source_position) on the actor. Does not tick damage continuously.

### Inspector properties

| Property | Meaning                                                                    |
| -------- | -------------------------------------------------------------------------- |
| `damage` | Integer damage value emitted or sent when a body enters the active Area.   |
| `active` | Whether the Area monitors new entries and applies entry damage at runtime. |

### Signals

| Signal                                         | Meaning                                                           |
| ---------------------------------------------- | ----------------------------------------------------------------- |
| `signal actor_hit(actor: Node2D, damage: int)` | Emitted with actor and configured damage on an active Area entry. |

### Methods

| Method signature                         | Description                                                                                                                    |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| `func _ready() -> void:`                 | Connects entry detection during gameplay, syncs Area geometry and applies active monitoring state.                             |
| `func _refresh() -> void:`               | Updates debug/appearance settings and synchronizes Area/CollisionShape2D size.                                                 |
| `func _sync_shape() -> void:`            | Resizes the Area rectangle to [member element_size] when its shape supports rectangles.                                        |
| `func _apply_active() -> void:`          | Schedules Area.monitoring to follow [member active] at runtime. Does not change monitoring in the editor.                      |
| `func _on_enter(body: Node2D) -> void:`  | If active, emits actor_hit and calls body.receive_damage(damage, global_position) when that method exists. Runs only on entry. |
| `func set_enabled(value: bool) -> void:` | Controls the active state of the damage zone through [member active]. [param value] is the desired state.                      |

## LE_DestructiblePlatform

**File:** `scripts/le_destructible_platform.gd`

Solid platform that tracks health and loses its collider when destroyed. It receives damage via receive_damage(amount, source), emits health_changed and destroyed, and becomes invisible at zero HP.

### Inspector properties

| Property     | Meaning                                                              |
| ------------ | -------------------------------------------------------------------- |
| `max_health` | Number of damage points required to destroy the platform at runtime. |

### Signals

| Signal                                         | Meaning                                                  |
| ---------------------------------------------- | -------------------------------------------------------- |
| `signal destroyed`                             | Emitted once when health reaches zero.                   |
| `signal health_changed(remaining_health: int)` | Emitted with remaining_health after damage is processed. |

### Methods

| Method signature                                                             | Description                                                                                                                                                                   |
| ---------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `func _ready() -> void:`                                                     | Initializes runtime health to max_health after normal platform setup.                                                                                                         |
| `func receive_damage(amount: int, _source: Vector2 = Vector2.ZERO) -> void:` | Subtracts nonnegative [param amount] from health. Emits health_changed, and at zero emits destroyed, disables the collider and hides the platform. [param _source] is unused. |

### State fields

| Field    | Purpose                                              |
| -------- | ---------------------------------------------------- |
| `health` | Current runtime health, initialized from max_health. |

## LE_Element2D

**File:** `scripts/le_element_2d.gd`

Common Node2D root for reusable level elements: Inspector identity, placeholder art, visual presets and debug labels. The label can show a state suffix supplied by [_get_debug_state_text]. An optional [LE_ElementVisual] draws art in a moving physics child.

### Inspector properties

| Property               | Meaning                                                                                        |
| ---------------------- | ---------------------------------------------------------------------------------------------- |
| `element_id`           | Optional stable identifier for this placed element; included in the debug label when nonempty. |
| `display_name`         | Human-readable label for this element in the editor/game debug display.                        |
| `category`             | Designer-facing category tag. This metadata does not determine collision or behavior.          |
| `visual_preset`        | Optional shared [LE_VisualPreset] with placeholder fill, texture and tint.                     |
| `element_size`         | Size in local pixels; concrete elements also use this value for rectangle colliders.           |
| `show_placeholder`     | Draw the root placeholder rectangle/texture when true.                                         |
| `fill_color`           | Fallback placeholder fill used without a preset; can be overridden by the preset.              |
| `art_texture`          | Optional texture drawn in place of the plain placeholder; overrides a preset texture.          |
| `texture_tint`         | Tint applied to art_texture or used when the element has no preset.                            |
| `show_label_in_editor` | Display the DebugLabel in the 2D editor.                                                       |
| `show_label_in_game`   | Display the DebugLabel when running the level.                                                 |
| `label_position_mode`  | Choose Above, Below, Center, or Custom for debug label placement.                              |
| `label_offset`         | Additional local pixel offset applied after the chosen label position.                         |
| `label_color`          | Text color for the DebugLabel.                                                                 |
| `label_font_size`      | Font size in pixels for the DebugLabel.                                                        |

### Methods

| Method signature                          | Description                                                                                                                                                                           |
| ----------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `func _ready() -> void:`                  | Connects to the selected visual preset and applies the initial placeholder, label and editor appearance.                                                                              |
| `func _connect_preset() -> void:`         | Subscribes [_refresh] to changes on the active [LE_VisualPreset], avoiding duplicate connections.                                                                                     |
| `func _get_debug_state_text() -> String:` | Override in stateful elements to return a short suffix such as ON or OFF. Returns an empty string for elements without a state.                                                       |
| `func _refresh() -> void:`                | Updates the placeholder and optional DebugLabel when Inspector or runtime settings change. Looks for DebugLabel or Body/DebugLabel and appends [_get_debug_state_text] when nonempty. |
| `func _draw() -> void:`                   | Draws a centered placeholder rectangle or texture, shifted by [_visual_offset]. Uses [member visual_preset] colors and texture unless overridden.                                     |

### State fields

| Field            | Purpose                                                                         |
| ---------------- | ------------------------------------------------------------------------------- |
| `_visual_offset` | Current offset applied to the root-drawn placeholder, used by moving platforms. |

## LE_ElementVisual

**File:** `scripts/le_element_visual.gd`

Optional child visual that draws the owner element's placeholder in its own local coordinate system. Attach beneath a moving Body or another transformed child so art follows that child. The ancestor [LE_Element2D] supplies its appearance settings.

### Methods

| Method signature                        | Description                                                                                                                                                                |
| --------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `func _draw() -> void:`                 | Finds the nearest [LE_Element2D] ancestor and draws that element's placeholder in this node's local space. Does nothing when no owner is found or placeholders are hidden. |
| `func _find_element() -> LE_Element2D:` | Walks up parent nodes and returns the closest [LE_Element2D], or null when no matching ancestor exists.                                                                    |

## LE_ExitPortal

**File:** `scripts/le_exit_portal.gd`

Area that requests a level transition through a logical destination key. It emits exit_requested(actor, target_level_key) when a CharacterBody2D enters. The host game performs scene loading.

### Inspector properties

| Property           | Meaning                                                                         |
| ------------------ | ------------------------------------------------------------------------------- |
| `target_level_key` | Logical destination key emitted when an actor enters; this is not a scene path. |

### Signals

| Signal                                                           | Meaning                                                                              |
| ---------------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| `signal exit_requested(actor: Node2D, target_level_key: String)` | Emitted with actor and logical target_level_key; host scene manager handles loading. |

### Methods

| Method signature                         | Description                                                                                        |
| ---------------------------------------- | -------------------------------------------------------------------------------------------------- |
| `func _ready() -> void:`                 | Synchronizes Area dimensions and connects body_entered during gameplay.                            |
| `func _refresh() -> void:`               | Refreshes shared appearance and updates the exit trigger bounds.                                   |
| `func _sync_shape() -> void:`            | Resizes the Area rectangle to the exported element size.                                           |
| `func _on_enter(actor: Node2D) -> void:` | Emits exit_requested(actor, target_level_key) for a CharacterBody2D; does not load a scene itself. |

## LE_MovingPlatform

**File:** `scripts/le_moving_platform.gd`

Moves an AnimatableBody2D back and forth along a configurable travel vector. The placed root stays fixed. Its Body and root-drawn placeholder move during physics ticks; custom artwork should follow Body.

### Inspector properties

| Property              | Meaning                                                                                   |
| --------------------- | ----------------------------------------------------------------------------------------- |
| `travel`              | Body displacement in local pixels from the initial placed position to the other endpoint. |
| `speed_px_per_second` | Travel speed in pixels per second.                                                        |
| `motion_enabled`      | Whether the platform Body progresses along its route at runtime.                          |

### Methods

| Method signature                               | Description                                                                                                                                              |
| ---------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `func _ready() -> void:`                       | Caches the child Body initial local position, sets the placeholder offset, and enables physics processing only during gameplay.                          |
| `func _physics_process(delta: float) -> void:` | Updates the AnimatableBody2D local position between its origin and travel end and redraws the placeholder. Pauses movement when motion_enabled is false. |
| `func set_enabled(value: bool) -> void:`       | Enables or pauses movement without removing collision or resetting the current travel position. [param value] is the desired enabled state.              |

### State fields

| Field          | Purpose                                                          |
| -------------- | ---------------------------------------------------------------- |
| `_body`        | Moving AnimatableBody2D child controlled by the platform.        |
| `_body_origin` | Starting local Body position.                                    |
| `_distance`    | Accumulated progress along the travel segment in pixels.         |
| `_direction`   | Current travel direction: 1 toward the end, -1 toward the start. |

## LE_PeriodicHazard

**File:** `scripts/le_periodic_hazard.gd`

Damage zone that cycles through idle, warning and attacking periods. It changes fill color and active monitoring and emits phase signals. Damage still follows the inherited entry-trigger contract.

### Inspector properties

| Property          | Meaning                                                           |
| ----------------- | ----------------------------------------------------------------- |
| `idle_seconds`    | Duration of harmless idle state before telegraph.                 |
| `warning_seconds` | Duration of visible warning before attack begins.                 |
| `attack_seconds`  | Duration of active damage monitoring before the next idle period. |
| `warning_color`   | Temporary placeholder fill used during the telegraph.             |
| `attack_color`    | Temporary placeholder fill used during the attack state.          |

### Signals

| Signal                     | Meaning                                         |
| -------------------------- | ----------------------------------------------- |
| `signal telegraph_started` | Emitted at the start of the warning phase.      |
| `signal attack_started`    | Emitted when the damaging phase becomes active. |
| `signal attack_finished`   | Emitted when the damaging phase ends.           |

### Methods

| Method signature         | Description                                                                                                                               |
| ------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------- |
| `func _ready() -> void:` | Starts with damage disabled, caches the normal fill color and launches the cycle outside the editor.                                      |
| `func _cycle() -> void:` | Repeats idle, warning and attack using timers, fill-color changes and phase signals. It enables Area monitoring during the attack period. |

### State fields

| Field            | Purpose                                                   |
| ---------------- | --------------------------------------------------------- |
| `_default_color` | Original placeholder fill restored during the idle phase. |

## LE_PlatformBase

**File:** `scripts/le_platform_base.gd`

Reusable platform with configurable rectangular collision and one-way behavior. The scene must contain Body/CollisionShape2D with a RectangleShape2D. Concrete subclasses add movement, triggers or durability.

### Inspector properties

| Property  | Meaning                                                                                           |
| --------- | ------------------------------------------------------------------------------------------------- |
| `solid`   | Enable the platform collision at runtime; independent of belt transport or art visibility.        |
| `one_way` | Allow bodies to pass upward through the platform collider; enabled in the one-way scene template. |

### Methods

| Method signature           | Description                                                                                                                                             |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `func _refresh() -> void:` | Refreshes shared art/label and synchronizes Body/CollisionShape2D size and one-way collision. Runtime also applies [member solid] to collider.disabled. |

## LE_SurfaceZone

**File:** `scripts/le_surface_zone.gd`

Trigger zone for movement modifiers such as sticky or slippery surfaces. It reports entry/exit through signals and optional actor methods; it does not modify movement on its own.

### Inspector properties

| Property              | Meaning                                                                         |
| --------------------- | ------------------------------------------------------------------------------- |
| `speed_multiplier`    | Suggested horizontal movement multiplier for actors implementing enter_surface. |
| `traction_multiplier` | Suggested traction multiplier for actors implementing enter_surface.            |
| `jump_multiplier`     | Suggested jump multiplier for actors implementing enter_surface.                |

### Signals

| Signal                                        | Meaning                                        |
| --------------------------------------------- | ---------------------------------------------- |
| `signal actor_entered_surface(actor: Node2D)` | Emitted when an actor enters the surface Area. |
| `signal actor_exited_surface(actor: Node2D)`  | Emitted when an actor leaves the surface Area. |

### Methods

| Method signature                         | Description                                                                                                        |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| `func _ready() -> void:`                 | Synchronizes the Area shape and connects entry/exit signals during gameplay.                                       |
| `func _refresh() -> void:`               | Refreshes shared presentation and updates the rectangle collision size.                                            |
| `func _sync_shape() -> void:`            | Keeps Area/CollisionShape2D rectangle dimensions matched to [member element_size].                                 |
| `func _on_enter(actor: Node2D) -> void:` | Emits actor_entered_surface, then optionally calls enter_surface(instance_id, speed, traction, jump) on the actor. |
| `func _on_exit(actor: Node2D) -> void:`  | Emits actor_exited_surface and optionally calls exit_surface(instance_id) on the actor.                            |

## LE_Switch

**File:** `scripts/le_switch.gd`

Interactive toggle with touch activation or an interact action, a toggled signal and a live debug state label. The Inspector starts_on flag previews ON/OFF in the editor; runtime is_on is initialized from that flag.

### Inspector properties

| Property                 | Meaning                                                                                           |
| ------------------------ | ------------------------------------------------------------------------------------------------- |
| `auto_activate_on_touch` | If true, entering the Area toggles immediately; otherwise press the interact action while inside. |
| `starts_on`              | Author-time initial switch state; also drives the ON/OFF editor preview.                          |

### Signals

| Signal                        | Meaning                                                                                      |
| ----------------------------- | -------------------------------------------------------------------------------------------- |
| `signal toggled(is_on: bool)` | Emitted after is_on changes; provides new boolean state for signals and control connections. |

### Methods

| Method signature                                    | Description                                                                                                                            |
| --------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| `func _ready() -> void:`                            | Synchronizes its Area, initializes runtime [member is_on] from [member starts_on], refreshes the state label and connects body events. |
| `func _get_debug_state_text() -> String:`           | Returns ON/OFF for the DebugLabel. Uses starts_on in the editor and runtime is_on while playing.                                       |
| `func _refresh() -> void:`                          | Updates the shared debug text and placeholder, then synchronizes Area dimensions.                                                      |
| `func _sync_shape() -> void:`                       | Resizes the switch interaction rectangle to [member element_size].                                                                     |
| `func _on_enter(body: Node2D) -> void:`             | Records a CharacterBody2D in range; toggles immediately when auto_activate_on_touch is enabled.                                        |
| `func _on_exit(body: Node2D) -> void:`              | Clears the inside flag when a CharacterBody2D exits the interaction area.                                                              |
| `func _unhandled_input(event: InputEvent) -> void:` | When an actor is inside and touch activation is disabled, consumes the interact action to toggle the switch.                           |
| `func toggle() -> void:`                            | Flips runtime is_on, refreshes the DebugLabel and emits toggled(is_on) to connected elements.                                          |

### State fields

| Field           | Purpose                                                               |
| --------------- | --------------------------------------------------------------------- |
| `is_on`         | Runtime toggle state; initialized from starts_on when the scene runs. |
| `_actor_inside` | Whether a CharacterBody2D is currently within the switch Area.        |

## LE_VisualPreset

**File:** `scripts/le_visual_preset.gd`

Reusable resource containing a theme name, a placeholder fill color and optional texture/tint. Appearance setters call [method Resource.emit_changed] so sharing elements can refresh their visuals.

### Inspector properties

| Property       | Meaning                                                                  |
| -------------- | ------------------------------------------------------------------------ |
| `theme_name`   | Friendly name for this reusable appearance resource.                     |
| `fill_color`   | Theme placeholder fill color; changing it emits Resource.changed.        |
| `texture`      | Optional theme texture used when an element has no art_texture override. |
| `texture_tint` | Color modulation for a texture coming from this preset.                  |

## Scene templates

| Scene                              | Main script                   |
| ---------------------------------- | ----------------------------- |
| `scenes/backgroundprop.tscn`       | `le_element_2d.gd`            |
| `scenes/bouncepad.tscn`            | `le_bounce_pad.gd`            |
| `scenes/checkpoint.tscn`           | `le_checkpoint.gd`            |
| `scenes/collapsingplatform.tscn`   | `le_collapsing_platform.gd`   |
| `scenes/collectible.tscn`          | `le_collectible.gd`           |
| `scenes/conveyorplatform.tscn`     | `le_conveyor_platform.gd`     |
| `scenes/damagezone.tscn`           | `le_damage_zone.gd`           |
| `scenes/destructibleplatform.tscn` | `le_destructible_platform.gd` |
| `scenes/exitportal.tscn`           | `le_exit_portal.gd`           |
| `scenes/movingplatform.tscn`       | `le_moving_platform.gd`       |
| `scenes/onewayplatform.tscn`       | `le_platform_base.gd`         |
| `scenes/periodichazard.tscn`       | `le_periodic_hazard.gd`       |
| `scenes/staticplatform.tscn`       | `le_platform_base.gd`         |
| `scenes/surfacezone.tscn`          | `le_surface_zone.gd`          |
| `scenes/switch.tscn`               | `le_switch.gd`                |

## Notes on inherited methods

The `LE_PlatformBase` family inherits size/label/placeholder fields from `LE_Element2D`, and inherits `solid` and `one_way` from `LE_PlatformBase`. The `LE_PeriodicHazard` class inherits hit/activation behavior from `LE_DamageZone`. A `set_enabled()` function is not universal: check whether it controls movement (`LE_MovingPlatform`, `LE_ConveyorPlatform`) or active damage (`LE_DamageZone`).

## Integration caveats

- `LE_DamageZone` damages on entry rather than on a fixed tick. `LE_PeriodicHazard` only changes monitoring with its phase; it does not add a repeating hit timer for an actor already inside.
- `LE_ElementVisual` is available as an optional child drawing node. The existing `_refresh()` method refreshes the root placeholder and `DebugLabel`, but does not explicitly call `queue_redraw()` on all `LE_ElementVisual` descendants.
- `LE_Switch` previews `starts_on` in the editor and uses `is_on` while playing. Signals fire on `toggle()`, not automatically from initial `starts_on`.
- `LE_ConveyorPlatform` transport is separate from `solid`/`one_way` collision properties. Disabling its belt does not make it one-way.
