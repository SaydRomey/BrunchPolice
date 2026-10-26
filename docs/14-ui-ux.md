# UI, Menus and In-Game Information

## Design language

Receipt paper, police case files, diner tickets, rounded cartoon buttons and chunky pixel-edge frames. Functional text remains crisp and readable. Warm cream surfaces, dark coffee outlines, egg-yellow selection and restrained red warnings support rapid scanning. Sound, focus shape and text accompany color transitions.

## Screen inventory

| Scene/screen | Primary functions | State dependency |
|---|---|---|
| Main menu | New Game, Continue, Load, Settings, Credits, Quit | Save slots / preferences |
| Save slots | Preview, overwrite confirmation, load/delete, backup recovery | Persistent save metadata |
| Pause menu | Resume, case notes, loadout, checkpoint retry, save, settings, return | Current mode and save safety |
| Settings | Audio, visuals, text, effects, control remap, accessibility | Global user preferences |
| Inventory/equipment | Browse grid, item detail, quantities, equip/use | Item definitions + actor adapter |
| Gameplay HUD | Health, equipped items, status timers, active objective, evidence count | Player/quest/case signals |
| Boss bar | Boss name, HP, phase/vulnerability cue | Boss signals |
| Dialogue | Portrait, speaker, text, choices, advance/skip | Dialogue state |
| Quest journal | Active/completed cases, goals, reward state | Quest and case service |
| Inspection | Zoomed plate/object, hotspots, evidence record | Interaction/case state |
| Accusation | Suspects, evidence support, confirmation, result | Case state |
| Case board | Eight cases, unlock conditions, world identity | Campaign state |
| Result screen | Case closed, evidence, rewards, retry/hub | Completion transaction |
| Shared widgets | Prompt, notification, item slot, confirm dialog, focus marker | Event and UI theme |

## Screen placement

Hub HUD is investigation-focused: active case/goal, evidence count and interaction prompt. Chase HUD is action-focused: health, equipped weapons/items, active status, checkpoint and limited objective. Dialogue and inspection overlays take input focus and minimize or dim combat HUD. Boss bar appears only when the boss is active.

## Navigation policy

UI uses Godot `Control` focus neighbors and `ui_up/down/left/right`, `ui_accept`, `ui_cancel`; gamepad D-pad/stick and keyboard get identical button order. A panel must set initial focus, loop focus intentionally, and restore prior focus when it closes. Mouse hover and touch cannot be the only way to activate an essential screen.

## Pause behavior

Pause freezes gameplay physics and status timers; the UI continues via appropriate process modes. Pausing in the hub shows Case Notes prominently; pausing during a chase highlights Retry from Checkpoint, Evidence, Equipment and Resume. Menus must never continue firing a held attack after returning to gameplay.

## Editable presentation

Every reusable UI scene exposes title text, icon, skin resource, accent colors, visibility and layout controls in the Inspector. Debug labels are optional, can be repositioned, and never appear in export builds unless enabled via an explicit debug setting.

## Accessibility

Text scale, subtitles, reduced flashes, reduced camera shake, contrast, distinct focus outlines, hold/toggle options and fully visible controller mappings are required. Audio sliders adjust independent buses. Save destructive actions always require confirmation and provide error feedback.
