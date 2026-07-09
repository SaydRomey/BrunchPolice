# Enemy - States
Extending States in the Enemy AI System

Extending states involves adding new behaviors or actions to the enemy's state machine, allowing for more dynamic and unique enemy behaviors.   The state machine design makes it easy to implement and transition between new states while keeping the logic modular and reusable.  

---

<details><summary>See Basic State Machine</summary>

## State Machine

A reusable finite state machine (FSM) class for player or enemy behaviors:  
- Supports enemy or NPC behavior like idle, chase, attack, flee.
- Easily extensible for complex patterns (e.g., boss fight phases).  

### Header File (StateMachine.h):
```cpp
#ifndef STATE_MACHINE_H
#define STATE_MACHINE_H

#include <godot_cpp/classes/node.hpp>
#include <string>

using namespace godot;

class StateMachine : public Node {
    GDCLASS(StateMachine, Node);

private:
    String current_state;

public:
    void _init();
    void set_state(const String &state);
    String get_state() const;
};

#endif // STATE_MACHINE_H
```

### Implementation File (StateMachine.cpp):
```cpp
#include "StateMachine.h"

void StateMachine::_init() {
    current_state = "idle";
}

void StateMachine::set_state(const String &state) {
    Godot::print("State changed from " + current_state + " to " + state);
    current_state = state;
}

String StateMachine::get_state() const {
    return current_state;
}
```

</details>

---

## Core Design

An extended state machine works by adding new states and implementing the corresponding logic in the EnemyAI class.  
For each new state:
- Define the state in the enum.
- Add state-specific logic in switch_state and _physics_process.

---

## Examples of Extended States

### Stunned State

Description:  
The enemy is temporarily disabled (e.g., after being hit by a special attack or trap).  

Behavior:  
The enemy freezes in place for a short duration.  
Resumes normal behavior after the stun period.  

Implementation

We add STUNNED to the State enum in EnemyAI.h:
```cpp
enum State {
    IDLE,
    PATROLLING,
    CHASING,
    ATTACKING,
    RETREATING,
    STUNNED // New state
};
```

We modify EnemyAI.h:
```cpp
float stun_duration; // How long the enemy stays stunned
float stun_timer;    // Tracks remaining stun time
```

We add handle_stunned in EnemyAI.cpp:
```cpp
void EnemyAI::handle_stunned(float delta) {
    stun_timer -= delta;
    if (stun_timer <= 0) {
        switch_state(IDLE); // Resume normal behavior after stun
    }
}
```

We modify switch_state in EnemyAI.cpp:
```cpp
void EnemyAI::switch_state(State new_state) {
    current_state = new_state;

    // State-specific initialization
    if (new_state == STUNNED) {
        stun_timer = stun_duration; // Reset stun timer
        velocity = Vector2(0, 0);   // Stop all movement
    }
}
```

---

### Summoning State

Description:  
The enemy pauses to summon minions or traps during the fight.

Behavior:  
The enemy spawns smaller enemies or environmental hazards.  
Returns to normal behavior after summoning.  

Implementation

We add SUMMONING to the State enum:
```cpp
enum State {
    IDLE,
    PATROLLING,
    CHASING,
    ATTACKING,
    RETREATING,
    STUNNED,
    SUMMONING // New state
};
```

We add handle_summoning in EnemyAI.cpp:
```cpp
void EnemyAI::handle_summoning(float delta) {
    Godot::print("Summoning minions!");
    
    // Example: Spawn a minion
    if (!minion_scene.is_null()) {
        Node2D *minion = cast_to<Node2D>(minion_scene->instantiate());
        if (minion) {
            get_parent()->add_child(minion);
            minion->set_position(get_position());
        }
    }

    // Transition back to idle or attack state
    switch_state(IDLE);
}
```

We modify switch_state in EnemyAI.cpp:
```cpp
void EnemyAI::switch_state(State new_state) {
    current_state = new_state;

    if (new_state == SUMMONING) {
        velocity = Vector2(0, 0); // Stop moving during summoning
    }
}
```

---

### Fleeing State

Description:  
The enemy runs away when health drops below a certain threshold.

Behavior:  
The enemy moves away from the player toward a safe area or its starting position.  


Implementation

We add FLEEING to the State enum:
```cpp
enum State {
    IDLE,
    PATROLLING,
    CHASING,
    ATTACKING,
    RETREATING,
    STUNNED,
    SUMMONING,
    FLEEING // New state
};
```

We add handle_fleeing in EnemyAI.cpp:
```cpp
void EnemyAI::handle_fleeing(float delta) {
    // Run toward the starting position or a safe point
    Vector2 safe_position = start_position;
    Vector2 direction = (safe_position - get_position()).normalized();

    velocity = direction * speed;
    velocity = move_and_slide(velocity);

    // Stop fleeing when reaching the safe position
    if (get_position().distance_to(safe_position) < 10.0f) {
        switch_state(IDLE); // Resume normal behavior
    }
}
```

We trigger the FLEEING state in take_damage:
```cpp
void EnemyAI::take_damage(float damage) {
    health -= damage;
    if (health <= 0) {
        queue_free(); // Destroy the enemy
    } else if (health < retreat_threshold) {
        switch_state(FLEEING);
    }
}
```

---

### Frozen State

Description:  
The enemy is immobilized but still vulnerable (e.g., from an ice attack).

Behavior:  
The enemy cannot move or attack for a duration.

Visual effect:  
Display an "ice overlay" or frozen animation.  


Implementation

We add FROZEN to the State enum:
```cpp
enum State {
    IDLE,
    PATROLLING,
    CHASING,
    ATTACKING,
    RETREATING,
    STUNNED,
    SUMMONING,
    FLEEING,
    FROZEN // New state
};
```

We modify EnemyAI.h for frozen state logic:
```cpp
float frozen_duration; // How long the enemy stays frozen
float frozen_timer;    // Tracks frozen state duration
```

We add handle_frozen in EnemyAI.cpp:
```cpp
void EnemyAI::handle_frozen(float delta) {
    frozen_timer -= delta;
    if (frozen_timer <= 0) {
        switch_state(IDLE); // Return to normal behavior
    }
}
```

We modify switch_state in EnemyAI.cpp:
```cpp
void EnemyAI::switch_state(State new_state) {
    current_state = new_state;

    if (new_state == FROZEN) {
        frozen_timer = frozen_duration;
        velocity = Vector2(0, 0); // Stop movement
    }
}
```

---

## Benefits of Extending States

1. Modularity:  
Each state is encapsulated, making it easy to add new behaviors without affecting existing ones.  

2. Reusability: States like STUNNED or SUMMONING can be reused across multiple enemies.  

3. Customization: Each enemy can use a subset of states or modify state-specific parameters (e.g., stun duration or flee threshold).  

---

## Integration in Brunch Police

Example:  
Bacon Bandit with Stunned and Fleeing States

The Bacon Bandit enemy:  
- Fights aggressively but enters a STUNNED state when hit by a grease trail.  
- Enters a FLEEING state when its health drops below 30%.  


Example:
Croissant Crook with Summoning State

The Croissant Crook enemy:  
- Periodically enters a SUMMONING state to spawn rolling croissants as hazards.

---

