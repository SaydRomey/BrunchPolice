# Weapon - Bacon Gun

To implement the Bacon Gun behavior where the bacon projectile wraps an enemy and immobilizes them (with a visual change), the following updates will be made:

1. Update the BaconGun to fire bacon projectiles with this effect.


2. Update the Projectile to detect enemies and apply a "wrapped" status.


3. Add logic to the BaseEnemy to handle the immobilization and visual change.

---

**Ideas**:
- Does less damage since it can immobilize

---

## Updated Bacon Gun Implementation

```cpp
Header File (BaconGun.h)

#ifndef BACON_GUN_H
#define BACON_GUN_H

#include "Weapon.h"

class BaconGun : public Weapon {
    GDCLASS(BaconGun, Weapon);

public:
    void fire(Vector2 position, Vector2 direction) override;
};

#endif // BACON_GUN_H
```

### Implementation File (BaconGun.cpp)
```cpp
#include "BaconGun.h"

void BaconGun::fire(Vector2 position, Vector2 direction) {
    Godot::print("Bacon Gun fires!");

    // Call base class fire logic
    if (cooldown_timer <= 0 && !projectile_scene.is_null()) {
        Node2D *bacon_projectile = cast_to<Node2D>(projectile_scene->instantiate());
        if (bacon_projectile) {
            get_parent()->add_child(bacon_projectile);
            bacon_projectile->set_position(position);

            if (bacon_projectile->has_method("set_velocity")) {
                bacon_projectile->call("set_velocity", direction);
            }

            // Set custom properties if needed
            bacon_projectile->set("damage", 0.0f); // No direct damage; just immobilization
        }
        cooldown_timer = cooldown; // Reset cooldown
    }
}
```

---

## Updated Bacon Projectile

The bacon projectile now:

1. Detects enemies on collision.

2. Applies a "wrapped" status effect to immobilize the enemy.

3. Changes the enemy's visual to show the "wrapped in bacon" state.

### Header File (BaconProjectile.h)
```cpp
#ifndef BACON_PROJECTILE_H
#define BACON_PROJECTILE_H

#include "Projectile.h"

class BaconProjectile : public Projectile {
    GDCLASS(BaconProjectile, Projectile);

public:
    void on_body_entered(Node *body) override;
};

#endif // BACON_PROJECTILE_H
```

### Implementation File (BaconProjectile.cpp)
```cpp
#include "BaconProjectile.h"

void BaconProjectile::on_body_entered(Node *body) {
    if (body->has_method("apply_bacon_wrap")) {
        Godot::print("Enemy hit by bacon!");
        body->call("apply_bacon_wrap"); // Apply the wrapping effect to the enemy
    }
    queue_free(); // Destroy the projectile after collision
}
```

---

## Updates to BaseEnemy

Add logic to handle the bacon wrapping effect:

1. Immobilize the enemy.

2. Change the enemy's sprite to show the bacon wrap.

3. Set a timer to remove the effect after a duration.

### Updated Header File (BaseEnemy.h)
```cpp
#ifndef BASE_ENEMY_H
#define BASE_ENEMY_H

#include <godot_cpp/classes/character_body2d.hpp>
#include <godot_cpp/classes/timer.hpp>

using namespace godot;

class BaseEnemy : public CharacterBody2D {
    GDCLASS(BaseEnemy, CharacterBody2D);

private:
    bool is_wrapped;       // Indicates if the enemy is immobilized
    Timer *wrap_timer;     // Timer to track the duration of the wrap effect

public:
    void _init();
    void apply_bacon_wrap();
    void remove_bacon_wrap();
};

#endif // BASE_ENEMY_H
```

### Updated Implementation File (BaseEnemy.cpp)
```cpp
#include "BaseEnemy.h"

void BaseEnemy::_init() {
    is_wrapped = false;
    wrap_timer = Timer::_new();
    add_child(wrap_timer);
    wrap_timer->connect("timeout", this, "remove_bacon_wrap");
}

void BaseEnemy::apply_bacon_wrap() {
    if (!is_wrapped) {
        Godot::print("Enemy wrapped in bacon!");
        is_wrapped = true;

        // Immobilize the enemy
        velocity = Vector2(0, 0);

        // Change sprite to indicate the bacon wrap
        if (has_node("Sprite")) {
            Sprite *sprite = cast_to<Sprite>(get_node("Sprite"));
            if (sprite) {
                sprite->set_texture(ResourceLoader::get_singleton()->load("res://textures/bacon_wrap.png"));
            }
        }

        // Start the timer for the effect duration
        wrap_timer->start(5.0f); // 5 seconds duration
    }
}

void BaseEnemy::remove_bacon_wrap() {
    Godot::print("Enemy is free from the bacon wrap!");
    is_wrapped = false;

    // Restore the original sprite
    if (has_node("Sprite")) {
        Sprite *sprite = cast_to<Sprite>(get_node("Sprite"));
        if (sprite) {
            sprite->set_texture(ResourceLoader::get_singleton()->load("res://textures/original_enemy_texture.png"));
        }
    }
}
```

---

## Integration

Steps

### 1. Projectile Scene:
- Create a BaconProjectile scene (BaconProjectile.tscn).

- Add an Area2D node as the root with a CollisionShape2D and a Sprite.

- Attach the BaconProjectile script.

### 2. Enemy Sprite:
- Assign the default texture and bacon wrap texture to all enemy sprites.

- Ensure all enemies inherit from BaseEnemy and have the apply_bacon_wrap method.

### 3. Weapon Setup:
- Assign the BaconGun to the player and ensure its projectile_scene points to the BaconProjectile.

### 4. Testing:
- Fire the Bacon Gun at an enemy and verify:

- The enemy is immobilized.

- The enemy’s sprite changes to show the bacon wrap.

- The effect ends after the specified duration.

---

This system is highly modular, allowing us to:

1. Add similar effects for other projectiles.

2. Easily configure the duration and visuals of the bacon wrap.

3. Reuse the immobilization logic for other status effects.

---

