# Implementation Architecture

# 16. Development / Project Architecture Inventory

## 16.1 Existing File Structure Direction

Core source folders:

- `src/core/`
  - `Game.cpp`
  - `Player.cpp`
  - `Enemy.cpp`
  - `Boss.cpp`
  - `Weapon.cpp`
  - `Inventory.cpp`
  - `DialogueSystem.cpp`
  - `SaveSystem.cpp`
- `src/utils/`
  - `Timer.cpp`
  - `ResourceManager.cpp`
  - `AudioManager.cpp`
  - `VisualEffects.cpp`
- `src/levels/`
  - `GreaseCanyon.cpp`
  - `PastryPalace.cpp`
  - `StickySyrupSwamp.cpp`
  - `KitchenMayhem.cpp`
  - `CandyChaos.cpp`
  - `EggFactoryFrenzy.cpp`
  - `CitrusCascade.cpp`
  - `BakeryBonanza.cpp`
- `inc/core/`
- `inc/utils/`
- `inc/levels/`
- `obj/`
- `build/`
- `gdnative/`
- `assets/`
- `scenes/`
- `helpers/`
- `shaders/`

## 16.2 Existing Assets Structure Direction

- Player sprites.
- Enemy sprites.
  - `croissant_crook.png`
  - `bacon_bandit.png`
  - `syrup_scoundrel.png`
  - etc.
- Audio/music.
- Audio/SFX.
- Backgrounds:
  - `grease_canyon_bg.png`
  - `pastry_palace_bg.png`
- Level scenes:
  - `grease_canyon.tscn`
  - `pastry_palace.tscn`
  - `sticky_syrup_swamp.tscn`
  - etc.
- Character scenes:
  - `player.tscn`
  - `croissant_crook.tscn`
  - `bacon_bandit.tscn`
- Shaders:
  - `grease_shader.gdshader`
  - `syrup_shader.gdshader`

---


## Related Systems

# 11. Combat, Damage, Health, Projectile, and Feedback Systems

## 11.1 Health Component

Current HealthComponent responsibility:

- Handles health, damage, and death for player, enemies, and bosses.
- Stores max health and current health.
- Allows setting max health.
- Returns current health.
- Takes damage.
- Heals.
- Checks whether entity is dead.
- On zero health, current code calls `queue_free()`.

## 11.2 Damage Calculation

Current damage system direction:

- Damage can be calculated based on weapon stats.
- Damage can use weapon damage values, modifiers, critical hits.
- Damage can include player/enemy attributes such as defense, resistance, and buffs.
- HealthComponent should accept source-based damage via:
  - `base_damage`
  - `damage_source` dictionary
- Example damage source fields:
  - `weapon_type`
  - `critical_hit`
- Example specific modifier:
  - `weapon_type == bacon_gun` can modify final damage.

## 11.3 Invincibility Frames

Current i-frame purpose:

- Prevent repeated damage in a short time.
- Provide visual/audio feedback.
- Can be implemented directly in HealthComponent or a separate state system.
- Uses:
  - `is_invincible`
  - `invincibility_duration`
  - `invincibility_timer`
  - `trigger_invincibility(duration)`
  - `update_invincibility(delta)`
- Example default duration: 1.0 second.

## 11.4 Visual Feedback / Blinking

Current visual feedback purpose:

- Notify player or user that entity is invincible.
- Provide immediate feedback when damage is taken.
- Implement in entity main script or Sprite node.
- Trigger through HealthComponent.
- Blinking example:
  - Toggle Sprite visibility every 0.1 seconds.
  - Stop after invincibility duration.
  - Ensure visibility is restored after blinking.

## 11.5 Projectile Manager

Current Projectile system:

- Projectiles handle their own movement, collisions, and damage.
- Supports multiple projectile types, e.g. bullets, rockets, magic spells, food projectiles.
- Tracks:
  - Velocity.
  - Damage.
  - Speed.
  - Range / lifespan concept.
- Functions:
  - `_physics_process(delta)` moves projectile.
  - `set_velocity(dir)` normalizes direction.
  - `set_damage(dmg)` sets damage.
  - `on_body_entered(body)` calls `take_damage` if available.
  - Projectile destroys itself after hit.
  - Projectile destroys itself when off-screen.

### Existing / Implied Projectile Types

