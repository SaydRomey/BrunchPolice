# Enemy AI - Specific Examples

To make the logic for regular enemies modular and clean, we will separate enemy behaviors into individual classes based on their functionality and traits.  
Bosses will also be separated into their own classes, as they involve unique behaviors and mechanics not shared with regular enemies.

Implementation ideas for regular enemies, starting with modular designs for each type of enemy:

---

## Base Enemy Class

We’ll create a reusable base class for common enemy behavior, like movement, basic attacks, and environmental interactions.  
All enemies will inherit from this class.

### Header File (BaseEnemy.h)
```cpp
#ifndef BASE_ENEMY_H
#define BASE_ENEMY_H

#include <godot_cpp/classes/character_body2d.hpp>
#include <godot_cpp/classes/input.hpp>
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

class BaseEnemy : public CharacterBody2D {
    GDCLASS(BaseEnemy, CharacterBody2D);

protected:
    float health;
    float speed;
    float damage;
    bool is_dead;

public:
    virtual void _init();
    virtual void _process(float delta);
    virtual void _physics_process(float delta);

    virtual void take_damage(float amount);
    virtual void attack();

    bool check_is_dead();
};

#endif // BASE_ENEMY_H
```

### Implementation File (BaseEnemy.cpp)
```cpp
#include "BaseEnemy.h"

void BaseEnemy::_init() {
    health = 100.0f;
    speed = 50.0f;
    damage = 10.0f;
    is_dead = false;
}

void BaseEnemy::_process(float delta) {
    // Default idle behavior
}

void BaseEnemy::_physics_process(float delta) {
    // Default physics logic (can be overridden by child classes)
}

void BaseEnemy::take_damage(float amount) {
    health -= amount;
    if (health <= 0) {
        is_dead = true;
        queue_free(); // Remove enemy from the game
    }
}

void BaseEnemy::attack() {
    // Default attack behavior (can be overridden)
}

bool BaseEnemy::check_is_dead() {
    return is_dead;
}
```

---

## Level-Specific Enemies

Each level introduces unique enemies with custom behaviors.  
We extend BaseEnemy for each specific type.

---

### Grease Canyon Enemies

#### Small Angry Pigs

Behavior: Patrol back and forth; knock the player off platforms on collision.  

Header File (SmallPig.h)
```cpp
#ifndef SMALL_PIG_H
#define SMALL_PIG_H

#include "BaseEnemy.h"

class SmallPig : public BaseEnemy {
    GDCLASS(SmallPig, BaseEnemy);

private:
    float patrol_range;
    Vector2 start_position;
    bool moving_right;

public:
    void _init();
    void _physics_process(float delta);
};

#endif // SMALL_PIG_H
```

Implementation File (SmallPig.cpp)
```cpp
#include "SmallPig.h"

void SmallPig::_init() {
    BaseEnemy::_init();
    patrol_range = 100.0f;
    start_position = get_position();
    moving_right = true;
}

void SmallPig::_physics_process(float delta) {
    Vector2 position = get_position();
    if (moving_right) {
        position.x += speed * delta;
        if (position.x > start_position.x + patrol_range) {
            moving_right = false;
        }
    } else {
        position.x -= speed * delta;
        if (position.x < start_position.x - patrol_range) {
            moving_right = true;
        }
    }
    set_position(position);
}
```

---

#### Worm-like Bacon Strips

Behavior: Move up and down ropes.


Header File (BaconWorm.h)
```cpp
#ifndef BACON_WORM_H
#define BACON_WORM_H

#include "BaseEnemy.h"

class BaconWorm : public BaseEnemy {
    GDCLASS(BaconWorm, BaseEnemy);

private:
    float rope_length;
    float speed_vertical;
    bool moving_up;

public:
    void _init();
    void _physics_process(float delta);
};

#endif // BACON_WORM_H
```

