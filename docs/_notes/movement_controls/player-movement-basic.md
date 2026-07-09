2d platformer player movement module

Yes, you can implement a modular and responsive 2D platformer player
movement system in C++ for use in Godot that includes advanced mechanics
like coyote time, wall jumping, dashing, and double jumping. Here’s a
detailed plan to build this system in a reusable and modular way:

---

Design Goals

1. Modularity: The system should be customizable and easy to integrate
into any future Godot project.

2. Responsiveness: Implement mechanics that feel smooth, precise, and
responsive.

3. Scalability: Allow adding or tweaking movement features (e.g.,
adjusting jump height or adding new mechanics like grappling hooks).

4. Reusability: Write the logic as a GDNative C++ module or library to
use across multiple Godot projects.

---

Key Movement Features

1. Core Movement:

Horizontal movement with acceleration and deceleration.

Variable jump height based on how long the jump button is held.

2. Advanced Mechanics:

Coyote Time: Allow jumping briefly after leaving a platform.

Jump Buffering: Allow jumps even if the jump button was pressed slightly
before landing.

Double Jump: Enable a second jump in the air.

Wall Jumping: Jump off walls and control the angle.

Dashing: Fast movement in any direction, with a cooldown or limited air
dashes.

Ledge Grab: Automatically grab and climb ledges.

3. Customization:

Adjustable parameters (e.g., gravity, dash speed, jump height) for
different game designs.

4. Collision Handling:

Handle slopes, moving platforms, and one-way platforms.

---

Implementation Plan

1. Set Up the Player Scene

Node Structure:

Player (KinematicBody2D)

├── Sprite (for player visuals)

├── CollisionShape2D (for hitbox)

└── RayCast2D (to detect walls/ground)

2. Create a Modular C++ Class

Write a GDNative script in C++ that handles player movement.

Header File (PlayerMovement.h):

#ifndef PLAYER_MOVEMENT_H

#define PLAYER_MOVEMENT_H

#include <godot_cpp/classes/character_body2d.hpp>

#include <godot_cpp/classes/input.hpp>

#include <godot_cpp/core/class_db.hpp>

using namespace godot;

class PlayerMovement : public CharacterBody2D {

GDCLASS(PlayerMovement, CharacterBody2D);

private:

// Movement

float speed;

float acceleration;

float deceleration;

// Jumping

float jump_force;

int max_jumps;

int jumps_left;

// Coyote Time

float coyote_time;

float coyote_timer;

// Wall Jumping

bool is_on_wall;

Vector2 wall_jump_force;

// Dashing

bool can_dash;

float dash_speed;

float dash_cooldown;

float dash_timer;

// Physics

Vector2 velocity;

float gravity;

public:

void _init();

void _process(float delta);

void _physics_process(float delta);

void handle_input();

void apply_gravity(float delta);

void move_player(float delta);

void jump();

void wall_jump();

void dash();

};

#endif // PLAYER_MOVEMENT_H

---

Implementation File (PlayerMovement.cpp):

#include "PlayerMovement.h"

void PlayerMovement::_init() {

speed = 200.0f;

acceleration = 800.0f;

deceleration = 600.0f;

jump_force = -400.0f;

max_jumps = 2;

jumps_left = max_jumps;

coyote_time = 0.2f;

coyote_timer = 0.0f;

wall_jump_force = Vector2(-200.0f, -300.0f);

can_dash = true;

dash_speed = 500.0f;

dash_cooldown = 1.0f;

dash_timer = 0.0f;

gravity = 900.0f;

}

void PlayerMovement::_process(float delta) {

handle_input();

}

void PlayerMovement::_physics_process(float delta) {

apply_gravity(delta);

move_player(delta);

coyote_timer -= delta; // Update coyote time timer

dash_timer -= delta; // Update dash cooldown

}

void PlayerMovement::handle_input() {

Input *input = Input::get_singleton();

// Movement

if (input->is_action_pressed("ui_right")) {

velocity.x = speed;

} else if (input->is_action_pressed("ui_left")) {

velocity.x = -speed;

} else {

velocity.x = lerp(velocity.x, 0.0f, deceleration *
get_process_delta_time());

}

// Jumping

if (input->is_action_just_pressed("ui_up") && (is_on_floor() ||
coyote_timer > 0 || jumps_left > 0)) {

jump();

}

// Dashing

if (input->is_action_just_pressed("dash") && can_dash) {

dash();

}

}

void PlayerMovement::apply_gravity(float delta) {

if (!is_on_floor()) {

velocity.y += gravity * delta;

} else {

coyote_timer = coyote_time; // Reset coyote time

jumps_left = max_jumps; // Reset jumps on landing

}

}

void PlayerMovement::move_player(float delta) {

velocity = move_and_slide(velocity, Vector2(0, -1));

}

void PlayerMovement::jump() {

velocity.y = jump_force;

jumps_left--;

coyote_timer = 0.0f; // Disable coyote time

}

void PlayerMovement::wall_jump() {

if (is_on_wall) {

velocity = wall_jump_force;

}

}

void PlayerMovement::dash() {

Vector2 input_dir = Vector2(

Input::get_singleton()->get_axis("ui_left", "ui_right"),

Input::get_singleton()->get_axis("ui_up", "ui_down")

);

velocity = input_dir.normalized() * dash_speed;

can_dash = false;

dash_timer = dash_cooldown;

}

---

3. Integration in Godot

1. Compile and Attach:

Compile the C++ code as a GDNative shared library.

Attach the script to the Player node in Godot.

2. Configure Input Actions:

Add input actions like ui_left, ui_right, ui_up, and dash in Godot’s
Input Map.

3. Test and Tweak:

Test the movement to ensure it feels responsive.

Adjust parameters (e.g., gravity, speed, jump force) to achieve the
desired "Celeste-like" feel.

---

4. Make It Modular

Exposed Parameters:

Expose variables like speed, jump_force, and dash_speed as Godot
properties to adjust them directly in the Godot editor.

Reusability:

Encapsulate mechanics like coyote time, dashing, and wall jumping in
separate functions.

Allow toggling features (e.g., enabling/disabling double jumps).

---

5. Extend for Future Games

Once this system is complete, you can:

Export it as a reusable GDNative module.

Use it as a base class for future player controllers.

Extend it with additional mechanics (e.g., grappling hooks or air
control).

---

This approach provides a robust and modular system for advanced 2D
platformer movement, combining the power of C++ with Godot’s
flexibility. Let me know if you need help setting up GDNative or further
expanding this system!
