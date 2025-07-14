# Enemy - Bosses

Implementation for Boss Classes.  
Each boss has unique mechanics and behaviors, implemented modularly to make them reusable or adaptable to other projects.

---

## Base Boss Class

The Base Boss Class defines common behaviors shared by all bosses, such as health management, attack patterns, and transitions between phases.

### Header File (BaseBoss.h)
```cpp
#ifndef BASE_BOSS_H
#define BASE_BOSS_H

#include <godot_cpp/classes/character_body2d.hpp>
#include <godot_cpp/core/class_db.hpp>
#include <vector>

using namespace godot;

class BaseBoss : public CharacterBody2D {
    GDCLASS(BaseBoss, CharacterBody2D);

protected:
    float health;
    int phase;
    float attack_cooldown;
    float attack_timer;
    bool is_dead;

public:
    virtual void _init();
    virtual void _process(float delta);
    virtual void _physics_process(float delta);

    virtual void take_damage(float amount);
    virtual void handle_phase_logic(float delta);
    virtual void attack();

    bool check_is_dead();
};

#endif // BASE_BOSS_H
```

---

### Implementation File (BaseBoss.cpp)
```cpp
#include "BaseBoss.h"

void BaseBoss::_init() {
    health = 300.0f;
    phase = 1;
    attack_cooldown = 2.0f; // Default attack cooldown
    attack_timer = 0.0f;
    is_dead = false;
}

void BaseBoss::_process(float delta) {
    if (is_dead) return;

    // Handle attack cooldown
    attack_timer -= delta;
    if (attack_timer <= 0) {
        attack();
        attack_timer = attack_cooldown;
    }
}

void BaseBoss::_physics_process(float delta) {
    handle_phase_logic(delta); // Override this for specific phase logic
}

void BaseBoss::take_damage(float amount) {
    health -= amount;
    if (health <= 0) {
        is_dead = true;
        queue_free(); // Remove boss from the game
    }
}

void BaseBoss::handle_phase_logic(float delta) {
    // Override in child classes to manage phase transitions
}

void BaseBoss::attack() {
    // Default attack logic (override in child classes)
}

bool BaseBoss::check_is_dead() {
    return is_dead;
}
```

---

## Specific Boss Implementations

Each boss inherits from BaseBoss and customizes its phase logic and attacks.


---

### Barry “Bacon Bandit” Brown

Behavior:

Phase 1: Throws bacon strips as projectiles.

Phase 2: Spins into a "Bacon Tornado" that moves across the arena.


Header File (BaconBanditBoss.h)
```cpp
#ifndef BACON_BANDIT_BOSS_H
#define BACON_BANDIT_BOSS_H

#include "BaseBoss.h"

class BaconBanditBoss : public BaseBoss {
    GDCLASS(BaconBanditBoss, BaseBoss);

private:
    bool is_spinning; // Tracks whether Bacon Tornado is active

public:
    void _init();
    void handle_phase_logic(float delta);
    void attack();
    void start_bacon_tornado();
    void stop_bacon_tornado();
};

#endif // BACON_BANDIT_BOSS_H
```

Implementation File (BaconBanditBoss.cpp)
```cpp
#include "BaconBanditBoss.h"

void BaconBanditBoss::_init() {
    BaseBoss::_init();
    is_spinning = false;
}

void BaconBanditBoss::handle_phase_logic(float delta) {
    if (health <= 150.0f && phase == 1) {
        phase = 2; // Transition to phase 2
        start_bacon_tornado();
    }
}

void BaconBanditBoss::attack() {
    if (phase == 1) {
        // Phase 1: Throw bacon strips as projectiles
        Godot::print("Barry throws bacon strips!");
        // Logic to instantiate bacon projectiles goes here
    }
}

void BaconBanditBoss::start_bacon_tornado() {
    Godot::print("Barry starts the Bacon Tornado!");
    is_spinning = true;
    // Logic to start spinning and moving around the arena
}

void BaconBanditBoss::stop_bacon_tornado() {
    Godot::print("Barry stops the Bacon Tornado!");
    is_spinning = false;
    // Logic to stop spinning
}
```

---