Implementation File (BaconWorm.cpp)
```cpp
#include "BaconWorm.h"

void BaconWorm::_init() {
    BaseEnemy::_init();
    rope_length = 150.0f;
    speed_vertical = 30.0f;
    moving_up = true;
}

void BaconWorm::_physics_process(float delta) {
    Vector2 position = get_position();
    if (moving_up) {
        position.y -= speed_vertical * delta;
        if (position.y < get_position().y - rope_length) {
            moving_up = false;
        }
    } else {
        position.y += speed_vertical * delta;
        if (position.y > get_position().y + rope_length) {
            moving_up = true;
        }
    }
    set_position(position);
}
```

---

#### Flying Sausage Links

Behavior: Hover above and swoop down at the player.


Header File (FlyingSausage.h)
```cpp
#ifndef FLYING_SAUSAGE_H
#define FLYING_SAUSAGE_H

#include "BaseEnemy.h"

class FlyingSausage : public BaseEnemy {
    GDCLASS(FlyingSausage, BaseEnemy);

private:
    Vector2 hover_position;
    float swoop_speed;

public:
    void _init();
    void _physics_process(float delta);
    void swoop_attack(Vector2 player_position);
};

#endif // FLYING_SAUSAGE_H
```

Implementation File (FlyingSausage.cpp)
```cpp
#include "FlyingSausage.h"

void FlyingSausage::_init() {
    BaseEnemy::_init();
    hover_position = get_position();
    swoop_speed = 150.0f;
}

void FlyingSausage::_physics_process(float delta) {
    // Hovering logic (oscillating up and down)
    Vector2 position = get_position();
    position.y = hover_position.y + 10.0f * sin(get_position().x * 0.1f);
    set_position(position);
}

void FlyingSausage::swoop_attack(Vector2 player_position) {
    Vector2 direction = (player_position - get_position()).normalized();
    velocity = direction * swoop_speed;
    move_and_slide(velocity);
}
```

---

### Reusability for Other Levels

For Croissant Crook, Syrup Scoundrel, etc., we can create additional enemy classes by inheriting `BaseEnemy` and customizing their logic.

For example:  
- Flying Eclairs can extend FlyingSausage and shoot projectiles.  
- Jelly-filled Donuts can explode on contact.

---

### Pastry Palace Enemies

#### Flying Éclairs

Behavior:  
Hover in place and periodically shoot whipped cream projectiles at the player.


Header File (FlyingEclair.h)
```cpp
#ifndef FLYING_ECLAIR_H
#define FLYING_ECLAIR_H

#include "BaseEnemy.h"
#include <godot_cpp/classes/packed_scene.hpp>

class FlyingEclair : public BaseEnemy {
    GDCLASS(FlyingEclair, BaseEnemy);

private:
    Ref<PackedScene> whipped_cream_scene;
    float attack_timer;
    float attack_cooldown;

public:
    void _init();
    void _physics_process(float delta);
    void attack();
};

#endif // FLYING_ECLAIR_H
```

Implementation File (FlyingEclair.cpp)
```
#include "FlyingEclair.h"

void FlyingEclair::_init() {
    BaseEnemy::_init();
    attack_cooldown = 2.0f;
    attack_timer = attack_cooldown;

    whipped_cream_scene = ResourceLoader::get_singleton()->load("res://scenes/WhippedCreamProjectile.tscn");
}

void FlyingEclair::_physics_process(float delta) {
    attack_timer -= delta;
    if (attack_timer <= 0) {
        attack();
        attack_timer = attack_cooldown;
    }
}

void FlyingEclair::attack() {
    Godot::print("Flying Eclair shoots whipped cream!");
    if (!whipped_cream_scene.is_null()) {
        Node2D *projectile = cast_to<Node2D>(whipped_cream_scene->instantiate());
        if (projectile) {
            get_parent()->add_child(projectile);
            projectile->set_position(get_position());
            // Add velocity to whipped cream
            projectile->set("velocity", Vector2(-200, 0)); // Example direction
        }
    }
}
```

---

#### Rolling Baguette

Behavior:  
Rolls along platforms, dealing damage on contact.


