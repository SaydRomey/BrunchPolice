# Enemy AI Movement

Create reusable classes for enemy behaviors:

- **Patrolling AI**: Moves between set points on a platform.
- **Chasing AI**: Follows the player within a defined range.
- **Flying AI**: Handles airborne enemies with unique movement patterns.
- **Pathfinding AI**: Implements A* or Dijkstraâ€™s algorithm for navigating complex levels.

---

Modular Enemy AI system designed to handle common behaviors and allow for easy customization and reuse across different 2D games. It supports various AI behaviors such as patrolling, chasing the player, attacking, and retreating. This system will integrate seamlessly with Godot through C++98 using GDNative.

---

## Features of the Enemy AI System

### 1. Core Behavior States:

- **Idle**: Stays stationary or performs simple animations.
- **Patrolling**: Moves back and forth along a defined path.
- **Chasing**: Follows the player when in range.
- **Attacking**: Performs melee or ranged attacks when close to the player.
- **Retreating**: Moves away from the player or towards a safe point.

### 2. Advanced Features:

- Detection range for chasing or attacking.
- Configurable attack cooldowns and patterns.
- Interaction with environmental hazards or platforms.

### 3. Customizable Parameters:

- Patrol points, movement speed, detection range, attack range, etc.

### 4. Reusability:

- Easily extendable for new behaviors (e.g., flying enemies, boss fights).

---

## 1. Enemy AI Class Structure

### Header File (EnemyAI.h)

```cpp
#ifndef ENEMY_AI_H
#define ENEMY_AI_H

#include <godot_cpp/classes/character_body2d.hpp>
#include <godot_cpp/classes/input.hpp>
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

class EnemyAI : public CharacterBody2D {
    GDCLASS(EnemyAI, CharacterBody2D);

private:
    // Enemy States
    enum State {
        IDLE,
        PATROLLING,
        CHASING,
        ATTACKING,
        RETREATING
    };

    State current_state; // Current state of the enemy

    // Movement Variables
    float speed;            // Movement speed
    float patrol_range;     // Distance for patrolling
    float detection_range;  // Range to detect the player
    float attack_range;     // Range to attack the player
    float retreat_threshold; // Health threshold to retreat

    Vector2 start_position; // Initial position for patrolling
    Vector2 patrol_target;  // Current patrol target

    // Attack Variables
    bool can_attack;        // Whether the enemy can attack
    float attack_cooldown;  // Time between attacks
    float attack_timer;     // Tracks cooldown time

    // Player Reference
    Node2D* player;         // Reference to the player node

    // Health
    float health;

public:
    // Initialization
    void _init();

    // Main Processing
    void _process(float delta);
    void _physics_process(float delta);

    // State Handling
    void switch_state(State new_state);
    void handle_idle(float delta);
    void handle_patrolling(float delta);
    void handle_chasing(float delta);
    void handle_attacking(float delta);
    void handle_retreating(float delta);

    // Helper Functions
    bool is_player_in_range(float range);
    void take_damage(float damage);
};

#endif // ENEMY_AI_H
```

---

## 2. Enemy AI Logic

### Implementation File (EnemyAI.cpp)

