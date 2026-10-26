# Controls and Accessibility

## Input map

| Action | Keyboard default | Gamepad default | Context |
|---|---|---|---|
| Move | Arrows / WASD | Left stick / D-pad | Hub and chase |
| Jump | Space | South face button | Chase |
| Attack | J | West face button | Chase |
| Charged attack | Hold K, release | Hold east face button | Chase |
| Special | L | Right shoulder | Chase |
| Block / off-hand | B | Left shoulder | Chase |
| Interact / dialogue | E | South face button near target | World / dialogue |
| Inventory | I | View/Select equivalent | Both |
| Journal / case notes | M | Assigned shortcut / pause tab | Both |
| Pause / back | Esc | Start/Menu | Both |
| UI navigation | Arrows / Tab | D-pad / stick | Menus |
| UI accept / cancel | Enter / Esc | South / East face button | Menus |

Defaults must be reconciled with platform-specific gamepad labels during input implementation. Identical buttons may act differently by context only if gameplay input is suppressed while UI/dialogue owns focus.

## Accessibility baseline

- Rebindable gameplay/menu actions, with conflict warnings and a reset option.
- Independent master/music/SFX/voice sliders and subtitles with readable contrast.
- Adjustable text scale and typewriter speed; dialogue reveal/skip controls.
- Reduced flashing, lower particle density, optional screen shake and camera smoothing.
- Danger telegraphing via silhouette, icon, animation and sound, never color alone.
- Persistent focus outlines and predictable controller navigation on every modal screen.
- Hold/toggle choices for sprint/guard where applicable, and adjustable input buffer where feasible.
- Optional objective hints and inspection hotspot assist without disabling investigation decisions.

## Verification

Test all UI screens with keyboard-only and gamepad-only input, and verify focus restoration after overlays. Text must remain readable at elevated scale without clipped buttons. Critical warnings remain identifiable with desaturated visuals and muted audio.
