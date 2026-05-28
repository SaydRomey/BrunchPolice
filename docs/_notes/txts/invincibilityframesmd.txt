# Invincibility Frames (I-Frames)

Purpose:

- Prevent the entity from taking damage repeatedly in a short time.

- Provide visual or audio feedback (e.g., blinking or sound).

## Where to Implement?

Add I-Frames logic directly in the HealthComponent or create a separate
State System to manage states like "invincible," "stunned," etc.

## Implementation

Update the HealthComponent

```cpp

// HealthComponent.h

private:

bool is_invincible;

float invincibility_duration;

float invincibility_timer;

public:

void take_damage(float base_damage, Dictionary damage_source);

void update_invincibility(float delta);

void trigger_invincibility(float duration);

```

Implementation Example

```cpp

#include "HealthComponent.h"

void HealthComponent::take_damage(float base_damage, Dictionary
damage_source) {

if (is_invincible) {

Godot::print("Damage ignored: Entity is invincible!");

return;

}

// Apply damage

current_health -= base_damage;

// Trigger invincibility frames

trigger_invincibility(1.0f); // 1 second of I-frames

// Check for death

if (current_health <= 0) {

current_health = 0;

queue_free();

}

}

void HealthComponent::trigger_invincibility(float duration) {

is_invincible = true;

invincibility_duration = duration;

invincibility_timer = duration;

}

void HealthComponent::update_invincibility(float delta) {

if (is_invincible) {

invincibility_timer -= delta;

if (invincibility_timer <= 0) {

is_invincible = false;

}

}

}

Call update_invincibility in _process

void HealthComponent::_process(float delta) {

update_invincibility(delta);

}

```

---
