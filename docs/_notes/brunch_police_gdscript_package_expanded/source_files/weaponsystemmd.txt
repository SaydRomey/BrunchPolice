## Weapon System

A modular class for equipping and using weapons:

- Weapon attributes: fire rate, damage, ammo capacity.

- Different weapon types (e.g., melee, ranged, area-of-effect).

- Swappable weapon functionality.

---

Weapons manage firing logic, cooldowns, and the spawning of projectiles.

Each weapon can have unique behaviors by extending the base class.

..

### Weapon Base Class

Header File (Weapon.h)

```cpp

#ifndef WEAPON_H

#define WEAPON_H

#include <godot_cpp/classes/node.hpp>

#include <godot_cpp/classes/packed_scene.hpp>

using namespace godot;

class Weapon : public Node {

GDCLASS(Weapon, Node);

protected:

Ref<PackedScene> projectile_scene;

float cooldown;

float cooldown_timer;

public:

void _init();

void _ready();

void _process(float delta);

void fire(Vector2 position, Vector2 direction);

};

#endif // WEAPON_H

```

Implementation File (Weapon.cpp)

```cpp

#include "Weapon.h"

void Weapon::_init() {

cooldown = 0.5f;

cooldown_timer = 0.0f;

}

void Weapon::_ready() {

projectile_scene =
ResourceLoader::get_singleton()->load("res://scenes/Projectile.tscn");

}

void Weapon::_process(float delta) {

if (cooldown_timer > 0) {

cooldown_timer -= delta;

}

}

void Weapon::fire(Vector2 position, Vector2 direction) {

if (cooldown_timer <= 0 && !projectile_scene.is_null()) {

Node2D *projectile = cast_to<Node2D>(projectile_scene->instantiate());

if (projectile) {

get_parent()->add_child(projectile);

projectile->set_position(position);

if (projectile->has_method("set_velocity")) {

projectile->call("set_velocity", direction);

}

}

cooldown_timer = cooldown; // Reset cooldown

}

}

```

---
