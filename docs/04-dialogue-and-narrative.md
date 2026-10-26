# Dialogue and Narrative Events

## Dialogue requirements

NPC dialogue displays speaker name and optional portrait, supports a typewriter reveal, player response choices, conditional branches, localized strings and event emission. The dialogue panel respects accessibility text speed and reduced-motion settings. A single input reveals the current line; a subsequent input advances it.

## Data contract

`DialogueConversation` contains `conversation_id`, `start_node_id` and nodes. Each `DialogueNode` has `node_id`, `speaker_id`, text localization key, optional portrait expression, optional on-enter/on-exit event IDs and a list of choices. Each choice has text key, predicate IDs, next node ID and optional event IDs. Conditions are evaluated against read-only case/quest state.

## Narrative events

`evidence_discovered(evidence_id)`, `npc_interviewed(npc_id)`, `quest_advanced(quest_id, objective_id)`, `accusation_submitted(case_id, suspect_id)`, `culprit_exposed(case_id)`, `chase_started(level_id)` and `case_closed(case_id)` are semantic events. They carry stable IDs, never display names.

## Dialogue behavior rules

- Every required clue must be obtainable even if optional conversation branches are skipped.
- Choices that trigger accusation or scene transitions require a confirmation boundary.
- Suspects and witnesses use their specified names/pronouns; no dialogue infers identity from visual presentation.
- On pause, dialogue state is retained; scene changes close the panel and serialize relevant narrative flags.
- Keyboard, gamepad and mouse paths must reach the same choices. Focus returns to the original interactable after closing.

## Writing standard

Comedic beats should be concise and clue-bearing. Dialogue may redirect the player but must not obscure an essential fact behind timing, audio-only speech or unskippable long text. Plan a neutral fallback line for repeated interrogation.
