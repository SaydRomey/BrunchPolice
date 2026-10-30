# Hover Documentation — Maintaining the Level Elements Kit

This package uses Godot 4 GDScript documentation comments (`##`). Documentation comments are attached immediately above declarations, including exported Inspector properties and functions.

## What appears where

| Location                       | Expected behavior                                                                                        |
| ------------------------------ | -------------------------------------------------------------------------------------------------------- |
| Class help (F1 / Search Help)  | Documented `class_name` description and public members                                                   |
| Inspector property hover       | Exported variable description when Godot resolves it                                                     |
| Script editor hover/completion | Available documentation depends on the Godot editor version and the referenced symbol                    |
| `_private_method()`            | The inline `##` comment remains in source, but private methods may not be listed in generated class help |
| External Markdown reference    | All functions, signals, properties and state fields, including internal helpers                          |

## A documented method in this version

```gdscript
## Switch control endpoint. [param value] starts or stops belt transport without toggling solidity.
func set_enabled(value: bool) -> void:
    belt_enabled = value
```

The function above is in `scripts/le_conveyor_platform.gd`. Its belt updates `Body.constant_linear_velocity` through the property setter. It does not change `solid`, `one_way`, or collider shape.

## A documented property

```gdscript
## Author-time initial switch state; also drives the ON/OFF editor preview.
@export var starts_on: bool = false:
    set(value):
        starts_on = value
        if Engine.is_editor_hint():
            _refresh()
```

The switch uses this in the 2D editor, then sets runtime `is_on = starts_on` on game start.

## Writing rules

1. Put `##` directly above the function or immediately above any `@export` annotation for properties.
2. Document *actual* behavior: state ownership, side effects, expected actor methods, and signal arguments.
3. For input parameters, use `[param name]`; link existing members using `[member Class.property]` and methods using `[method Class.method]` when supported.
4. Keep internal helper comments even if they do not appear in generated class docs; they help during maintenance.
5. Avoid changing executable statements while editing documentation. Run a before/after code-only comparison.
6. If Godot does not refresh a description, save the script, reopen it, or search for the class through F1 help.

## Key method locations

| Need                                     | Script and method                                           |
| ---------------------------------------- | ----------------------------------------------------------- |
| Debug label text / optional state suffix | `le_element_2d.gd`: `_get_debug_state_text()`, `_refresh()` |
| Switch runtime state                     | `le_switch.gd`: `toggle()`, `_get_debug_state_text()`       |
| Conveyor belt speed and enable           | `le_conveyor_platform.gd`: `_apply_belt()`, `set_enabled()` |
| Platform one-way / solid                 | `le_platform_base.gd`: `_refresh()`                         |
| Moving Body transport                    | `le_moving_platform.gd`: `_physics_process()`               |
| Artwork following Body                   | `le_element_visual.gd`: `_draw()` and scene hierarchy       |
| Timed hazard cycle                       | `le_periodic_hazard.gd`: `_cycle()`                         |
| Damage on Area entry                     | `le_damage_zone.gd`: `_on_enter()`                          |

## Validation

The annotated files have a mechanically identical sequence of non-comment GDScript lines to the uploaded originals. This does not certify Godot parser execution or fix existing scene data.

For canonical documentation syntax, see [Godot GDScript documentation comments](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_documentation_comments.html).
