# Investigation and Case Management

## Player goal

Identify the culprit through inspectable clues, character interviews, plate examinations and an explicit accusation. The game provides enough in-world information for a reasoned deduction and celebrates correct reasoning without punishing experimentation harshly.

## Model

- **CaseDefinition:** `case_id`, title, buffet station, involved suspects, clue IDs, minimum accusation criteria, culprit ID, chase level ID, rewards and completion event.
- **SuspectDefinition:** `suspect_id`, display name, role, portrait, dialogue graph, alibi, visible behavior cues and optional red-herring clues.
- **EvidenceDefinition:** `evidence_id`, `case_id`, name, inspectable world object ID, description, type, display icon, related suspect IDs, discovered state and journal text.
- **CaseState:** `discovered_evidence_ids`, interviewed NPC IDs, unlocked accusations, attempted accusation IDs, `case_status`, boss defeated and resolution committed.
- **EvidenceRelation:** optional explicit links (`supports`, `contradicts`, `context`) between evidence and suspect claims.

## Investigation spaces

The buffet hub contains food stations, tables, seating, drink counters, staff doors and an investigation board. Evidence can be concealed in plate close-ups, receipts, shelf displays, spilled ingredients, inventory items and NPC dialogue. Evidence is discoverable by inspection, not automatic proximity alone unless accessibility settings enable simplified interaction.

## Plate inspection flow

1. Focus on an interactable plate to open an inspection overlay; suspend movement and preserve input focus origin.
2. Pan/select hotspots with cursor or focus controls; hotspots include affordance outlines and text labels.
3. Inspect a hotspot to reveal description, significance, and optionally a new evidence ID.
4. Show discovered/total inspectable clues without exposing unseen answers.
5. Close inspection, restore focus and update case notebook/HUD objective.

## Accusation flow

1. Select suspect; show suspect profile and relevant evidence tiles.
2. The player explicitly selects the supporting evidence or confirms the evidence summary.
3. Validate the case's required clue predicates. If insufficient, provide an actionable explanation without exposing concealed evidence.
4. Submit. If suspect is incorrect, display unique dialogue and record attempt; the case stays open.
5. If correct, commit `accusation_correct`, play escape sequence, set `case_status = chase_active` and route to the target chase scene.

## Evidence plan by world

| World | Primary exhibit | Hub evidence example | Chase corroboration |
|---|---|---|---|
| Grease Canyon | Bacon strips | Unusual bacon stack and grease trail | Stolen bacon scattered along chase |
| Pastry Palace | Croissant wrapping | Crumb-lined carry bag and missing pastry receipt | Marked pastry wrappers near escape route |
| Sticky Syrup Swamp | Syrup valve seal | Sticky spill and tampered dispenser | Matching valve key imprint |
| Kitchen Mayhem | Stolen cutlery | Empty cutlery tray and utensil count | Initialed cutlery cache |
| Caffeine Craze | Stolen coffee tags | Empty carafes, decaf swap, oversized travel mug | Missing carafe labels on espresso equipment |
| Egg Factory Frenzy | Egg-carton manifest | Egg count mismatch and shipping labels | Factory carton seals |
| Citrus Cascade | Bottle security seals | Empty orange juice rack and tampered caps | Matching juice bottling batch tags |
| Bakery Bonanza | Muffin wrapper stamp | Muffin display shortfall and flour trail | Wrapped muffin cache in boss area |

**Content target:** each world must contain a minimum of one identity clue, one location/means clue and one corroborating clue. The examples above establish level-writing targets; final clue dialogue and hotspot placement require authored scene content.

## Edge cases and acceptance

- Evidence acquired in a chase must remain associated with its case when returning to the hub.
- A wrong accusation cannot start the chase or overwrite a solved case.
- Duplicate evidence pickups do not create multiple IDs or inflate counters.
- Save/load during a case restores discovered clues, attempts and tracked case accurately.
- Dialogue/inspection from one case cannot complete another without explicit shared-evidence rules.