Header File (RollingBaguette.h)
```cpp
#ifndef ROLLING_BAGUETTE_H
#define ROLLING_BAGUETTE_H

#include "BaseEnemy.h"

class RollingBaguette : public BaseEnemy {
    GDCLASS(RollingBaguette, BaseEnemy);

private:
    float roll_speed;

public:
    void _init();
    void _physics_process(float delta);
};

#endif // ROLLING_BAGUETTE_H

Implementation File (RollingBaguette.cpp)

#include "RollingBaguette.h"

void RollingBaguette::_init() {
    BaseEnemy::_init();
    roll_speed = 100.0f;
}

void RollingBaguette::_physics_process(float delta) {
    Vector2 position = get_position();
    position.x -= roll_speed * delta; // Rolls left
    set_position(position);
}
```

---

#### Jelly-filled Donuts

Behavior:  
Chase the player and explode on contact.


Header File (JellyDonut.h)
```cpp
#ifndef JELLY_DONUT_H
#define JELLY_DONUT_H

#include "BaseEnemy.h"

class JellyDonut : public BaseEnemy {
    GDCLASS(JellyDonut, BaseEnemy);

public:
    void _init();
    void _physics_process(float delta);
    void explode();
};

#endif // JELLY_DONUT_H
```

Implementation File (JellyDonut.cpp)
```cpp
#include "JellyDonut.h"

void JellyDonut::_init() {
    BaseEnemy::_init();
}

void JellyDonut::_physics_process(float delta) {
    // Chase player logic (e.g., move toward the player)
    Vector2 direction = (get_node("/root/Player")->get_position() - get_position()).normalized();
    velocity = direction * speed;
    move_and_slide(velocity);
}

void JellyDonut::explode() {
    Godot::print("Jelly-filled Donut explodes!");
    queue_free(); // Destroy the donut after explosion
}
```

---

### Sticky Syrup Swamp Enemies

#### Angry Bees

Behavior:  
Buzz in circles (in a circular pattern) and attack the player when nearby (within range).  

Header File (AngryBee.h)
```cpp
#ifndef ANGRY_BEE_H
#define ANGRY_BEE_H

#include "BaseEnemy.h"

class AngryBee : public BaseEnemy {
    GDCLASS(AngryBee, BaseEnemy);

private:
    float buzz_radius;
    float buzz_speed;
    float angle;
    float detection_range;

public:
    void _init();
    void _physics_process(float delta);
    void attack();
};

#endif // ANGRY_BEE_H
```

Implementation File (AngryBee.cpp)
```cpp
#include "AngryBee.h"

void AngryBee::_init() {
    BaseEnemy::_init();
    buzz_radius = 50.0f;
    buzz_speed = 2.0f;
    detection_range = 100.0f;
    angle = 0.0f;
}

void AngryBee::_physics_process(float delta) {
    angle += buzz_speed * delta;
    Vector2 offset = Vector2(buzz_radius * cos(angle), buzz_radius * sin(angle));
    set_position(get_position() + offset * delta);

    // Check if the player is within range
    if ((get_node("/root/Player")->get_position() - get_position()).length() < detection_range) {
        attack();
    }
}

void AngryBee::attack() {
    Godot::print("Angry Bee attacks!");
    // Logic to deal damage to the player
}
```

---

#### Syrup Golems

Behavior:  
Rise from sticky syrup floors and charge at the player.  

Header File (SyrupGolem.h)
```cpp
#ifndef SYRUP_GOLEM_H
#define SYRUP_GOLEM_H

#include "BaseEnemy.h"

class SyrupGolem : public BaseEnemy {
    GDCLASS(SyrupGolem, BaseEnemy);

public:
    void _init();
    void _physics_process(float delta);
};

#endif // SYRUP_GOLEM_H
```

Implementation File (SyrupGolem.cpp)
```cpp
#include "SyrupGolem.h"

void SyrupGolem::_init() {
    BaseEnemy::_init();
}

void SyrupGolem::_physics_process(float delta) {
    // Charge logic
    Vector2 direction = (get_node("/root/Player")->get_position() - get_position()).normalized();
    velocity = direction * speed;
    move_and_slide(velocity);
}
```

---

#### Flying Butter Pats

Behavior:  
Fly across the screen, damaging the player on contact.  

