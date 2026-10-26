# Events, Timers, Scoring and Scripted Sequences

## EventBus

Semantic game events are small typed payloads containing `event_id`, `event_type`, timestamp within session, actor/world/case IDs and data. Event IDs support idempotency for progress, drops and rewards. Observers subscribe to events rather than hardcoding a path to each HUD or quest node.

Common events: `interaction_activated`, `evidence_discovered`, `npc_interviewed`, `attack_hit`, `status_applied`, `checkpoint_activated`, `quest_advanced`, `boss_phase_changed`, `boss_defeated`, `case_closed`.

## Timer service

Timers own an ID, time basis (physics gameplay, real-time UI, or unscaled cinematic), duration, remaining time, repeat policy, cancel policy and owning scene/context. Gameplay timers pause with world physics. Cooldowns and explosions cannot fire after their owning scene has unloaded. Repeating timers restart from the configured duration, not the overrun's remaining time.

Common applications: weapon cooldown, delayed explosion, pressure-cycle transition, status expiry, timed hazard and encounter sequence.

## Sequence queue

A sequence is a list of commands with completion acknowledgments (e.g. lock input → play emote → display dialogue → open gate → release input). It is cancellable on scene teardown, and it cannot create duplicate transitions. A boss defeat sequence registers completion after the event has committed so rewards are not repeated on replay.

## Scoring and optional medals

`ScoreManager` tracks points earned from combat, evidence discovery, optional pickups and authored bonus goals. The core case flow is not gated by score. An optional level medal or time-trial grade may use elapsed time, damage taken and side objectives; it must have its own best-result fields rather than overwriting case-completed state.

| Event | Score semantics |
|---|---|
| Regular enemy defeated | Optional configurable amount; no farmable infinite reward unless intended |
| New evidence logged | Reward once per evidence ID |
| Optional route finished | Level-specific bonus; visible criteria |
| Boss defeated | One completion transaction, distinct from replay score |
| Wrong accusation | No irreversible penalty by default |

## Testing

Verify timer cancellation, reentrancy, pause behavior, frame drops, scene unload, duplicate event rejection and save/load of durable progress only. Do not serialize arbitrary callback objects; reconstruct timers from stable definition IDs when needed.
