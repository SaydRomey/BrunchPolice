# Interaction System

Modular interaction handler for:
- Inspecting objects or NPCs.
- Triggering events (e.g., opening doors, activating switches).
- Context-sensitive prompts (e.g., "Press E to talk").

Handle player interactions with NPCs, objects, or triggers.

Modular and reusable for different interaction types (e.g., accusations, pickups, dialogue).

---

## Class Design

Header File (InteractionManager.h)
```cpp
#ifndef INTERACTION_MANAGER_H
#define INTERACTION_MANAGER_H

#include <godot_cpp/classes/area2d.hpp>
#include <map>
#include <string>

using namespace godot;

class InteractionManager : public Area2D {
    GDCLASS(InteractionManager, Area2D);

private:
    std::map<String, Callable> interaction_callbacks;

public:
    void _init();
    void register_interaction(const String &key, Callable callback);
    void trigger_interaction(const String &key);
    void _on_body_entered(Node *body);
};

#endif // INTERACTION_MANAGER_H
```

Implementation File (InteractionManager.cpp)
```cpp
#include "InteractionManager.h"

void InteractionManager::_init() {
    interaction_callbacks.clear();
    connect("body_entered", this, "_on_body_entered");
}

void InteractionManager::register_interaction(const String &key, Callable callback) {
    interaction_callbacks[key] = callback;
}

void InteractionManager::trigger_interaction(const String &key) {
    if (interaction_callbacks.find(key) != interaction_callbacks.end()) {
        interaction_callbacks[key].call();
    } else {
        Godot::print("No interaction found for key: " + key);
    }
}

void InteractionManager::_on_body_entered(Node *body) {
    if (body->has_method("on_interaction")) {
        body->call("on_interaction");
    }
}
```

---

## Example Usage

NPC Script:
```gdscript
void on_interaction() {
    Godot::print("Player interacted with NPC.");
    get_node<DialogueManager>("/root/DialogueManager")->start_dialogue();
}
```

Item Pickup Script:
```gdscript
void on_interaction() {
    Godot::print("Player picked up an item.");
    queue_free(); // Remove item from the scene
}
```

Register Interactions:
```gdscript
Ref<InteractionManager> interaction_manager = get_node<InteractionManager>("/root/InteractionManager");
interaction_manager->register_interaction("npc_talk", Callable(npc_instance, "on_interaction"));
interaction_manager->register_interaction("item_pickup", Callable(item_instance, "on_interaction"));
```

---

## Integration

### NPC with Dialogue and Interaction

Scene Setup:
```
Node2D (NPC)
├── Sprite
├── CollisionShape2D (Interaction Trigger)
├── Script (NPC Script)
```

NPC Script:
```gdscript
void on_interaction() {
    get_node<DialogueManager>("/root/DialogueManager")->start_dialogue(0);
}
```

---

## Reusable Modular Triggers

Triggers can use the InteractionManager to handle specific events:  
- Starting a boss fight.
- Picking up temporary weapons.
- Activating a checkpoint.

Trigger Script:
```gdscript
void on_interaction() {
    Godot::print("Trigger activated!");
    // Custom logic (e.g., load a new scene, spawn enemies, etc.)
}
```

---
