# Quest, Objective and Evidence Tracking

## Architecture

`QuestDefinition` contains stable `quest_id`, title, description, objectives, dependencies, rewards and visibility rules. Each `QuestObjective` specifies `objective_id`, event predicate, target count and player-facing progress text. `QuestTracker` listens to event bus messages, updates counters once per unique event ID and emits `quest_updated` / `quest_completed`.

## Primary case quest

For a typical case: visit station → speak with witnesses → inspect clues → file supported accusation → pursue culprit → defeat boss → complete case report. Each stage has an accessible text description. Optional evidence and weapon tutorials are separate side objectives and cannot block a required investigation without explicit design.

## Tracking rules

- Exactly one objective may be pinned to the HUD; full journal exposes case, side quests, evidence and rewards.
- A completed objective cannot regress after save/load; counters never exceed their maximum unless repeatable is explicit.
- Rewards are granted using a unique completion transaction key.
- Missing evidence gives a hint category or suggested location, not a spoilered item list by default.
- Dialogue and interactions emit semantic event IDs; the quest system never polls raw text or node names.

## Sample

```yaml
quest_id: case_coffee
stages:
  - id: talk_coffee_guests
    event: npc_interviewed
    target_tag: coffee_station
    count: 2
  - id: discover_coffee_tags
    event: evidence_discovered
    evidence_id: coffee_carafe_tags
    count: 1
  - id: expose_mocha_menace
    event: accusation_correct
    case_id: case_coffee
    count: 1
  - id: defeat_grand_percolator
    event: boss_defeated
    boss_id: boss_mocha_menace
    count: 1
```

## Failure modes

Invalid event IDs are logged without mutating progress. An objective referencing a missing target fails content validation before release. Game restarts do not duplicate rewards or reset one-time quest dialogues.