Header File (FlyingButterPat.h)
```cpp
#ifndef FLYING_BUTTER_PAT_H
#define FLYING_BUTTER_PAT_H

#include "BaseEnemy.h"

class FlyingButterPat : public BaseEnemy {
    GDCLASS(FlyingButterPat, BaseEnemy);

private:
    float flight_speed;

public:
    void _init();
    void _physics_process(float delta);
};

#endif // FLYING_BUTTER_PAT_H
```

Implementation File (FlyingButterPat.cpp)
```cpp
#include "FlyingButterPat.h"

void FlyingButterPat::_init() {
    BaseEnemy::_init();
    flight_speed = 150.0f;
}

void FlyingButterPat::_physics_process(float delta) {
    Vector2 position = get_position();
    position.x -= flight_speed * delta; // Fly left
    set_position(position);
}
```

---

### Kitchen Mayhem Enemies


#### Knife-throwing Chefs

Behavior:  
Throw knives at the player in arcs.  

Header File (KnifeThrowingChef.h)
```cpp
#ifndef KNIFE_THROWING_CHEF_H
#define KNIFE_THROWING_CHEF_H

#include "BaseEnemy.h"
#include <godot_cpp/classes/packed_scene.hpp>

class KnifeThrowingChef : public BaseEnemy {
    GDCLASS(KnifeThrowingChef, BaseEnemy);

private:
    Ref<PackedScene> knife_scene;
    float attack_timer;
    float attack_cooldown;

public:
    void _init();
    void _physics_process(float delta);
    void attack();
};

#endif // KNIFE_THROWING_CHEF_H
```

Implementation File (KnifeThrowingChef.cpp)
```cpp
#include "KnifeThrowingChef.h"

void KnifeThrowingChef::_init() {
    BaseEnemy::_init();
    attack_cooldown = 2.0f;
    attack_timer = attack_cooldown;

    knife_scene = ResourceLoader::get_singleton()->load("res://scenes/KnifeProjectile.tscn");
}

void KnifeThrowingChef::_physics_process(float delta) {
    attack_timer -= delta;
    if (attack_timer <= 0) {
        attack();
        attack_timer = attack_cooldown;
    }
}

void KnifeThrowingChef::attack() {
    Godot::print("Chef throws a knife!");

    if (!knife_scene.is_null()) {
        Node2D *knife = cast_to<Node2D>(knife_scene->instantiate());
        if (knife) {
            get_parent()->add_child(knife);
            knife->set_position(get_position());
            // Add arc velocity to the knife
        }
    }
}
```

---

#### Dishwashing Sponges

Behavior:  
Jump toward the player.  

Header File (DishwashingSponge.h)
```cpp
#ifndef DISHWASHING_SPONGE_H
#define DISHWASHING_SPONGE_H

#include "BaseEnemy.h"

class DishwashingSponge : public BaseEnemy {
    GDCLASS(DishwashingSponge, BaseEnemy);

private:
    float jump_cooldown;
    float jump_timer;

public:
    void _init();
    void _physics_process(float delta);
};

#endif // DISHWASHING_SPONGE_H
```

Implementation File (DishwashingSponge.cpp)
```cpp
#include "DishwashingSponge.h"

void DishwashingSponge::_init() {
    BaseEnemy::_init();
    jump_cooldown = 2.0f;
    jump_timer = jump_cooldown;
}

void DishwashingSponge::_physics_process(float delta) {
    jump_timer -= delta;
    if (jump_timer <= 0) {
        velocity.y = -300.0f; // Jump logic
        move_and_slide(velocity);
        jump_timer = jump_cooldown;
    }
}
```

---

#### Spinning Ladles

Behavior:  
Spin in place, creating a hazard.  

Header File (SpinningLadle.h)
```cpp
#ifndef SPINNING_LADLE_H
#define SPINNING_LADLE_H

#include "BaseEnemy.h"

class SpinningLadle : public BaseEnemy {
    GDCLASS(SpinningLadle, BaseEnemy);

private:
    float spin_speed;

public:
    void _init();
    void _physics_process(float delta);
};

#endif // SPINNING_LADLE_H
```

