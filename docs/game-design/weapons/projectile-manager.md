# Projectile Manager

A class to manage projectile behaviors:
- Speed, range, and lifespan for each projectile.
- Collision detection and damage handling.

Supports various types of projectiles (e.g., bullets, rockets, magic spells).

Projectiles handle their own movement, collisions, and damage. The system supports different types of projectiles for various weapons.

---

## Projectile Base Class

Header File (Projectile.h)
```cpp
#ifndef PROJECTILE_H
#define PROJECTILE_H

#include <godot_cpp/classes/area2d.hpp>
#include <godot_cpp/classes/packed_scene.hpp>

using namespace godot;

class Projectile : public Area2D {
    GDCLASS(Projectile, Area2D);

private:
    Vector2 velocity;
    float damage;
    float speed;

public:
    void _init();
    void _ready();
    void _physics_process(float delta);

    void set_velocity(Vector2 dir);
    void set_damage(float dmg);
    void on_body_entered(Node *body);
};

#endif // PROJECTILE_H
```

Implementation File (Projectile.cpp)
```cpp
#include "Projectile.h"

void Projectile::_init() {
    damage = 10.0f;
    speed = 300.0f;
}

void Projectile::_ready() {
    connect("body_entered", this, "on_body_entered");
}

void Projectile::_physics_process(float delta) {
    Vector2 position = get_position();
    position += velocity * speed * delta;
    set_position(position);

    // Remove projectile if it goes off-screen
    if (position.x < 0 || position.x > 800 || position.y < 0 || position.y > 600) {
        queue_free();
    }
}

void Projectile::set_velocity(Vector2 dir) {
    velocity = dir.normalized();
}

void Projectile::set_damage(float dmg) {
    damage = dmg;
}

void Projectile::on_body_entered(Node *body) {
    if (body->has_method("take_damage")) {
        body->call("take_damage", damage);
    }
    queue_free(); // Destroy projectile after hitting
}
```

---
