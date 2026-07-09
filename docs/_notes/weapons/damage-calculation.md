# Damage Calculation
Based on Weapon Stats or Other Sources

## Where to Implement?

The Damage System can calculate damage based on:
- Weapon stats (damage value, modifiers, critical hits, etc.).
- Player or enemy attributes (e.g., defense, resistances, buffs).

---

## Implementation

Update the HealthComponent to Accept Source-Based Damage

```cpp
// HealthComponent.h
void take_damage(float base_damage, Dictionary damage_source);
```

Implementation Example
```cpp
#include "HealthComponent.h"

void HealthComponent::take_damage(float base_damage, Dictionary damage_source) {
    float final_damage = base_damage;

    // Example: Modify damage based on weapon type
    if (damage_source.has("weapon_type")) {
        String weapon_type = damage_source["weapon_type"];
        if (weapon_type == "bacon_gun") {
            final_damage *= 1.5f; // Example: Bacon Gun deals 1.5x damage
        }
    }

    // Apply damage
    current_health -= final_damage;

    // Check for death
    if (current_health <= 0) {
        current_health = 0;
        queue_free();
    }
}
```

Damage Sources Dictionary Example When firing a weapon, pass a Dictionary containing relevant attributes:
```cpp
Dictionary damage_source;
damage_source["weapon_type"] = "bacon_gun";
damage_source["critical_hit"] = true;

enemy->call("take_damage", 20.0f, damage_source);
```

---

