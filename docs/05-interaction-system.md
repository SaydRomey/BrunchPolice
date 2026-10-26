# Interaction System

## Contract

Every interactable advertises an action label, required context and enabled state. A centralized `InteractionController` selects the best candidate within detection range and emits an interaction request. Individual scenes own the actual effects.

| Property | Meaning |
|---|---|
| `interaction_id` | Stable ID scoped to scene or game |
| `verb_key` | Localized verb: Talk, Inspect, Open, Use, Activate, Collect |
| `priority` | Tie-breaker when multiple items overlap |
| `activation_range` | Reach distance or interaction area |
| `requires_flags` | Quest/case predicates |
| `interact()` | Invokes behavior, returns accepted/rejected result |

## Standard interactables

NPC conversations, plate inspection, readable case board, evidence, switch/valve, door/exit, checkpoint, weapon pickup, and boss trigger. Interactive level machinery may have `enable()`, `disable()` and `activate()` endpoints if exposed through adapters.

## Input and feedback

Show a bottom-corner prompt with resolved binding (e.g. `E — Inspect plate`). Hidden/disabled objects do not steal focus; inaccessible interactions explain missing requirements. Trigger once per input press; long-press interactions display progress with a cancel option. Prompt disappears during blocking dialogue, inspection or cutscene.

## Engineering rules

- Interaction zones may be `Area2D`; selecting an eligible target is deterministic.
- Use signals or command dispatch rather than child nodes directly referencing global UI paths.
- Routing to other scenes goes through `SceneRouter`; actors never `change_scene_to_file()` arbitrarily.
- Every interaction is idempotent or guarded against duplicate activation, particularly evidence and rewards.
