# Audio, Visual, UI, and Feedback Systems

## Purpose

This note consolidates audio managers, dynamic sound, ambiance, particle effects, visual feedback, sprite animation, character customization, and debugging overlays.

## Source files covered

- `ambiance-management.txt`
- `sound-manager.txt`
- `dynamic-sound-effect.txt`
- `visual-effects-manager.txt`
- `visualfeedbackmd.txt`
- `sprite-animation-controller.txt`
- `character-customization.txt`
- `debug-tools.txt`

## System map

| System | Role |
|---|---|
| Sound Manager | Centralized BGM and SFX playback. |
| Dynamic Sound Effects | Distance volume, pitch variation, echo/reverb, positional audio. |
| Ambiance Manager | Filters, overlays, lights, fog, gas, day/night cycles. |
| Visual Effects Manager | Particle effects such as explosions, smoke, dash effects. |
| Visual Feedback | Blinking effect for damage/invincibility. |
| Sprite Animation Controller | State-driven animation playback. |
| Character Customization | Skin tone, hair color, outfit, and player sprite customization. |
| Debug Tools | Overlay for player stats, frame rate, memory usage. |

## Sound Manager

Sound Manager centralizes background music, sound effects, volume controls, looping, SFX preloading, and SFX cleanup after playback.

Main properties:

```cpp
Ref<AudioStreamPlayer> bgm_player;
std::map<std::string, Ref<AudioStream>> sound_effects;
float music_volume;
float sfx_volume;
```

Main operations:

- `set_music_volume`
- `set_sfx_volume`
- `play_bgm`
- `stop_bgm`
- `preload_sound`
- `play_sfx`

Recommended future additions:

- Crossfades.
- Audio bus routing.
- Separate UI/SFX/ambient/music channels.
- Save/load audio settings.
- Randomized SFX variations.

## Dynamic Sound Effects

Dynamic sound effects include footstep sounds by surface type, distance-based volume, pitch variation, environmental reverb/echo, and positional audio.

Main properties:

```cpp
Node2D *listener;
float max_distance;
float base_volume;
```

Main operations:

- `set_listener`
- `set_max_distance`
- `update_volume`

Example dynamic features:

- Randomize jump pitch between `0.9f` and `1.1f`.
- Use `AudioEffectReverb` for caves or large spaces.
- Use attenuation and bus routing for positional effects.

## Ambiance Manager

Ambiance Manager handles visual filters, fog, toxic gas, day/night overlays, light sources, candles, flashlights, and dynamic environment mood.

Main properties:

```cpp
Ref<ColorRect> filter_overlay;
std::vector<Light2D *> light_sources;
Color filter_color;
float filter_opacity;
```

Main operations:

- `set_filter_color`
- `set_filter_opacity`
- `apply_filter`
- `add_light_source`
- `remove_light_source`
- `update_lighting`

Day/night cycle concept:

- `time_of_day` ranges from midnight to midday.
- Interpolate between day color and night color.
- Update filter overlay over time.

## Visual Effects Manager

VisualEffectsManager centralizes particle effects such as explosions, smoke, dash trails, environmental particles, and weapon effects.

Main properties:

```cpp
std::map<std::string, Ref<Particle2D>> effect_templates;
```

Main operations:

- `preload_effect`
- `create_effect`
- `clear_effects`

Recommended cleanup:

- Confirm Godot 4 uses `GPUParticles2D` or `CPUParticles2D`, not older `Particle2D`.
- Instantiate `PackedScene` effects rather than reusing the same resource instance if necessary.
- Auto-free one-shot effects after completion.

## Visual Feedback

The visual feedback document describes blinking after damage or during invincibility.

Behavior:

- Create blink timer.
- Toggle sprite visibility every `0.1f`.
- Create end timer.
- Stop blinking after invincibility duration.
- Restore sprite visibility.

Recommended final design:

- Do not embed blinking directly into every enemy.
- Use a reusable `VisualFeedbackComponent`.
- Trigger it from HealthComponent events such as `damaged` or `invincibility_started`.

## Sprite Animation Controller

The Sprite Animation Controller maps logical states to animations.

Examples:

- `idle`
- `run`
- `jump`
- `attack`
- `patrolling`
- `rotate`

Main properties:

```cpp
Ref<AnimatedSprite2D> sprite;
std::map<std::string, String> animation_states;
String current_state;
float animation_speed_scale;
```

Main operations:

- `set_sprite`
- `add_animation_state`
- `play_state`
- `set_animation_speed`
- `get_current_state`

Recommended integration:

- Player movement sets idle/run/jump/fall/dash states.
- Enemy AI sets patrol/attack/hurt/dead states.
- Environment objects use looped states such as rotate or blink.

## Character Customization

Character customization supports skin tone, hair color, outfit, real-time appearance updates, and saving/loading customization data through a `Dictionary`.

Main class:

```cpp
CharacterCustomizer
```

Important operations:

- `set_player_sprite`
- `set_customization_option`
- `get_customization_option`
- `apply_customizations`

Recommended final additions:

- Separate layers for body, hair, outfit, accessories.
- UI preview scene.
- Save/load customization values.
- Expand beyond modulate-only skin tone changes.

## Debug Tools

Debug overlay should display:

- Player position.
- Player velocity.
- Other stats.
- Frame rate.
- Memory usage.

Recommended additions:

- Toggle key.
- Collision overlay.
- Current weapon.
- Current state.
- Active timers.
- Active power-ups.
- Current checkpoint.
- Resource counts.
