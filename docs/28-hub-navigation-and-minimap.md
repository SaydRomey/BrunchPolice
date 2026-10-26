# Buffet Hub Navigation, Map and Minimap

## Purpose

The buffet hub is a readable explorable investigation space. Players need to locate case stations, witnesses, exits and newly discovered evidence without turning the detective loop into a waypoint checklist. A case board anchors long-term progress, while an optional map/minimap assists local navigation.

## Map model

`HubMapDefinition` contains `map_id`, static layout, navigation bounds, world-to-map transform, station IDs, active NPC markers and optional undiscovered zones. An objective marker references `quest_id` and `target_id`; markers cannot expose unrevealed culprit identities or hidden evidence.

## Minimap

- Round or clipped rectangular viewport with themeable badge/compass frame.
- Player marker centered or camera-followed; a directional arrow rotates consistently with map orientation.
- Adjustable zoom and on/off toggle, saved per user preference.
- Pins for active case stations, known witnesses and enabled transition doors.
- Optional obstacle/wall silhouettes; never draw every offscreen enemy or undiscovered secret by default.

## Case board vs map

**Map:** *Where can I go?* **Case board:** *Which cases are available and what clues do I have?* Both can be opened from the hub pause interface, but only the case board contains suspect/evidence associations and accusation controls.

## Navigation hints

Unknown clues may surface a broad investigation region, not an exact hotspot location. An optional accessibility hint can point toward an interactable in the current station. Main objectives always include a textual destination label in addition to a pin.

## Implementation notes

A minimap may use a `SubViewport` or authored map texture, but must be inexpensive and preserve pixel clarity. The minimap subscribes to player/case location signals, not direct actor lookup every frame. Hidden, completed and inaccessible points are filtered by the campaign state.

## Acceptance

Test player orientation, zoom at world bounds, icon clutter, objective switching, keyboard/gamepad toggling, save/reload of visibility and correct filtering of inaccessible cases. The minimap must not obstruct focusable dialogue or inspection UI.