Implementation File (SpinningLadle.cpp)
```cpp
#include "SpinningLadle.h"

void SpinningLadle::_init() {
    BaseEnemy::_init();
    spin_speed = 360.0f; // Degrees per second
}

void SpinningLadle::_physics_process(float delta) {
    set_rotation(get_rotation() + spin_speed * delta);
}
```

---

### Candy Chaos Enemies


#### Gummy Bear Brutes

Behavior:  
Charge at the player in straight lines.  

Header File (GummyBearBrute.h)
```cpp
#ifndef GUMMY_BEAR_BRUTE_H
#define GUMMY_BEAR_BRUTE_H

#include "BaseEnemy.h"

class GummyBearBrute : public BaseEnemy {
    GDCLASS(GummyBearBrute, BaseEnemy);

private:
    float detection_range;
    bool is_charging;

public:
    void _init();
    void _physics_process(float delta);
    void charge();
};

#endif // GUMMY_BEAR_BRUTE_H
```

Implementation File (GummyBearBrute.cpp)
```cpp
#include "GummyBearBrute.h"

void GummyBearBrute::_init() {
    BaseEnemy::_init();
    detection_range = 150.0f;
    is_charging = false;
}

void GummyBearBrute::_physics_process(float delta) {
    if (!is_charging && (get_node("/root/Player")->get_position() - get_position()).length() < detection_range) {
        charge();
    }
    if (is_charging) {
        velocity.x = (get_node("/root/Player")->get_position().x > get_position().x) ? speed : -speed;
        move_and_slide(velocity);
    }
}

void GummyBearBrute::charge() {
    Godot::print("Gummy Bear Brute charges!");
    is_charging = true;
}
```

---

#### Cupcake Bombs

Behavior:  
Explode into frosting on contact with the player.  

Header File (CupcakeBomb.h)
```cpp
#ifndef CUPCAKE_BOMB_H
#define CUPCAKE_BOMB_H

#include "BaseEnemy.h"

class CupcakeBomb : public BaseEnemy {
    GDCLASS(CupcakeBomb, BaseEnemy);

public:
    void _init();
    void _physics_process(float delta);
    void explode();
};

#endif // CUPCAKE_BOMB_H
```

Implementation File (CupcakeBomb.cpp)
```cpp
#include "CupcakeBomb.h"

void CupcakeBomb::_init() {
    BaseEnemy::_init();
}

void CupcakeBomb::_physics_process(float delta) {
    Vector2 direction = (get_node("/root/Player")->get_position() - get_position()).normalized();
    velocity = direction * speed;
    move_and_slide(velocity);
}

void CupcakeBomb::explode() {
    Godot::print("Cupcake Bomb explodes into frosting!");
    queue_free(); // Destroy the cupcake after explosion
}
```

---

#### Jellybean Snipers

Behavior:  
Fire candy projectiles at the player.  

Header File (JellybeanSniper.h)
```cpp
#ifndef JELLYBEAN_SNIPER_H
#define JELLYBEAN_SNIPER_H

#include "BaseEnemy.h"
#include <godot_cpp/classes/packed_scene.hpp>

class JellybeanSniper : public BaseEnemy {
    GDCLASS(JellybeanSniper, BaseEnemy);

private:
    Ref<PackedScene> jellybean_projectile_scene;
    float attack_timer;
    float attack_cooldown;

public:
    void _init();
    void _physics_process(float delta);
    void attack();
};

#endif // JELLYBEAN_SNIPER_H
```

Implementation File (JellybeanSniper.cpp)
```cpp
#include "JellybeanSniper.h"

void JellybeanSniper::_init() {
    BaseEnemy::_init();
    attack_cooldown = 3.0f;
    attack_timer = attack_cooldown;

    jellybean_projectile_scene = ResourceLoader::get_singleton()->load("res://scenes/JellybeanProjectile.tscn");
}

void JellybeanSniper::_physics_process(float delta) {
    attack_timer -= delta;
    if (attack_timer <= 0) {
        attack();
        attack_timer = attack_cooldown;
    }
}

void JellybeanSniper::attack() {
    Godot::print("Jellybean Sniper fires a candy projectile!");

    if (!jellybean_projectile_scene.is_null()) {
        Node2D *projectile = cast_to<Node2D>(jellybean_projectile_scene->instantiate());
        if (projectile) {
            get_parent()->add_child(projectile);
            projectile->set_position(get_position());
            // Add velocity to projectile
            projectile->set("velocity", Vector2(-300, 0)); // Example direction
        }
    }
}
```

