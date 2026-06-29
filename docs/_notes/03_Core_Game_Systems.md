# Core Game Systems

## Purpose

This note consolidates the reusable game systems that support Brunch Police: events, event queues, timers, resources, inventory, save/load, score tracking, and power-ups.

## Source files covered

- `event-system.txt`
- `event-queue-system.txt`
- `timer-manager.txt`
- `resource-management-assets.txt`
- `ressource-management-in-game.txt`
- `save-load-system.txt`
- `imventory-system.txt`
- `score-manager.txt`
- `power-up-manager.txt`

## System map

| System | Main role |
|---|---|
| Event System | Publisher/subscriber-style callbacks for game events. |
| Event Queue | Ordered event playback for cutscenes and scripted moments. |
| Timer Manager | Delayed actions and cooldowns. |
| Asset Resource Manager | Loads and caches Godot resources. |
| In-Game Resource Manager | Tracks coins, keys, stamina, magic, and other game resources. |
| Inventory | Stores, removes, equips, and uses items. |
| Save/Load | Persists game progress, resources, unlocked levels, and equipment. |
| Score Manager | Tracks and reports score. |
| Power-Up Manager | Applies effects and tracks duration of active power-ups. |

## Event System

Use the Event System for decoupled event handling.

Examples:

- Player collects an item.
- Boss is defeated.
- Level trap is triggered.
- Dialogue event starts a quest.
- Objective is completed.

The source design uses a `std::map<String, Callable>`:

```cpp
std::map<String, Callable> events;
```

Main operations:

- `register_event(name, callback)`
- `trigger_event(name)`

## Event Queue

Use the Event Queue when order matters.

Examples:

- Cutscenes.
- Scripted platform sequences.
- Tutorial steps.
- Multi-stage boss introductions.

The design uses:

```cpp
std::queue<Callable> events;
```

Main operations:

- `add_event(event)`
- `execute_next_event()`

## Timer Manager

Use Timer Manager for delayed and repeated callbacks.

Examples:

- Explosions after a delay.
- Ability cooldowns.
- Repeating enemy spawns.
- Power-up expiration.
- Temporary status effect expiration.

The source design stores:

```cpp
struct TimedEvent {
    Callable callback;
    float remaining_time;
    bool repeat;
};
```

Important cleanup note: the source Timer Manager resets repeating timers with:

```cpp
event.remaining_time += event.remaining_time;
```

That does not restore the original duration. The final implementation should store both `duration` and `remaining_time`.

## Asset Resource Manager

The asset Resource Manager handles Godot resources such as textures, sounds, tilemaps, and common level resources.

Main operations:

- `load_resource(path)`
- `unload_resource(path)`
- `is_resource_loaded(path)`
- `clear_cache()`

Recommended future extensions:

- Reference counting.
- Startup preloading.
- Level-specific resource loading.
- Memory-budget reporting.

## In-Game Resource Manager

The in-game resource manager tracks gameplay values such as coins, keys, magic, stamina, shields, and collectible counts.

Main operations:

- `set_resource_limit(name, limit)`
- `add_resource(name, amount)`
- `subtract_resource(name, amount)`
- `get_resource(name)`
- `get_resource_limit(name)`
- `is_resource_full(name)`
- `is_resource_empty(name)`

## Stamina and regenerating resources

The stamina component demonstrates limited resources that regenerate over time.

Important properties:

- `stamina`
- `max_stamina`
- `regen_rate`

Use this pattern for stamina, shield energy, magic, or cooldown-style resources.

## Inventory

The inventory supports adding items, removing items, checking quantities, equipping items, using consumables, and listing current inventory.

Inventory item structure:

```cpp
struct Item {
    String name;
    String type;
    int quantity;
};
```

Equipment slots:

- `equipped_main_hand`
- `equipped_off_hand`
- `equipped_two_hand`

Important rule: a two-hand item replaces both main-hand and off-hand slots.

## Save/Load System

The save system preserves:

- Global resources such as coins and keys.
- Unlocked levels.
- Equipped main-hand item.
- Equipped off-hand item.
- Equipped two-hand item.

The source design separates `SaveData` and `SaveManager`.

Save path format:

```text
user://<slot_name>.save
```

Recommended final additions:

- Version field.
- Save-file validation.
- Optional JSON format.
- Player position or checkpoint state.
- Boss/quest/objective state.
- Per-level collectible state.
- Settings such as audio and difficulty.

## Score Manager

The Score Manager stores score, adds points, returns current score, and prints score after updates.

Use it as a singleton or attach it to a global game state node.

## Power-Up Manager

The Power-Up Manager tracks active power-ups in a map.

Each power-up has:

- `name`
- `effect`
- `duration`

Use it for speed boosts, Extra Bacon, attack-speed changes, invincibility, and temporary shields.

## Recommended integration order

1. Resource Manager.
2. Event System.
3. Timer Manager.
4. Inventory.
5. In-Game Resource Manager.
6. Save/Load.
7. Power-Up Manager.
8. Score Manager.
