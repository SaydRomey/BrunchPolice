# Health, Damage, and I-Frames

This section consolidates the health component, source-based damage calculations, invincibility frames, visual feedback, and enemy-size weapon-effect rules.

## Purpose

Use a reusable `HealthComponent` on players, enemies, bosses, destructible props, and hazards that can take damage.

The component should:

- Track current and maximum health.
- Accept a `damage_source` dictionary from weapons, hazards, or enemies.
- Apply modifiers such as critical hits, weapon type, resistance, vulnerability, and armor.
- Trigger invincibility frames after taking damage.
- Emit signals so enemies, UI, audio, and visual effects can react without hard-coding dependencies.

## Damage Source Dictionary

Use a dictionary when dealing damage:

```gdscript
var damage_source := {
    "weapon_type": "bacon_gun",
    "weapon_category": "ranged",
    "critical_hit": false,
    "attacker": player,
    "status_effect": "bacon_wrap"
}
health_component.take_damage(20.0, damage_source)
```

Recommended keys:

| Key | Type | Purpose |
|---|---:|---|
| `weapon_type` | String | Specific weapon id, such as `bacon_gun`. |
| `weapon_category` | String | `melee`, `ranged`, `aoe`, `hazard`, etc. |
| `critical_hit` | bool | Applies critical damage multiplier. |
| `attacker` | Node | Entity that caused the damage. |
| `status_effect` | String | Optional follow-up effect. |
| `damage_tags` | Array[String] | Flexible tags such as `food`, `sticky`, `fire`, `acid`. |

## Enemy Size Rule

For special weapon effects like Bacon Gun wrapping:

| Enemy Type | Result |
|---|---|
| Small enemy | Usually killed outright or heavily damaged. |
| Medium enemy | Damaged and affected by the special status effect. |
| Large enemy or swarm/mob enemy | Damaged only, usually no hard crowd-control. |
| Boss | Usually immune to hard control, but may take reduced damage or build stagger. |

This keeps weapons funny and useful without trivializing large encounters.

## GDScript Files

- `godot/components/DamageCalculator.gd`
- `godot/components/HealthComponent.gd`
- `godot/components/InvincibilityBlinker.gd`

## Godot Setup

Attach `HealthComponent.gd` as a child of the entity that should receive damage. Connect its signals to the parent entity, UI, sound, or visual effects as needed.