---

### Egg Factory Frenzy Enemies


#### Angry Chickens

Behavior:  
Chase the player and peck.  

Header File (AngryChicken.h)
```cpp
#ifndef ANGRY_CHICKEN_H
#define ANGRY_CHICKEN_H

#include "BaseEnemy.h"

class AngryChicken : public BaseEnemy {
    GDCLASS(AngryChicken, BaseEnemy);

public:
    void _init();
    void _physics_process(float delta);
};

#endif // ANGRY_CHICKEN_H
```

Implementation File (AngryChicken.cpp)
```cpp
#include "AngryChicken.h"

void AngryChicken::_init() {
    BaseEnemy::_init();
}

void AngryChicken::_physics_process(float delta) {
    Vector2 direction = (get_node("/root/Player")->get_position() - get_position()).normalized();
    velocity = direction * speed;
    move_and_slide(velocity);
}
```

---

#### Eggshell Drones

Behavior:  
Fly above the player and drop yolk bombs.  

Header File (EggshellDrone.h)
```cpp
#ifndef EGGSHELL_DRONE_H
#define EGGSHELL_DRONE_H

#include "BaseEnemy.h"
#include <godot_cpp/classes/packed_scene.hpp>

class EggshellDrone : public BaseEnemy {
    GDCLASS(EggshellDrone, BaseEnemy);

private:
    Ref<PackedScene> yolk_bomb_scene;
    float drop_cooldown;
    float drop_timer;

public:
    void _init();
    void _physics_process(float delta);
    void drop_bomb();
};

#endif // EGGSHELL_DRONE_H
```

Implementation File (EggshellDrone.cpp)
```cpp
#include "EggshellDrone.h"

void EggshellDrone::_init() {
    BaseEnemy::_init();
    drop_cooldown = 2.5f;
    drop_timer = drop_cooldown;

    yolk_bomb_scene = ResourceLoader::get_singleton()->load("res://scenes/YolkBomb.tscn");
}

void EggshellDrone::_physics_process(float delta) {
    drop_timer -= delta;
    if (drop_timer <= 0) {
        drop_bomb();
        drop_timer = drop_cooldown;
    }
}

void EggshellDrone::drop_bomb() {
    Godot::print("Eggshell Drone drops a yolk bomb!");

    if (!yolk_bomb_scene.is_null()) {
        Node2D *bomb = cast_to<Node2D>(yolk_bomb_scene->instantiate());
        if (bomb) {
            get_parent()->add_child(bomb);
            bomb->set_position(get_position() + Vector2(0, 10)); // Drop from below the drone
        }
    }
}
```

---

#### Frying Pans

Behavior:  
Slam down on platforms.  

Header File (FryingPan.h)
```cpp
#ifndef FRYING_PAN_H
#define FRYING_PAN_H

#include "BaseEnemy.h"

class FryingPan : public BaseEnemy {
    GDCLASS(FryingPan, BaseEnemy);

private:
    float slam_timer;
    float slam_cooldown;

public:
    void _init();
    void _physics_process(float delta);
    void slam();
};

#endif // FRYING_PAN_H
```

Implementation File (FryingPan.cpp)
```cpp
#include "FryingPan.h"

void FryingPan::_init() {
    BaseEnemy::_init();
    slam_cooldown = 3.0f;
    slam_timer = slam_cooldown;
}

void FryingPan::_physics_process(float delta) {
    slam_timer -= delta;
    if (slam_timer <= 0) {
        slam();
        slam_timer = slam_cooldown;
    }
}

void FryingPan::slam() {
    Godot::print("Frying Pan slams down!");
    // Logic to deal damage to anything below
}
```

