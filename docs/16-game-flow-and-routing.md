# Scene Flow, Routing and Transitions

## Architecture

`SceneRouter` owns scene changes and loading screens. It maps stable IDs to approved scene paths and spawn anchors; all world transitions, boss completions and Continue/Load actions use it. `GameSession` stores runtime campaign state, while save adapters serialize it. `EventBus` broadcasts high-level gameplay events without requiring level objects to address specific UI nodes.

## Routes

| From | Event | To | Must preserve |
|---|---|---|---|
| Main menu | New Game | Buffet hub | Defaults/new slot |
| Main menu | Continue / Load | Trusted saved scene | Validated saved state |
| Buffet hub | Correct accusation | Chase intro/entry | Active case, evidence, equipment |
| Chase | Checkpoint | Same level anchor | Inventory and confirmed evidence |
| Chase | Boss entered | Boss arena | Level goals and HUD continuity |
| Boss | Defeat committed | Case resolution → hub | Rewards, solved case, unlocks |
| Chase | Player defeated | Checkpoint respawn | Permanent campaign flags |
| Any safe scene | Save requested | Same scene | Current validated state |

## Transition protocol

1. Validate route and any progression predicate.
2. Raise `transition_started`; disable gameplay input and pause unsafe writes.
3. Fade/show scene loading UI.
4. Spawn destination at approved anchor; bind actor adapters and HUD.
5. Apply persistent case/inventory/quest state and world-specific state.
6. Release input, clear transition lock and emit `transition_completed`.

Scene changes should be asynchronous where necessary and guard against duplicate requests. A failed scene load must provide a safe return to menu or hub, never leave an invisible active player or a frozen input context.

## Hub versus side-view

The hub and chase use distinct actor scenes, camera setup and movement controllers. They share canonical item/case/health data via adapters. Scene unloading is not equivalent to forgetting the current case or inventory.