### Clara “Croissant Crook” Cline

Behavior:

Phase 1: Throws sticky croissants that slow the player.

Phase 2: Dashes across the arena while avoiding attacks.


Header File (CroissantCrookBoss.h)
```cpp
#ifndef CROISSANT_CROOK_BOSS_H
#define CROISSANT_CROOK_BOSS_H

#include "BaseBoss.h"

class CroissantCrookBoss : public BaseBoss {
    GDCLASS(CroissantCrookBoss, BaseBoss);

private:
    bool is_dashing;

public:
    void _init();
    void handle_phase_logic(float delta);
    void attack();
    void start_dashing();
};

#endif // CROISSANT_CROOK_BOSS_H
```

Implementation File (CroissantCrookBoss.cpp)
```cpp
#include "CroissantCrookBoss.h"

void CroissantCrookBoss::_init() {
    BaseBoss::_init();
    is_dashing = false;
}

void CroissantCrookBoss::handle_phase_logic(float delta) {
    if (health <= 200.0f && phase == 1) {
        phase = 2; // Transition to phase 2
        start_dashing();
    }
}

void CroissantCrookBoss::attack() {
    if (phase == 1) {
        Godot::print("Clara throws sticky croissants!");
        // Logic to throw croissants that slow the player
    }
}

void CroissantCrookBoss::start_dashing() {
    Godot::print("Clara starts dashing around the arena!");
    is_dashing = true;
    // Logic to dash across the arena
}
```

---

### Simon “Syrup Scoundrel” Sugars

Behavior:

Phase 1: Fires syrup pools that slow the player.

Phase 2: Uses a syrup cannon to cover large areas of the arena.


Implementation Highlights

Simon’s logic follows the same pattern as Barry and Clara, with a focus on syrup-based attacks.

---

#### Simon "Syrup Scoundrel" Sugars Boss

Behavior:

1. Phase 1:  
Fires small syrup pools at the player.  
These pools slow the player if they step on them.


2. Phase 2:  
Switches to using a large syrup cannon to cover parts of the arena with syrup.  

Syrup pools persist for a few seconds before vanishing.

---

Header File (SyrupScoundrelBoss.h)
```cpp
#ifndef SYRUP_SCOUNDREL_BOSS_H
#define SYRUP_SCOUNDREL_BOSS_H

#include "BaseBoss.h"
#include <godot_cpp/classes/packed_scene.hpp>

class SyrupScoundrelBoss : public BaseBoss {
    GDCLASS(SyrupScoundrelBoss, BaseBoss);

private:
    Ref<PackedScene> syrup_pool_scene;  // Scene for syrup pools
    bool is_cannon_active;              // Tracks if the cannon is active
    float cannon_cooldown;              // Cooldown for cannon attacks
    float cannon_timer;                 // Timer for cannon cooldown

public:
    void _init();
    void _physics_process(float delta);
    void handle_phase_logic(float delta);
    void attack();
    void use_syrup_cannon();
};

#endif // SYRUP_SCOUNDREL_BOSS_H
```

---