---

### Citrus Cascade Enemies


#### Squeezing Machines

Behavior:  
Shoot juice jets at the player.  

Header File (SqueezingMachine.h)
```cpp
#ifndef SQUEEZING_MACHINE_H
#define SQUEEZING_MACHINE_H

#include "BaseEnemy.h"

class SqueezingMachine : public BaseEnemy {
    GDCLASS(SqueezingMachine, BaseEnemy);

public:
    void _init();
    void _physics_process(float delta);
    void attack();
};

#endif // SQUEEZING_MACHINE_H
```

Implementation File (SqueezingMachine.cpp)
```cpp
#include "SqueezingMachine.h"

void SqueezingMachine::_init() {
    BaseEnemy::_init();
}

void SqueezingMachine::_physics_process(float delta) {
    // Periodically attack logic
}
```

--

#### Lemon Bats

Behavior:  
Swoop down to attack the player.  

Header File (LemonBat.h)
```cpp
#ifndef LEMON_BAT_H
#define LEMON_BAT_H

#include "BaseEnemy.h"

class LemonBat : public BaseEnemy {
    GDCLASS(LemonBat, BaseEnemy);

private:
    float zigzag_amplitude;
    float zigzag_speed;
    bool swooping;

public:
    void _init();
    void _physics_process(float delta);
    void swoop_attack();
};

#endif // LEMON_BAT_H
```

Implementation File (LemonBat.cpp)
```cpp
#include "LemonBat.h"

void LemonBat::_init() {
    BaseEnemy::_init();
    zigzag_amplitude = 30.0f;
    zigzag_speed = 2.0f;
    swooping = false;
}

void LemonBat::_physics_process(float delta) {
    if (!swooping) {
        // Zigzag flight pattern
        position.x += speed * delta;
        position.y += zigzag_amplitude * sin(zigzag_speed * get_position().x);
        set_position(position);

        // Detect if the player is within swooping range
        if ((get_node("/root/Player")->get_position() - get_position()).length() < 150.0f) {
            swooping = true;
        }
    } else {
        swoop_attack();
    }
}

void LemonBat::swoop_attack() {
    Vector2 player_pos = get_node("/root/Player")->get_position();
    Vector2 direction = (player_pos - get_position()).normalized();
    velocity = direction * speed * 2.0f; // Swooping is faster
    move_and_slide(velocity);

    // Reset after swooping
    if ((player_pos - get_position()).length() > 200.0f) {
        swooping = false;
    }
}
```

---

#### Orange Peel Traps

Behavior:  
Roll across platforms, creating hazards.  

Header File (OrangePeelTrap.h)
```cpp
#ifndef ORANGE_PEEL_TRAP_H
#define ORANGE_PEEL_TRAP_H

#include "BaseEnemy.h"

class OrangePeelTrap : public BaseEnemy {
    GDCLASS(OrangePeelTrap, BaseEnemy);

private:
    float roll_speed;

public:
    void _init();
    void _physics_process(float delta);
};

#endif // ORANGE_PEEL_TRAP_H
```

Implementation File (OrangePeelTrap.cpp)
```cpp
#include "OrangePeelTrap.h"

void OrangePeelTrap::_init() {
    BaseEnemy::_init();
    roll_speed = 150.0f;
}

void OrangePeelTrap::_physics_process(float delta) {
    Vector2 position = get_position();
    position.x -= roll_speed * delta; // Rolls left
    set_position(position);

    // Remove the trap when off-screen
    if (position.x < -50) {
        queue_free();
    }
}
```

---

### Bakery Bonanza Enemies


#### Flour Bag Monsters

Behavior:  
Puff flour clouds that obscure the player's vision.  

Header File (FlourBagMonster.h)
```cpp
#ifndef FLOUR_BAG_MONSTER_H
#define FLOUR_BAG_MONSTER_H

#include "BaseEnemy.h"
#include <godot_cpp/classes/packed_scene.hpp>

class FlourBagMonster : public BaseEnemy {
    GDCLASS(FlourBagMonster, BaseEnemy);

private:
    Ref<PackedScene> flour_cloud_scene;
    float puff_timer;
    float puff_cooldown;

public:
    void _init();
    void _physics_process(float delta);
    void puff_flour();
};

#endif // FLOUR_BAG_MONSTER_H
```