- Bacon Gun strip projectile.
- Whipped cream projectile.
- Knife projectile.
- Jellybean projectile.
- Yolk bomb.
- Juice jet.
- Orange grenade / citrus blast.
- Syrup projectile.
- Flour cloud projectile / puff.
- Explosive candy.
- Explosive muffin.

---


# 12. Interaction System Inventory

Current interaction system supports:

- Inspecting objects.
- Inspecting NPCs.
- Triggering events.
- Opening doors.
- Activating switches.
- Context-sensitive prompts such as “Press E to talk”.
- Starting a boss fight.
- Picking up temporary weapons.
- Activating checkpoints.
- NPC dialogue integration.
- Dialogue + interaction integration.

Implementation direction:

- Interaction Manager uses `Area2D` style interaction zones.
- Interactions can map to named actions/events.
- NPCs can use interaction triggers to start dialogue.
- Reusable modular triggers should be used for boss fights, weapon pickups, and checkpoints.

---


# 13. Dialogue System Inventory

Current dialogue system supports:

- NPC dialogue display.
- Optional typewriter effect.
- Branching dialogue paths.
- Player choices.
- NPC reactions.
- Dialogue-specific events.
- Accusations.
- Triggering NPC fleeing behavior after a correct accusation.
- Humorous responses for incorrect accusations.
- Clue gathering.
- Casual partner mentions as inclusion detail.
- Proposal side quest dialogue.

---


# 9. Enemy Architecture Inventory

## 9.1 Base Enemy Class Direction

All regular enemies can inherit from a reusable `BaseEnemy` with:

- Health.
- Speed.
- Damage.
- Death state.
- `_process` default idle behavior.
- `_physics_process` default physics behavior.
- `take_damage(amount)`.
- `attack()`.
- `check_is_dead()`.

Bosses should be separated into their own classes because they involve unique phases and arena mechanics.

## 9.2 Core AI Movement Behaviors

Reusable AI behavior classes / concepts:

- Patrolling AI: moves between set points on a platform.
- Chasing AI: follows player within a defined detection range.
- Flying AI: handles airborne enemies and unique flight patterns.
- Pathfinding AI: A* or Dijkstra for complex levels.
- Idle state.
- Patrolling state.
- Chasing state.
- Attacking state.
- Retreating state.
- Detection range.
- Attack range.
- Attack cooldown.
- Patrol range.
- Patrol points.
- Movement speed.
- Retreat threshold.

## 9.3 Extended Enemy States

| State | Current Meaning | Current Use Candidate |
|---|---|---|
| Idle | Stationary/simple animations | All enemies |
| Patrolling | Moves along path/platform | Pigs, chefs, rolling enemies |
| Chasing | Follows player in range | Chickens, donuts, golems, muffins |
| Attacking | Performs melee/ranged attack | All combat enemies |
| Retreating | Moves away / safe position | Low-health enemies |
| Stunned | Temporarily disabled | Bacon Bandit hit by grease trail; weapon effects |
| Summoning | Spawns minions/traps | Croissant Crook spawning rolling croissants |
| Fleeing | Runs away when health drops | Culprits and special enemies |
| Frozen | Immobilized but vulnerable | Future ice/frost weapon effects |
| Invincible | Ignores damage during i-frames | Health component / visual feedback |
| Wrapped | Immobilized by Bacon Gun | Bacon Gun effect |
| Slowed | Movement speed reduced | Syrup / grease / sticky weapons |
| Blinded | Vision/aim impaired | Dishwasher Sprayer or Flour Cloud effects |

## 9.4 Environment-Aware Enemy Interaction Types

| Interaction Type | Current Description | Brunch Police Example |
|---|---|---|
| Hazard-aware | Enemies avoid or take damage from hazards | Bacon worms can die in boiling grease pits |
| Platform-aware | Enemies follow platforms or avoid edges | Platform-bound éclairs avoid falling |
| Destructible-aware | Enemies break crates/barrels/objects | Bees destroy player barricades |
| Trigger-aware | Enemies activate switches/traps | Kitchen enemies activate conveyors or moving hazards |
| Dynamic pathfinding | Enemies navigate around obstacles | Complex factory/kitchen layouts |

## 9.5 Enemy Spawning

EnemySpawner concept:

- Uses predefined spawn points.
- Can dynamically spawn enemies during gameplay.
- Stores enemy scene reference.
- Adds spawn points.
- Spawns a requested enemy count up to available spawn points.

Use cases:

- Boss summoning phases.
- Enemy waves.
- Respawning hazards.
- Arena escalation.

---