Implementation File (SyrupScoundrelBoss.cpp)
```cpp
#include "SyrupScoundrelBoss.h"

void SyrupScoundrelBoss::_init() {
    BaseBoss::_init();
    is_cannon_active = false;
    cannon_cooldown = 5.0f;  // Syrup cannon fires every 5 seconds
    cannon_timer = 0.0f;

    // Load syrup pool scene
    syrup_pool_scene = ResourceLoader::get_singleton()->load("res://scenes/SyrupPool.tscn");
}

void SyrupScoundrelBoss::_physics_process(float delta) {
    BaseBoss::_physics_process(delta);

    // Handle cannon cooldown in phase 2
    if (is_cannon_active) {
        cannon_timer -= delta;
        if (cannon_timer <= 0) {
            use_syrup_cannon();
            cannon_timer = cannon_cooldown;
        }
    }
}

void SyrupScoundrelBoss::handle_phase_logic(float delta) {
    // Transition to phase 2 when health drops below 150
    if (health <= 150.0f && phase == 1) {
        phase = 2;
        is_cannon_active = true;
        Godot::print("Simon activates the Syrup Cannon!");
    }
}

void SyrupScoundrelBoss::attack() {
    if (phase == 1) {
        // Phase 1: Fire syrup pools at the player
        Godot::print("Simon fires small syrup pools!");

        if (!syrup_pool_scene.is_null()) {
            Node2D *syrup_pool = cast_to<Node2D>(syrup_pool_scene->instantiate());
            if (syrup_pool) {
                get_parent()->add_child(syrup_pool);
                syrup_pool->set_position(get_position()); // Drop pool at Simon's position
            }
        }
    }
}

void SyrupScoundrelBoss::use_syrup_cannon() {
    // Phase 2: Fire large syrup areas across the arena
    Godot::print("Simon uses the Syrup Cannon!");

    if (!syrup_pool_scene.is_null()) {
        for (int i = 0; i < 3; i++) {
            Node2D *large_syrup_pool = cast_to<Node2D>(syrup_pool_scene->instantiate());
            if (large_syrup_pool) {
                get_parent()->add_child(large_syrup_pool);

                // Spread syrup pools randomly across the arena
                Vector2 random_position = Vector2(
                    rand() % 400 + 100, // X-coordinate
                    rand() % 200 + 300  // Y-coordinate
                );
                large_syrup_pool->set_position(random_position);
            }
        }
    }
}
```

---

#### Syrup Pool Scene

To implement the syrup pool that the boss spawns, create a reusable scene.

Syrup Pool Scene (SyrupPool.tscn)  
1. Add a Node2D as the root node.  
2. Add a Sprite to display the syrup.  
3. Add an Area2D with a CollisionShape2D to detect when the player enters the syrup.

---

Syrup Pool Logic (SyrupPool.gd)
```gdscript
extends Area2D

# Variables for the syrup pool
var lifetime = 5.0  # Syrup pool lasts for 5 seconds
var slow_effect = 0.5  # Reduces player speed to 50%

func _ready():
    # Schedule the pool to disappear after its lifetime
    yield(get_tree().create_timer(lifetime), "timeout")
    queue_free()

func _on_body_entered(body):
    if body.name == "Player":
        body.speed *= slow_effect  # Reduce the player's speed

func _on_body_exited(body):
    if body.name == "Player":
        body.speed /= slow_effect  # Restore the player's speed
```

---

### Cutlery Thief – Carl “Cutlery Carl” Canes

Behavior:  
1. Phase 1: Throws cutlery at the player (forks, spoons, and knives).  
2. Phase 2: Hides behind piles of dishes, requiring the player to break them before attacking.  


Header File (CutleryThiefBoss.h)
```cpp
#ifndef CUTLERY_THIEF_BOSS_H
#define CUTLERY_THIEF_BOSS_H

#include "BaseBoss.h"
#include <godot_cpp/classes/packed_scene.hpp>

class CutleryThiefBoss : public BaseBoss {
    GDCLASS(CutleryThiefBoss, BaseBoss);

private:
    Ref<PackedScene> cutlery_scene;
    bool hiding_behind_dishes;

public:
    void _init();
    void _physics_process(float delta);
    void handle_phase_logic(float delta);
    void attack();
    void hide();
};

#endif // CUTLERY_THIEF_BOSS_H
```

Implementation File (CutleryThiefBoss.cpp)
```cpp
#include "CutleryThiefBoss.h"

void CutleryThiefBoss::_init() {
    BaseBoss::_init();
    hiding_behind_dishes = false;

    // Load cutlery projectile scene
    cutlery_scene = ResourceLoader::get_singleton()->load("res://scenes/CutleryProjectile.tscn");
}

void CutleryThiefBoss::_physics_process(float delta) {
    BaseBoss::_physics_process(delta);

    if (hiding_behind_dishes) {
        // Logic to manage hiding or breaking dishes
    }
}

void CutleryThiefBoss::handle_phase_logic(float delta) {
    if (health <= 150.0f && phase == 1) {
        phase = 2;
        hide();
    }
}

void CutleryThiefBoss::attack() {
    if (phase == 1) {
        Godot::print("Carl throws cutlery at the player!");

        if (!cutlery_scene.is_null()) {
            Node2D *cutlery = cast_to<Node2D>(cutlery_scene->instantiate());
            if (cutlery) {
                get_parent()->add_child(cutlery);
                cutlery->set_position(get_position());
                // Add velocity to the projectile (e.g., toward the player)
            }
        }
    }
}

void CutleryThiefBoss::hide() {
    Godot::print("Carl hides behind dishes!");
    hiding_behind_dishes = true;

    // Spawn dishes as obstacles
    // Player must destroy the dishes to attack Carl
}
```

