# Enemy - AI - Environment Interactions

Environment Interactions in a game involve enemies dynamically responding to the environment around them.  
This includes interaction with hazards, platforms, destructible objects, or even using environmental elements to their advantage.  

---

## Examples of Environment Interactions

### Hazard Response:  
- Enemies avoid or take damage from hazards like spikes, lava, or grease pits.  
- Some enemies may use hazards as part of their attack (e.g., luring the player into them).  

### Platform Usage:  
- Enemies navigate moving platforms or jump between static platforms.  
- Some enemies may "fall off" platforms or require logic to avoid doing so.  

### Destructible Objects:  
- Enemies can break objects (e.g., barrels, crates) to clear their path or attack the player.  

### Environment Triggers:  
- Enemies activate or deactivate environmental elements (e.g., doors, traps, or switches).  

### Dynamic Pathfinding:  
- Enemies adjust their movement to navigate around obstacles or find the shortest path to the player.  

---

## Step-by-Step Implementation

### Hazard Response

Behavior:  
Enemies take damage or die when touching specific environment hazards like spikes or lava.

#### Implementation

Header File (HazardAwareEnemyAI.h):
```cpp
#ifndef HAZARD_AWARE_ENEMY_AI_H
#define HAZARD_AWARE_ENEMY_AI_H

#include "EnemyAI.h"

class HazardAwareEnemyAI : public EnemyAI {
    GDCLASS(HazardAwareEnemyAI, EnemyAI);

public:
    void _physics_process(float delta);
    void check_hazards();
};

#endif // HAZARD_AWARE_ENEMY_AI_H
```

Implementation File (HazardAwareEnemyAI.cpp):
```cpp
#include "HazardAwareEnemyAI.h"

void HazardAwareEnemyAI::_physics_process(float delta) {
    EnemyAI::_physics_process(delta); // Call base AI logic
    check_hazards();
}

void HazardAwareEnemyAI::check_hazards() {
    // Example: Check for a hazard below the enemy
    if (is_on_floor()) {
        Node2D* hazard = get_node<Node2D>("/root/Hazard"); // Replace with actual hazard node path
        if (hazard) {
            Rect2 hazard_area = hazard->get_global_transform().get_rect();
            if (hazard_area.has_point(get_position())) {
                take_damage(9999); // Example: Instantly kill the enemy
            }
        }
    }
}
```

---

### Platform Usage

Behavior:  
Enemies follow platforms or avoid falling off them.

#### Implementation

Header File (PlatformAwareEnemyAI.h):
```cpp
#ifndef PLATFORM_AWARE_ENEMY_AI_H
#define PLATFORM_AWARE_ENEMY_AI_H

#include "EnemyAI.h"

class PlatformAwareEnemyAI : public EnemyAI {
    GDCLASS(PlatformAwareEnemyAI, EnemyAI);

public:
    void _physics_process(float delta);
    bool check_platform_edge();
};

#endif // PLATFORM_AWARE_ENEMY_AI_H
```

Implementation File (PlatformAwareEnemyAI.cpp):
```cpp
#include "PlatformAwareEnemyAI.h"

void PlatformAwareEnemyAI::_physics_process(float delta) {
    EnemyAI::_physics_process(delta); // Call base AI logic

    // Stop moving if near the platform edge
    if (check_platform_edge()) {
        velocity.x = 0;
        set_velocity(velocity);
    }
}

bool PlatformAwareEnemyAI::check_platform_edge() {
    // Example: Raycast below to detect platform edges
    RayCast2D* raycast = cast_to<RayCast2D>(get_node("RayCast2D")); // Attach a RayCast2D in the enemy scene
    return !raycast->is_colliding(); // Return true if there's no platform below
}
```

---

### Destructible Objects

Behavior:  
Enemies break destructible objects in their path (e.g., crates, barrels).

### Implementation

Header File (DestructibleAwareEnemyAI.h):
```cpp
#ifndef DESTRUCTIBLE_AWARE_ENEMY_AI_H
#define DESTRUCTIBLE_AWARE_ENEMY_AI_H

#include "EnemyAI.h"

class DestructibleAwareEnemyAI : public EnemyAI {
    GDCLASS(DestructibleAwareEnemyAI, EnemyAI);

public:
    void _physics_process(float delta);
    void interact_with_destructible();
};

#endif // DESTRUCTIBLE_AWARE_ENEMY_AI_H
```

Implementation File (DestructibleAwareEnemyAI.cpp):
```cpp
#include "DestructibleAwareEnemyAI.h"

void DestructibleAwareEnemyAI::_physics_process(float delta) {
    EnemyAI::_physics_process(delta); // Call base AI logic
    interact_with_destructible();
}

void DestructibleAwareEnemyAI::interact_with_destructible() {
    // Check for destructible objects in range
    Array bodies = get_overlapping_bodies();
    for (int i = 0; i < bodies.size(); i++) {
        Node2D* body = cast_to<Node2D>(bodies[i]);
        if (body && body->has_method("take_damage")) {
            body->call("take_damage", 10); // Deal damage to the object
        }
    }
}
```

---

### Environment Triggers

Behavior:  
Enemies can activate switches or traps in the environment.

#### Implementation

Header File (TriggerAwareEnemyAI.h):
```cpp
#ifndef TRIGGER_AWARE_ENEMY_AI_H
#define TRIGGER_AWARE_ENEMY_AI_H

#include "EnemyAI.h"

class TriggerAwareEnemyAI : public EnemyAI {
    GDCLASS(TriggerAwareEnemyAI, EnemyAI);

public:
    void activate_trigger();
};

#endif // TRIGGER_AWARE_ENEMY_AI_H
```

Implementation File (TriggerAwareEnemyAI.cpp):
```cpp
#include "TriggerAwareEnemyAI.h"

void TriggerAwareEnemyAI::activate_trigger() {
    // Example: Interact with a pressure plate or trap
    Node2D* trigger = get_node<Node2D>("/root/Trigger"); // Replace with actual trigger path
    if (trigger && trigger->has_method("activate")) {
        trigger->call("activate"); // Activate the trigger
    }
}
```

---

## Example Use in Brunch Police

### Hazard-Aware Enemies:  
Bacon Worms:  
Bacon enemies move around platforms and take damage if they fall into boiling grease pits.

### Platform-Aware Enemies:  
Croissant Crook’s Flying Eclairs:  
Flying éclairs can hover, but platform-bound versions avoid falling off edges.

### Destructible Object-Aware Enemies:  
Syrup Scoundrel’s Bees:  
Bees destroy obstacles (e.g., player barricades) in their path.

### Trigger-Aware Enemies:  
Kitchen Level Enemies:  
A "Knife-Throwing Chef" activates conveyor belts or moving hazards when reaching specific points.

---

<details><summary>Integration in Godot<\summary>

1. Attach Environment-Aware AI Classes:

Use the appropriate child class (HazardAwareEnemyAI, PlatformAwareEnemyAI, etc.) for each enemy.

Assign nodes for hazards, platforms, destructibles, and triggers in the Godot editor.



2. Scene Setup:

Add hazards (Area2D), destructible objects (StaticBody2D), and triggers (Button or Node) to the scene.



3. Test and Debug:

Use print() statements or Godot's debugger to test interactions between enemies and environment elements.

<\details>

---
