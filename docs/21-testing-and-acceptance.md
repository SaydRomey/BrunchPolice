# Testing, QA and Acceptance

## Quality gates

1. **Content lint:** all world/case/weapon/evidence IDs are unique and every referenced ID resolves.
2. **Resource lint:** `res://` references exist, `.tscn` node parent paths are valid, no dependency cycles.
3. **Parser/import:** Godot command-line project import and script parse complete without errors.
4. **Contracts:** inventory add/equip/use; damage/status; checkpoint; save migration; event deduplication; UI data adapters.
5. **Playtest:** a full hub accusation → chase → checkpoint → boss → case resolution sequence, including failed variants.
6. **Accessibility:** keyboard-only, gamepad-only, high text scale, reduced flashing, muted audio, resizable window.
7. **Release:** packaging, clean install, persistent saves, no debug UI or broken art/audio in export.

## Minimum scenarios

| Scenario | Expected result |
|---|---|
| Discover evidence twice | One canonical evidence record; no duplicate reward |
| Wrong accusation | Appropriate dialogue; case remains open; no chase route |
| Correct supported accusation | Single transition to the matching level |
| Damage during i-frames | No additional HP loss unless explicitly bypass-tagged |
| Enemy hit by immune status | Correct damage result; immunity indicator; no effect applied |
| Boss armor closed | Attack blocked/reduced with feedback; no invisible HP change |
| Pressure vent warning | Clear telegraph before release; safe response path |
| Steam lift | Predictable controlled upward movement, no unintended damage |
| Save and reload hub/chase | Case, inventory, quest and checkpoint state match |
| Corrupted slot | Safe error and validated backup recovery |
| Controller navigation | No trapped focus in any modal overlay |
| Defeat/retry boss | Respawn at correct checkpoint; no reward duplication |

## Traceability

Each feature spec includes at least one test case tagged with system ID. Acceptance remains `not_tested`, `failed`, `passed` or `waived_with_reason`; static lint is not equivalent to gameplay validation. No documentation may claim a prototype is runtime-ready without an executed test report.

## Automation examples

- Headless scene open for each addon scene and all eight world entrance/boss scenes.
- Unit-style tests for serialization, status stacking, attack instance deduplication and clue predicate evaluation.
- Input integration fixtures for pause/unpause, UI focus restoration, simultaneous dialogue and save restrictions.
- CI Markdown link validator and cross-catalog ID collision detector.