---

### Dessert Hoarder – Debbie “Dessert Hoarder” Sweet

Behavior:  
1. Phase 1: Throws explosive cupcakes at the player.  
2. Phase 2: Rides a giant rolling cake that moves across the arena. Player must trigger sprinklers to wash the cake away.  

Header File (DessertHoarderBoss.h)
```cpp
#ifndef DESSERT_HOARDER_BOSS_H
#define DESSERT_HOARDER_BOSS_H

#include "BaseBoss.h"
#include <godot_cpp/classes/packed_scene.hpp>

class DessertHoarderBoss : public BaseBoss {
    GDCLASS(DessertHoarderBoss, BaseBoss);

private:
    Ref<PackedScene> cupcake_projectile_scene;
    bool riding_cake;

public:
    void _init();
    void _physics_process(float delta);
    void handle_phase_logic(float delta);
    void attack();
    void start_riding_cake();
};

#endif // DESSERT_HOARDER_BOSS_H
```

Implementation File (DessertHoarderBoss.cpp)
```cpp
#include "DessertHoarderBoss.h"

void DessertHoarderBoss::_init() {
    BaseBoss::_init();
    riding_cake = false;

    // Load cupcake projectile scene
    cupcake_projectile_scene = ResourceLoader::get_singleton()->load("res://scenes/CupcakeProjectile.tscn");
}

void DessertHoarderBoss::_physics_process(float delta) {
    BaseBoss::_physics_process(delta);

    if (riding_cake) {
        // Logic for moving the cake across the arena
    }
}

void DessertHoarderBoss::handle_phase_logic(float delta) {
    if (health <= 200.0f && phase == 1) {
        phase = 2;
        start_riding_cake();
    }
}

void DessertHoarderBoss::attack() {
    if (phase == 1) {
        Godot::print("Debbie throws explosive cupcakes!");

        if (!cupcake_projectile_scene.is_null()) {
            Node2D *cupcake = cast_to<Node2D>(cupcake_projectile_scene->instantiate());
            if (cupcake) {
                get_parent()->add_child(cupcake);
                cupcake->set_position(get_position());
                // Add logic to make cupcake explode after a short delay
            }
        }
    }
}

void DessertHoarderBoss::start_riding_cake() {
    Godot::print("Debbie starts riding a giant rolling cake!");
    riding_cake = true;

    // Logic to spawn and control the rolling cake
}
```

---

### Omelet Overlord – Oliver “Omelet Overlord” Eggman

Behavior:  
1. Phase 1: Spawns angry chickens and egg drones.  
2. Phase 2: Uses a giant spatula to flip platforms and knock the player off.  


Header File (OmeletOverlordBoss.h)
```cpp
#ifndef OMELET_OVERLORD_BOSS_H
#define OMELET_OVERLORD_BOSS_H

#include "BaseBoss.h"
#include <godot_cpp/classes/packed_scene.hpp>

class OmeletOverlordBoss : public BaseBoss {
    GDCLASS(OmeletOverlordBoss, BaseBoss);

private:
    Ref<PackedScene> chicken_scene;  // Scene for angry chickens
    Ref<PackedScene> egg_drone_scene;  // Scene for egg drones
    bool flipping_platforms;

public:
    void _init();
    void _physics_process(float delta);
    void handle_phase_logic(float delta);
    void attack();
    void start_flipping_platforms();
};

#endif // OMELET_OVERLORD_BOSS_H
```

---

