# Audio, Visual Effects, Visual Feedback, and Animation

## Sound Manager

`SoundManager.gd` centralizes background music and sound effects. It supports BGM playback, SFX caching, volume control, and basic BGM looping.

## Visual Effects Manager

`VisualEffectsManager.gd` preloads effect scenes and instantiates them at runtime. Use this for smoke, explosions, dash effects, impacts, splashes, and weapon effects.

## Visual Feedback

`VisualFeedback.gd` provides a reusable blinking effect for damage, invincibility, or temporary status feedback.

## Sprite Animation Controller

`SpriteAnimationController.gd` maps logical states like `idle`, `run`, `jump`, `attack`, and `hurt` to `AnimatedSprite2D` animations.

## Converted Scripts

| Script | Purpose |
|---|---|
| `godot/autoloads/SoundManager.gd` | BGM and SFX management |
| `godot/autoloads/VisualEffectsManager.gd` | VFX scene spawning and clearing |
| `godot/components/VisualFeedback.gd` | Blink feedback |
| `godot/components/SpriteAnimationController.gd` | Animation state mapping |
