# Health Component

The HealthComponent handles health, damage, and death logic for all game entities (player, enemies, bosses).

Header File (HealthComponent.h)
```cpp
#ifndef HEALTH_COMPONENT_H
#define HEALTH_COMPONENT_H

#include <godot_cpp/classes/node.hpp>

using namespace godot;

class HealthComponent : public Node {
    GDCLASS(HealthComponent, Node);

private:
    float max_health;
    float current_health;

public:
    void _init();
    void _ready();

    void set_max_health(float health);
    float get_current_health() const;

    void take_damage(float damage);
    void heal(float amount);
    bool is_dead() const;
};

#endif // HEALTH_COMPONENT_H
```

Implementation File (HealthComponent.cpp)
```cpp
#include "HealthComponent.h"

void HealthComponent::_init() {
    max_health = 100.0f;
    current_health = max_health;
}

void HealthComponent::_ready() {}

void HealthComponent::set_max_health(float health) {
    max_health = health;
    current_health = max_health;
}

float HealthComponent::get_current_health() const {
    return current_health;
}

void HealthComponent::take_damage(float damage) {
    current_health -= damage;
    if (current_health <= 0) {
        current_health = 0;
        queue_free(); // Remove the node if health is 0
    }
}

void HealthComponent::heal(float amount) {
    current_health += amount;
    if (current_health > max_health) {
        current_health = max_health;
    }
}

bool HealthComponent::is_dead() const {
    return current_health <= 0;
}
```

---

