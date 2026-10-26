# Canonical Data Schemas and Stable Identifiers

## Registry

Data resources may be `.tres` `Resource` instances, validated JSON or equivalent Godot data objects. The published registry resolves stable identifiers to project-controlled resources. Use the schema conventions below consistently.

| Record | Required keys | State owner |
|---|---|---|
| `WorldDefinition` | `world_id`, `title_key`, `scene_id`, `boss_id`, `signature_mechanic_id` | World registry |
| `CaseDefinition` | `case_id`, `culprit_id`, `world_id`, `evidence_ids`, `requirements`, `reward_ids` | Case service |
| `EvidenceDefinition` | `evidence_id`, `case_id`, `title_key`, `description_key`, `hotspot_id` | Case service |
| `SuspectDefinition` | `suspect_id`, `display_name_key`, `conversation_ids` | Narrative registry |
| `WeaponDefinition` | `weapon_id`, `slot_type`, `action_ids`, `icon` | Equipment registry |
| `ItemDefinition` | `item_id`, `category`, `stack_limit`, `use_action_id` | Item registry |
| `EnemyDefinition` | `enemy_id`, `movement_id`, `attack_id`, `hp`, `speed` | Enemy registry |
| `BossDefinition` | `boss_id`, `phase_ids`, `vulnerability_policy` | Boss registry |
| `QuestDefinition` | `quest_id`, `objective_ids`, `reward_ids` | Quest tracker |
| `DialogueGraph` | `conversation_id`, `start_node_id`, `node_ids` | Narrative service |
| `UITheme` | `theme_id`, colors, fonts, button/panel styling | UI theme service |

## Prefixes

`case_`, `boss_`, `enemy_`, `weapon_`, `item_`, `evidence_`, `quest_`, `world_` for general registries where ambiguity matters; world IDs used in scene routing are short stable names such as `caffeine_craze`. Do not silently rename an existing stable save identifier. When renaming is essential, supply a versioned migration map.

## Validation rules

- All referenced IDs exist, including every objective event, boss and evidence entry.
- Resource definitions cannot use display names as keys; canonical references are machine IDs.
- A case has exactly one correct culprit, at least one reachable required evidence predicate and a valid chase scene.
- No quest has unreachable mandatory dependencies or a self-referential completion loop.
- Phase graphs have valid entry/exit events; every boss includes a terminal defeated state.
- Status multipliers and inventory quantity/stack limits are bounded.

## Recommended tests

A registry audit checks unique IDs and missing references. A save round-trip test serializes/deserializes all primitive fields, runs migrations, and checks identical active case, equipment, inventory, quest and unlock states.
