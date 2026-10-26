# Combat, Health, Damage and Feedback

## Combat model

A hit is a structured payload processed by a receiver. Weapons, enemies and hazards share the same receiver contract; differences are expressed with tags and policies. The receiver is responsible for armor/vulnerability gating, damage adjustment, immunity, applied statuses and event feedback.

```text
Attack → collision candidate → faction/filter validation
       → invulnerability and block test → armor/weak-point rules
       → damage modifiers → health change → status application
       → knockback/interruption → VFX/audio/UI feedback
```

## Required combat payload

`attacker_id`, `faction`, `base_damage`, `damage_tags`, `hit_position`, `hit_direction`, `knockback`, `status_effects`, `crit_flag`, `attack_instance_id`. The receiver returns a result including `accepted`, `blocked`, `damage_applied`, `statuses_applied`, `interrupted` and `death_triggered`. Attack instance IDs prevent a multi-frame melee hitbox from striking the same entity unintentionally more than once.

## Health rules

- Health is bounded to `[0, max_health]`; reaching zero emits `died` once before actor-specific cleanup.
- Damage, healing and max-health changes emit signals for HUD and sound; health nodes never assume the owner should immediately disappear.
- Player invincibility frames prevent repeated damage for a configured interval; environmental kills and scripted boss conditions may explicitly bypass this only by policy.
- Enemy death can trigger drops, score and encounters; a boss death commits only after death animation and completion transaction.

## Armor, guard and weakness

`ResistanceProfile` evaluates tags such as `sharp`, `blunt`, `heat`, `cold`, `sticky`, `projectile` and level-specific `shell_break`. Shields evaluate hit direction and durability before HP damage. A boss may stay armored until a specific counter (e.g. Egg Launcher shell crack or Caffeine pressure valves) opens an explicit vulnerability window. A status immunity must be distinguished from zero damage resistance.

## Effects and visuals

`CombatFeedback` listens to hit/blocked/status/died events and drives `AnimationPlayer`, VFX scenes, particles, hit flashes, audio and camera cues. Accessibility limits flash frequency and camera shake. Event feedback does not alter the gameplay damage state.

## Enemy attack readability

Every attack defines telegraph → active frames → recovery and cancellation windows. Counterplay must be possible at ordinary movement speed and supported by silhouette, sound and placement. Record actual active frames, hitbox size and cooldown during animation authoring.

## Verification

Test friendly-fire policy, repeated hits, immunity, guard angles, resistances, status stacking, simultaneous death/hit, offscreen projectiles and boss-phase damage gates. Maintain deterministic hit order for replayable tests.
