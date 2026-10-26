# Content Production Standards

## Every content record needs

Stable ID; localized display title; world and gameplay role; owner; status; dependencies; scene/resource path; configurable Inspector fields; collision/feedback requirements; accessibility treatment; save behavior; and acceptance test ID. Art and audio references remain deliverables rather than inline dependencies on personal directories.

## Naming

Use lowercase snake_case for IDs: `steam_pressure_vent`, `boss_mocha_menace`, `coffee_carafe_tags`. Scenes use descriptive singular names (`steam_vent.tscn`, `boss_mocha_menace.tscn`); resource definitions use matching variant names. Translation keys use `ui.menu.start`, `case.coffee.title` style dotted namespaces.

## Scene authoring checklist

- Scene can be instantiated more than once without shared mutable state leaking.
- Exports cover label, visual resource, tint, dimensions, timing, variant and debug label controls where appropriate.
- Art is aligned to the game's integer pixel scale; collision and visible edges correspond.
- Named signals exist for externally interesting events; the scene does not assume a singleton UI path.
- Player collision layers/masks and faction filters are set deliberately.
- Editor previews update safely with `@tool` only where needed; no gameplay writes run in the editor.
- Audio/VFX are event-driven and can be disabled for accessibility.

## Status workflow

`idea` → `design` → `graybox` → `prototype` → `implemented` → `playtested` → `approved`. Store the current status in a content registry or tracking sheet; a named scene alone does not advance it to approved.

## Review and balance

Level metrics: completion time, deaths by hazard, checkpoint resets, evidence find rate, mechanic comprehension. Combat metrics: hit frequency, guard success, vulnerability time, status effectiveness. UI metrics: mis-selections, focus traps, text overflow. Keep design values separate from measured playtest values.
