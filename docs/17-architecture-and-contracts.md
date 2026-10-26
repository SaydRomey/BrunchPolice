# Godot Architecture and Portable Component Contracts

## Runtime structure

```text
res://
├── addons/
│   ├── level_elements_kit/    # Platform, surface, hazard and machine scenes
│   ├── weapon_item_kit/       # Weapons, combat, status, enemy/boss scaffolds
│   └── bp2_ui_kit/           # Menus, HUD, save/dialogue/quest UI
├── game/
│   ├── core/                 # GameSession, SceneRouter, EventBus
│   ├── cases/                # Case definitions and state adapters
│   ├── worlds/               # Eight world scenes and boss compositions
│   ├── hub/                  # Buffet, NPCs, inspections, accusation
│   └── player/               # Mode-specific actor controllers
├── assets/                   # Sprites, audio, fonts, reusable materials
├── tests/                    # Contract and scene smoke tests
└── project.godot
```

This is the required **target layout**. Existing starter addons provide reusable prototyping scenes and scripts; the application-level cases, routing and some specialized mechanics require additional production integration and acceptance.

## Design rules

1. Use `PackedScene` for repeatable actors, hazards and UI screens; use `.tres` `Resource` definitions for authored variants.
2. Export editable appearance, timing and label controls; debug labels never own gameplay logic.
3. Keep combat and case data at stable interface boundaries. Never reference a particular enemy node path from a weapon.
4. Favor composition: `Health`, `HitReceiver`, `StatusController`, `Feedback`, `Interactable`, `ActorAdapter`.
5. Signals notify observers; scene transitions, save state mutation and reward grants run through one owner service.
6. Avoid class-name collisions among addons; use namespaced class prefixes or folder-qualified scripts.

## Required contracts

| Contract | Request or signal | Guarantees |
|---|---|---|
| `IInteractable` | `interact(actor)` | Returns accepted/error, emits activation once |
| `ICombatReceiver` | `receive_hit(hit_payload)` | Authoritative resolved hit result and feedback event |
| `IStatusTarget` | `apply_effect(effect_def, origin)` | Applies stacking/immunity rules; emits update |
| `IInventoryAdapter` | add/remove/equip/use by item ID | Consistent quantity and capacity constraints |
| `IActorUIBridge` | health, equipment, statuses, prompt updates | UI doesn't depend on scene node names |
| `IQuestEventSink` | semantic event ID + payload | Idempotent progress, explicit missing-ID logging |
| `ICaseService` | evidence/accusation/close | Case lifecycle gates and rewards |
| `ISaveParticipant` | capture/restore serializable state | Versioned primitive data only |
| `IWorldMachine` | activate/disable/set phase | State and telegraph signals |

Godot GDScript contracts may be expressed as duck-typed methods with defensive `has_method()` checks and CI-level contract test scenes; no fictional engine interface keyword is required.

## Development and validation

Static path checks are necessary but insufficient. Every addon must pass Godot import, parser, headless scene load, smoke tests, gameplay interaction and controller input tests. Prototype component behavior is not production-complete until the [acceptance matrix](reference/acceptance-matrix.md) passes.
