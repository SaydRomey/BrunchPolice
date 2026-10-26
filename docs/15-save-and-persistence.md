# Saving, Loading and Persistent Game State

## Contract

Save records are **versioned data**, not serialized Godot node instances. A save slot has stable slot ID, creation/update time, schema version and human-readable summary. User-controlled slot operations display success/failure, enforce valid slot IDs and use safe write/replace with backup recovery.

## Save payload example

```json
{
  "schema_version": 1,
  "slot_id": 1,
  "campaign": {
    "active_case_id": "case_coffee",
    "completed_case_ids": ["case_bacon", "case_croissant", "case_syrup", "case_cutlery"],
    "unlocked_world_ids": ["grease_canyon", "pastry_palace", "sticky_syrup_swamp", "kitchen_mayhem", "caffeine_craze"]
  },
  "scene": {"scene_id": "caffeine_craze", "checkpoint_id": "espresso_engine_02"},
  "player": {"health": 4, "max_health": 5, "facing": 1},
  "inventory": {"espresso_stirrer": 1, "coffee_filter_shield": 1},
  "equipment": {"main_hand": "espresso_stirrer", "off_hand": "coffee_filter_shield", "two_hand": ""},
  "cases": {"case_coffee": {"status": "chase_active", "evidence_ids": ["coffee_carafe_tags"], "attempted_suspect_ids": []}},
  "quests": {"case_coffee": {"talk_coffee_guests": 2}},
  "one_time_rewards": [],
  "flags": {}
}
```

The sample uses illustrative state. The schema must be validated by a registry of legal item/world/case IDs and migrated when the version changes. Display strings are excluded from persistent identity.

## Save boundaries

- **Manual save:** at stable hub locations, safe checkpoints and when no non-serializable transition or boss cinematic is active.
- **Autosave:** after confirmed case completion, checkpoint activation or eligible scene arrival—not during partially applied scene transitions.
- **Checkpoint state:** temporary, level-local snapshot; optional persistent checkpoint ID for resume, with transient physics projectiles excluded.
- **Preferences:** audio/graphics/input/accessibility settings stored separately from case slots.

## Load workflow

Read slot → verify version and value types → migrate if supported → validate IDs → stage state in memory → route to trusted scene ID → restore actor/inventory/quests/cases → rebind UI → release player control. A failed load leaves the current game intact and shows an actionable error. Corrupt primary files can be recovered from validated backups.

## Consistency guarantees

- Case rewards and evidence pickup IDs are idempotent.
- Loading cannot duplicate inventory or spawn multiple players.
- Player position is restored from a trusted checkpoint locator rather than arbitrary out-of-bounds coordinates.
- Stale missing content IDs are skipped with warnings or mapped via migrations; never silently reassigned to an unrelated item.
- Saves do not include engine resource paths supplied by untrusted file content for arbitrary loading.
