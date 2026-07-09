# Enemy - AI Child Classes

Child classes for unique enemy behaviors, tailored to both general use and the Brunch Police game.  
Each child class inherits from the EnemyAI base class and overrides specific behaviors or adds new features.

---

## Flying Enemy AI

Flying enemies move freely in the air, unaffected by gravity, and can hover, patrol, or chase the player.

Header File (FlyingEnemyAI.h)
```cpp
#ifndef FLYING_ENEMY_AI_H
#define FLYING_ENEMY_AI_H

#include "EnemyAI.h"

class FlyingEnemyAI : public EnemyAI {
    GDCLASS(FlyingEnemyAI, EnemyAI);

private:
    // Hover mechanics
    float hover_speed;
    float hover_amplitude;
    float hover_timer;

public:
    void _init();
    void _physics_process(float delta);

    // Hovering behavior
    void handle_hovering(float delta);
};

#endif // FLYING_ENEMY_AI_H
```

Implementation File (FlyingEnemyAI.cpp)
```cpp
#include "FlyingEnemyAI.h"

void FlyingEnemyAI::_init() {
    EnemyAI::_init(); // Call base class initialization
    hover_speed = 1.0f;
    hover_amplitude = 20.0f;
    hover_timer = 0.0f;
}

void FlyingEnemyAI::_physics_process(float delta) {
    // Call base state handling logic
    EnemyAI::_physics_process(delta);

    // Additional hover behavior
    handle_hovering(delta);
}

void FlyingEnemyAI::handle_hovering(float delta) {
    // Add vertical hovering motion
    hover_timer += hover_speed * delta;
    Vector2 hover_offset = Vector2(0, hover_amplitude * sin(hover_timer));
    set_position(get_position() + hover_offset * delta);
}
```

---

## Ranged Attacker AI

Ranged enemies stay at a safe distance from the player and attack by firing projectiles.

Header File (RangedEnemyAI.h)
```cpp
#ifndef RANGED_ENEMY_AI_H
#define RANGED_ENEMY_AI_H

#include "EnemyAI.h"
#include <godot_cpp/classes/packed_scene.hpp>

class RangedEnemyAI : public EnemyAI {
    GDCLASS(RangedEnemyAI, EnemyAI);

private:
    // Projectile settings
    Ref<PackedScene> projectile_scene;
    float projectile_speed;

public:
    void _init();
    void handle_attacking(float delta);

    // Shooting behavior
    void shoot_projectile();
};

#endif // RANGED_ENEMY_AI_H
```

Implementation File (RangedEnemyAI.cpp)
```
#include "RangedEnemyAI.h"

void RangedEnemyAI::_init() {
    EnemyAI::_init(); // Call base class initialization
    projectile_speed = 300.0f;

    // Load projectile scene
    projectile_scene = ResourceLoader::get_singleton()->load("res://scenes/Projectile.tscn");
}

void RangedEnemyAI::handle_attacking(float delta) {
    if (can_attack) {
        shoot_projectile();
        can_attack = false;
        attack_timer = attack_cooldown; // Reset attack cooldown
    }
}

void RangedEnemyAI::shoot_projectile() {
    if (projectile_scene.is_null()) {
        Godot::print("Projectile scene not loaded!");
        return;
    }

    Node2D *projectile = cast_to<Node2D>(projectile_scene->instantiate());
    if (projectile) {
        get_parent()->add_child(projectile);
        projectile->set_position(get_position());

        // Apply velocity to projectile
        Vector2 direction = (player->get_position() - get_position()).normalized();
        projectile->set("velocity", direction * projectile_speed);
    }
}
```

---

## Bacon Bandit Enemy

A Bacon Bandit enemy for the Bacon Canyon level, themed around bacon mechanics. It throws bacon strips that act as traps.

Header File (BaconBanditAI.h)
```cpp
#ifndef BACON_BANDIT_AI_H
#define BACON_BANDIT_AI_H

#include "RangedEnemyAI.h"

class BaconBanditAI : public RangedEnemyAI {
    GDCLASS(BaconBanditAI, RangedEnemyAI);

private:
    // Bacon-specific properties
    float trap_duration;

public:
    void _init();
    void shoot_bacon_trap();
};

#endif // BACON_BANDIT_AI_H
```

Implementation File (BaconBanditAI.cpp)
```cpp
#include "BaconBanditAI.h"

void BaconBanditAI::_init() {
    RangedEnemyAI::_init(); // Call parent initialization
    trap_duration = 5.0f; // Bacon traps last 5 seconds
}

void BaconBanditAI::shoot_bacon_trap() {
    if (projectile_scene.is_null()) {
        Godot::print("Bacon trap scene not loaded!");
        return;
    }

    Node2D *bacon_trap = cast_to<Node2D>(projectile_scene->instantiate());
    if (bacon_trap) {
        get_parent()->add_child(bacon_trap);
        bacon_trap->set_position(get_position());

        // Trap stays in place and vanishes after `trap_duration`
        bacon_trap->set("lifetime", trap_duration);
    }
}
```

---

## Croissant Crook Enemy

The Croissant Crook enemy moves erratically, throws sticky croissants, and creates obstacles.

Custom Behavior:  
- Moves in unpredictable directions.  
- Throws croissants that stick to platforms and slow the player.

---

## Syrup Scoundrel Enemy

The Syrup Scoundrel leaves a sticky trail behind them and slows down the player if they step on it.

Custom Behavior:  
- Moves in a zigzag pattern while leaving a syrup trail.  
- Uses an area-based slowing effect around their trail.

---

## Muffin Mastermind Enemy

The Muffin Mastermind enemy spawns minions (mini muffins) and stays at a distance.

Custom Behavior:
- Periodically spawns smaller muffin enemies.
- Uses ranged attacks to protect itself.

---

<details><summary>Integration Steps</summary>

1. Compile the Child Classes

Compile each child class as part of your GDNative library.


2. Attach AI to Enemy Nodes

Use FlyingEnemyAI for flying bacon or syrup enemies.

Use RangedEnemyAI for enemies that throw projectiles like bacon strips or croissants.

Attach BaconBanditAI, CroissantCrookAI, etc., to specific enemies in themed levels.


3. Configure Parameters

Expose key parameters (e.g., patrol range, detection range, projectile speed) to the Godot editor using property bindings:

GODOT_PROPERTY(trap_duration, Variant::REAL);

<\details>

---