Implementation File (OmeletOverlordBoss.cpp)
```cpp
#include "OmeletOverlordBoss.h"

void OmeletOverlordBoss::_init() {
    BaseBoss::_init();
    flipping_platforms = false;

    // Load enemy scenes
    chicken_scene = ResourceLoader::get_singleton()->load("res://scenes/AngryChicken.tscn");
    egg_drone_scene = ResourceLoader::get_singleton()->load("res://scenes/EggDrone.tscn");
}

void OmeletOverlordBoss::_physics_process(float delta) {
    BaseBoss::_physics_process(delta);

    if (flipping_platforms) {
        // Logic to flip platforms
    }
}

void OmeletOverlordBoss::handle_phase_logic(float delta) {
    if (health <= 150.0f && phase == 1) {
        phase = 2;
        start_flipping_platforms();
    }
}

void OmeletOverlordBoss::attack() {
    if (phase == 1) {
        Godot::print("Oliver spawns angry chickens and egg drones!");

        // Spawn angry chickens
        if (!chicken_scene.is_null()) {
            for (int i = 0; i < 2; i++) {
                Node2D *chicken = cast_to<Node2D>(chicken_scene->instantiate());
                if (chicken) {
                    get_parent()->add_child(chicken);
                    chicken->set_position(get_position() + Vector2(rand() % 100 - 50, rand() % 50));
                }
            }
        }

        // Spawn egg drones
        if (!egg_drone_scene.is_null()) {
            Node2D *egg_drone = cast_to<Node2D>(egg_drone_scene->instantiate());
            if (egg_drone) {
                get_parent()->add_child(egg_drone);
                egg_drone->set_position(get_position() + Vector2(0, -50));
            }
        }
    }
}

void OmeletOverlordBoss::start_flipping_platforms() {
    Godot::print("Oliver starts flipping platforms with his spatula!");
    flipping_platforms = true;

    // Logic to animate platforms being flipped
}
```

---

### Juice Jacker – Julie “Juice Jacker” Squeeze

Behavior:  
1. Phase 1: Fires juice streams at the player.  
2. Phase 2: Activates soda fountains that launch the player into hazards.  


Header File (JuiceJackerBoss.h)
```cpp
#ifndef JUICE_JACKER_BOSS_H
#define JUICE_JACKER_BOSS_H

#include "BaseBoss.h"
#include <godot_cpp/classes/packed_scene.hpp>

class JuiceJackerBoss : public BaseBoss {
    GDCLASS(JuiceJackerBoss, BaseBoss);

private:
    Ref<PackedScene> juice_stream_scene;  // Scene for juice streams
    bool soda_fountains_active;

public:
    void _init();
    void _physics_process(float delta);
    void handle_phase_logic(float delta);
    void attack();
    void activate_soda_fountains();
};

#endif // JUICE_JACKER_BOSS_H
```

---

Implementation File (JuiceJackerBoss.cpp)
```cpp
#include "JuiceJackerBoss.h"

void JuiceJackerBoss::_init() {
    BaseBoss::_init();
    soda_fountains_active = false;

    // Load juice stream scene
    juice_stream_scene = ResourceLoader::get_singleton()->load("res://scenes/JuiceStream.tscn");
}

void JuiceJackerBoss::_physics_process(float delta) {
    BaseBoss::_physics_process(delta);

    if (soda_fountains_active) {
        // Logic to activate soda fountains
    }
}

void JuiceJackerBoss::handle_phase_logic(float delta) {
    if (health <= 150.0f && phase == 1) {
        phase = 2;
        activate_soda_fountains();
    }
}

void JuiceJackerBoss::attack() {
    if (phase == 1) {
        Godot::print("Julie fires juice streams at the player!");

        if (!juice_stream_scene.is_null()) {
            Node2D *juice_stream = cast_to<Node2D>(juice_stream_scene->instantiate());
            if (juice_stream) {
                get_parent()->add_child(juice_stream);
                juice_stream->set_position(get_position() + Vector2(0, -10));
            }
        }
    }
}

void JuiceJackerBoss::activate_soda_fountains() {
    Godot::print("Julie activates soda fountains!");
    soda_fountains_active = true;

    // Logic to enable soda fountains in the arena
}
```

---

### Muffin Mastermind – Marty “Muffin Mastermind” Munch