Implementation File (FlourBagMonster.cpp)
```cpp
#include "FlourBagMonster.h"

void FlourBagMonster::_init() {
    BaseEnemy::_init();
    puff_cooldown = 3.0f;
    puff_timer = puff_cooldown;

    flour_cloud_scene = ResourceLoader::get_singleton()->load("res://scenes/FlourCloud.tscn");
}

void FlourBagMonster::_physics_process(float delta) {
    puff_timer -= delta;
    if (puff_timer <= 0) {
        puff_flour();
        puff_timer = puff_cooldown;
    }
}

void FlourBagMonster::puff_flour() {
    Godot::print("Flour Bag Monster puffs flour!");

    if (!flour_cloud_scene.is_null()) {
        Node2D *cloud = cast_to<Node2D>(flour_cloud_scene->instantiate());
        if (cloud) {
            get_parent()->add_child(cloud);
            cloud->set_position(get_position());
        }
    }
}
```

---

#### Rolling Muffin Trays

Behavior:  
Roll across platforms.  

Header File (RollingMuffinTray.h)
```cpp
#ifndef ROLLING_MUFFIN_TRAY_H
#define ROLLING_MUFFIN_TRAY_H

#include "BaseEnemy.h"

class RollingMuffinTray : public BaseEnemy {
    GDCLASS(RollingMuffinTray, BaseEnemy);

private:
    float roll_speed;

public:
    void _init();
    void _physics_process(float delta);
};

#endif // ROLLING_MUFFIN_TRAY_H
```

Implementation File (RollingMuffinTray.cpp)
```cpp
#include "RollingMuffinTray.h"

void RollingMuffinTray::_init() {
    BaseEnemy::_init();
    roll_speed = 100.0f;
}

void RollingMuffinTray::_physics_process(float delta) {
    Vector2 position = get_position();
    position.x += roll_speed * delta; // Rolls right
    set_position(position);

    // Remove when off-screen
    if (position.x > 800) {
        queue_free();
    }
}
```

---

#### Burning Muffins

Behavior:  
Charge at the player and deal fire damage.  

Header File (BurningMuffin.h)
```cpp
#ifndef BURNING_MUFFIN_H
#define BURNING_MUFFIN_H

#include "BaseEnemy.h"

class BurningMuffin : public BaseEnemy {
    GDCLASS(BurningMuffin, BaseEnemy);

public:
    void _init();
    void _physics_process(float delta);
};

#endif // BURNING_MUFFIN_H
```

Implementation File (BurningMuffin.cpp)
```cpp
#include "BurningMuffin.h"

void BurningMuffin::_init() {
    BaseEnemy::_init();
}

void BurningMuffin::_physics_process(float delta) {
    Vector2 direction = (get_node("/root/Player")->get_position() - get_position()).normalized();
    velocity = direction * speed;
    move_and_slide(velocity);

    // Check for collision with the player
    if (is_colliding_with("Player")) {
        Godot::print("Burning Muffin hits the player with fire damage!");
        queue_free();
    }
}
```

---

<details><summary>Integration Steps</summary>

1. Attach Scripts:

Assign each script (LemonBat, OrangePeelTrap, etc.) to their respective enemy nodes in the Godot editor.


2. Set Parameters:

Adjust speed, cooldowns, and other attributes for each enemy type to balance difficulty.


3. Test Gameplay:

Ensure proper interactions, such as projectiles, puffs, and platform hazards.


Integration (also)

Steps to Use in Godot

1. Compile Classes:

Build and compile the above classes into a GDNative library.


2. Attach to Enemy Nodes:

Use SmallPig, BaconWorm, and FlyingSausage for specific enemy nodes.


3. Enemy Placement:

Place enemies in the Grease Canyon level, adjusting parameters (e.g., speed, patrol_range) in the editor.


4. Test and Debug:

Verify enemy behaviors and interactions with the player.

</details>

---

