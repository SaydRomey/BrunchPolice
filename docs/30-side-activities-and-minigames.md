# Optional Side Activities and Reusable Minigames

## Role

Side activities enrich the buffet, create reasons to revisit areas and teach mechanics without delaying the required crime investigation. Every activity is clearly marked optional unless an authored case explicitly requires a short instructional variant.

## Supported families

| Family | Interaction | Reward | Interface |
|---|---|---|---|
| Evidence sorting | Arrange or connect clues in a case board panel | Hint or optional case detail | Drag/drop and gamepad selection |
| Timed plate inspection | Find marked details in an inspection scene | Bonus score/cosmetic | Inspectable hotspots |
| Appliance puzzle | Rotate pipe/valve nodes to connect flow | Optional shortcut or item | Grid and interact actions |
| Time trial | Complete short platform route against a clock | Medal/score | Level timer and checkpoint markers |
| Fishing-style buffet task | Repeated timing action with readable window | Optional collectibles | Hold/press prompt with accessibility alternatives |

## MinigameDefinition

`minigame_id`, title/localization key, mode, step list, constraints, entry prerequisites, pause policy, win/fail conditions, replayability, reward transaction ID, audio/VFX profile and assist options.

## Accessibility

Timed variants offer adjustable timing or non-timed practice where practical. Precision must not depend on ambiguous flashing, unreadable tiny text or mouse-only drag. An activity should exit safely to its caller and preserve focus.

## Completion and persistence

Minigames emit completion/failed/cancelled events. The campaign stores best result and one-time reward delivery separately. Optional activities may be replayed without corrupting the active case or triggering world transitions.