```cpp
#include "EnemyAI.h"

// Initialization
void EnemyAI::_init() {
    current_state = IDLE; // Start in idle state

    // Movement
    speed = 100.0f;
    patrol_range = 200.0f;
    detection_range = 300.0f;
    attack_range = 50.0f;
    retreat_threshold = 20.0f; // Retreat if health drops below this

    start_position = get_position();
    patrol_target = start_position + Vector2(patrol_range, 0);

    // Attacking
    can_attack = true;
    attack_cooldown = 1.5f; // 1.5 seconds between attacks
    attack_timer = 0.0f;

    health = 100.0f; // Initial health
}

// Main Processing
void EnemyAI::_process(float delta) {
    // Handle attack cooldown
    if (!can_attack) {
        attack_timer -= delta;
        if (attack_timer <= 0) {
            can_attack = true;
        }
    }
}

void EnemyAI::_physics_process(float delta) {
    // State-specific behavior
    switch (current_state) {
        case IDLE: handle_idle(delta); break;
        case PATROLLING: handle_patrolling(delta); break;
        case CHASING: handle_chasing(delta); break;
        case ATTACKING: handle_attacking(delta); break;
        case RETREATING: handle_retreating(delta); break;
    }
}

// State Handling
void EnemyAI::switch_state(State new_state) {
    current_state = new_state;
}

void EnemyAI::handle_idle(float delta) {
    // Transition to patrolling after a short delay (example logic)
    if (is_player_in_range(detection_range)) {
        switch_state(CHASING);
    }
}

void EnemyAI::handle_patrolling(float delta) {
    Vector2 current_position = get_position();
    Vector2 direction = (patrol_target - current_position).normalized();

    // Move towards the patrol target
    velocity = direction * speed;
    velocity = move_and_slide(velocity);

    // Switch direction if close to the patrol target
    if (current_position.distance_to(patrol_target) < 5.0f) {
        patrol_target = (patrol_target == start_position) ? start_position + Vector2(patrol_range, 0) : start_position;
    }

    // Detect player
    if (is_player_in_range(detection_range)) {
        switch_state(CHASING);
    }
}

void EnemyAI::handle_chasing(float delta) {
    if (!player) return;

    Vector2 player_position = player->get_position();
    Vector2 direction = (player_position - get_position()).normalized();

    // Move towards the player
    velocity = direction * speed;
    velocity = move_and_slide(velocity);

    // Check for attack range
    if (is_player_in_range(attack_range)) {
        switch_state(ATTACKING);
    }
}

void EnemyAI::handle_attacking(float delta) {
    if (can_attack) {
        // Attack logic (e.g., reduce player health)
        can_attack = false;
        attack_timer = attack_cooldown;
        // Example: Damage the player
        Godot::print("Enemy attacks!");

        // Return to chasing after attacking
        switch_state(CHASING);
    }
}

void EnemyAI::handle_retreating(float delta) {
    // Retreat towards the start position
    Vector2 direction = (start_position - get_position()).normalized();
    velocity = direction * speed;
    velocity = move_and_slide(velocity);

    // Stop retreating if health regenerates or player is far
    if (health > retreat_threshold && !is_player_in_range(detection_range)) {
        switch_state(IDLE);
    }
}

// Helper Functions
bool EnemyAI::is_player_in_range(float range) {
    if (!player) return false;
    return get_position().distance_to(player->get_position()) <= range;
}

void EnemyAI::take_damage(float damage) {
    health -= damage;
    if (health <= 0) {
        queue_free(); // Destroy the enemy when health is depleted
    } else if (health < retreat_threshold) {
        switch_state(RETREATING);
    }
}
```

---

## 3. Integration in Godot

### Setup in Godot

1. **Attach the AI Script**:

Compile the C++ code as a GDNative library and attach it to a `KinematicBody2D` node for the enemy.

2. **Configure Input Parameters**:

Expose parameters like `speed`, `detection_range`, and `attack_range` to the Godot editor for easy tweaking.

```cpp
GODOT_PROPERTY(speed, Variant::REAL);
GODOT_PROPERTY(detection_range, Variant::REAL);
```

3. **Set Up Player Reference**:

Assign the player node to the `player` variable in the Godot editor or dynamically find the player node in `_ready()`:

```cpp
player = get_node<Node2D>("/root/Player");
```

4. **Input Map**:

Define input actions like `ui_left`, `ui_right`, and `ui_up` for the player to test interaction with enemies.

---

## 4. Customization

- **Extend States**:

Add new states like â€œstunnedâ€ or â€œfrozen.â€

- **Behavior Variants**:

Create child classes for unique behaviors (e.g., flying enemies or ranged attackers).

- **Environment Interactions**:

Implement logic for hazards, moving platforms, or group AI.

---