Behavior:  
1. Phase 1: Spawns explosive muffins that charge the player.  
2. Phase 2: Hides behind baking trays, requiring the player to destroy them.  


Header File (MuffinMastermindBoss.h)
```cpp
#ifndef MUFFIN_MASTERMINDBOSS_H
#define MUFFIN_MASTERMINDBOSS_H

#include "BaseBoss.h"
#include <godot_cpp/classes/packed_scene.hpp>

class MuffinMastermindBoss : public BaseBoss {
    GDCLASS(MuffinMastermindBoss, BaseBoss);

private:
    Ref<PackedScene> exploding_muffin_scene;  // Scene for explosive muffins
    bool hiding_behind_trays;

public:
    void _init();
    void _physics_process(float delta);
    void handle_phase_logic(float delta);
    void attack();
    void hide_behind_trays();
};

#endif // MUFFIN_MASTERMINDBOSS_H
```

---

Implementation File (MuffinMastermindBoss.cpp)
```cpp
#include "MuffinMastermindBoss.h"

void MuffinMastermindBoss::_init() {
    BaseBoss::_init();
    hiding_behind_trays = false;

    // Load exploding muffin scene
    exploding_muffin_scene = ResourceLoader::get_singleton()->load("res://scenes/ExplodingMuffin.tscn");
}

void MuffinMastermindBoss::_physics_process(float delta) {
    BaseBoss::_physics_process(delta);

    if (hiding_behind_trays) {
        // Logic for hiding behind baking trays
    }
}

void MuffinMastermindBoss::handle_phase_logic(float delta) {
    if (health <= 150.0f && phase == 1) {
        phase = 2;
        hide_behind_trays();
    }
}

void MuffinMastermindBoss::attack() {
    if (phase == 1) {
        Godot::print("Marty spawns explosive muffins!");

        if (!exploding_muffin_scene.is_null()) {
            Node2D *muffin = cast_to<Node2D>(exploding_muffin_scene->instantiate());
            if (muffin) {
                get_parent()->add_child(muffin);
                muffin->set_position(get_position() + Vector2(rand() % 50 - 25, 0));
            }
        }
    }
}

void MuffinMastermindBoss::hide_behind_trays() {
    Godot::print("Marty hides behind baking trays!");
    hiding_behind_trays = true;

    // Logic to spawn baking trays as obstacles
}
```

---

## Common Patterns

### Shared Features

All bosses use phases to escalate difficulty.

Each boss has unique attacks implemented in attack().


### Reusable Components

Projectile systems (CutleryProjectile, CupcakeProjectile, etc.).

Environmental hazards (e.g., syrup pools, soda fountains).


---

<details><summary>integratation steps</summary>

## Integration

### 1. Compile and Attach Scripts:

Compile each boss class as part of your GDNative library.

Attach scripts to their respective boss nodes in each level.


### 2. Configure Properties:

Adjust parameters like health, attack_cooldown, and phase_thresholds in the Godot editor.


### 3. Test Gameplay:

Ensure phase transitions, attacks, and environmental interactions work as intended.

---

## Integration Steps

### 1. Attach Boss to Scene

Add a KinematicBody2D node to represent the boss in the Sticky Syrup Swamp level.

Attach the SyrupScoundrelBoss script to this node.

Configure properties such as health and cannon_cooldown in the Godot editor.


---

### 2. Test Attack Patterns

Place the player in the arena and test:

Phase 1 attacks (small syrup pools).

Phase 2 attacks (syrup cannon covering random areas).

---

### 3. Balancing

Adjust health, attack_cooldown, and syrup_pool.lifetime for fair difficulty.

---

## Integration Steps

### 1. Compile Classes:

Build and compile BaseBoss and all specific boss classes into a GDNative library.


### 2. Attach to Boss Nodes:

Use BaconBanditBoss, CroissantCrookBoss, etc., for specific boss nodes in each level.

Set parameters like health, attack_cooldown, etc., in the Godot editor.


### 3. Test Phase Transitions:

Verify that phase transitions (e.g., tornado or dashing) trigger correctly based on health thresholds.


### 4. Connect Boss Attacks to Player:

Ensure projectiles or area attacks damage the player correctly.

</details>

---

