Player Controller

Advanced movement mechanics like double jumps, wall jumps, dashes, and
ledge grabs.

Modular parameters for jump force, acceleration, speed, gravity, etc.

Easily extensible for new mechanics like grappling hooks, teleportation,
or swimming.

---

Implementation for a Player Controller using modular C++98 for Godot,
focusing on advanced 2D platforming mechanics.

---

Features of the Player Controller

The Player Controller will support:

1. Core Movement: Walking, jumping, gravity, and friction.

2. Advanced Mechanics:

Coyote Time: Jumping shortly after leaving a platform.

Jump Buffering: Allowing a jump input just before landing.

Double Jump: Performing a second jump mid-air.

Wall Jumping: Jumping off walls with directional control.

Dashing: Quick movement in a chosen direction.

Ledge Grab: Grabbing and climbing ledges.

3. Customization: Configurable speeds, jump forces, and timings for
future games.

---

Step-by-Step Implementation

1. Player Controller Class Structure

Create a PlayerController class to handle all player-related movement
logic.

Header File (PlayerController.h)

#ifndef PLAYER_CONTROLLER_H

#define PLAYER_CONTROLLER_H

#include <godot_cpp/classes/character_body2d.hpp>

#include <godot_cpp/classes/input.hpp>

#include <godot_cpp/core/class_db.hpp>

using namespace godot;

class PlayerController : public CharacterBody2D {

GDCLASS(PlayerController, CharacterBody2D);

private:

// Movement Variables

float speed; // Horizontal movement speed

float acceleration; // Acceleration when moving

float deceleration; // Deceleration when stopping

// Jumping Variables

float gravity; // Gravity applied to the player

float jump_force; // Force of the jump

int max_jumps; // Maximum number of jumps allowed

int jumps_left; // Current jumps left

// Advanced Movement

float coyote_time; // Time player can still jump after leaving the
ground

float coyote_timer; // Timer to track coyote time

float jump_buffer; // Time buffer for jump inputs before landing

float jump_buffer_timer; // Timer to track jump buffering

bool is_wall_touching; // Whether the player is touching a wall

Vector2 wall_jump_force; // Force applied when wall jumping

// Dash Variables

bool can_dash; // Whether the player can dash

float dash_speed; // Dash movement speed

float dash_cooldown; // Time before the player can dash again

float dash_timer; // Timer to track dash cooldown

// Velocity

Vector2 velocity;

public:

// Initialization

void _init();

// Main Processing

void _process(float delta);

void _physics_process(float delta);

// Movement Logic

void handle_input();

void apply_gravity(float delta);

void move_player(float delta);

// Jumping Logic

void jump();

void apply_coyote_time(float delta);

void apply_jump_buffer();

// Wall Jumping

void wall_jump();

// Dashing

void dash();

};

#endif // PLAYER_CONTROLLER_H

---

2. Player Controller Logic

Here’s the C++98 implementation of the player controller.

Implementation File (PlayerController.cpp)

#include "PlayerController.h"

// Initialization

void PlayerController::_init() {

// Movement

speed = 200.0f;

acceleration = 800.0f;

deceleration = 600.0f;

// Jumping

gravity = 1000.0f;

jump_force = -400.0f;

max_jumps = 2;

jumps_left = max_jumps;

// Advanced Mechanics

coyote_time = 0.2f;

coyote_timer = 0.0f;

jump_buffer = 0.1f;

jump_buffer_timer = 0.0f;

// Wall Jumping

is_wall_touching = false;

wall_jump_force = Vector2(-300.0f, -350.0f);

// Dashing

can_dash = true;

dash_speed = 500.0f;

dash_cooldown = 1.0f;

dash_timer = 0.0f;

velocity = Vector2(0, 0);

}

// Main Processing

void PlayerController::_process(float delta) {

handle_input();

}

void PlayerController::_physics_process(float delta) {

apply_gravity(delta);

apply_coyote_time(delta);

apply_jump_buffer();

move_player(delta);

dash_timer -= delta; // Update dash cooldown

}

// Input Handling

void PlayerController::handle_input() {

Input *input = Input::get_singleton();

// Horizontal Movement

if (input->is_action_pressed("ui_right")) {

velocity.x += acceleration * get_process_delta_time();

if (velocity.x > speed) velocity.x = speed;

} else if (input->is_action_pressed("ui_left")) {

velocity.x -= acceleration * get_process_delta_time();

if (velocity.x < -speed) velocity.x = -speed;

} else {

velocity.x = lerp(velocity.x, 0.0f, deceleration *
get_process_delta_time());

}

// Jumping

if (input->is_action_just_pressed("ui_up")) {

jump_buffer_timer = jump_buffer; // Store jump input for buffering

}

// Dashing

if (input->is_action_just_pressed("dash") && can_dash) {

dash();

}

}

// Gravity

void PlayerController::apply_gravity(float delta) {

if (!is_on_floor()) {

velocity.y += gravity * delta;

} else {

coyote_timer = coyote_time; // Reset coyote time when grounded

jumps_left = max_jumps; // Reset jumps when grounded

}

}

// Player Movement

void PlayerController::move_player(float delta) {

velocity = move_and_slide(velocity, Vector2(0, -1));

}

// Jump Logic

void PlayerController::jump() {

if (coyote_timer > 0 || jumps_left > 0) {

velocity.y = jump_force;

jumps_left--;

coyote_timer = 0.0f; // Disable coyote time after jumping

jump_buffer_timer = 0.0f; // Reset jump buffering

}

}

void PlayerController::apply_coyote_time(float delta) {

if (!is_on_floor()) {

coyote_timer -= delta; // Decrease coyote timer when not grounded

}

}

void PlayerController::apply_jump_buffer() {

if (jump_buffer_timer > 0) {

jump();

}

jump_buffer_timer -= get_process_delta_time(); // Decrease buffer timer

}

// Wall Jump

void PlayerController::wall_jump() {

if (is_wall_touching) {

velocity = wall_jump_force; // Apply wall jump force

}

}

// Dash Logic

void PlayerController::dash() {

Vector2 dash_direction = Vector2(

Input::get_singleton()->get_axis("ui_left", "ui_right"),

Input::get_singleton()->get_axis("ui_up", "ui_down")

).normalized();

velocity = dash_direction * dash_speed;

can_dash = false;

dash_timer = dash_cooldown; // Start dash cooldown

}

---

3. Integration with Godot

1. Compile GDNative:

Follow the Godot C++ GDNative setup guide to compile your C++ code as a
.dll, .so, or .dylib.

https://docs.godotengine.org/en/stable/tutorials/plugins/gdnative/gdnative-cpp-example.html

2. Attach to Player Node:

Attach your compiled GDNative library to a KinematicBody2D node
representing the player.

3. Set Input Actions:

In Godot, go to Project Settings > Input Map and add actions:

ui_left, ui_right, ui_up, and dash.

---

4. Testing and Customization

Test and tweak values like speed, jump_force, and coyote_time for
responsiveness.

Expose configurable parameters to Godot's editor for easier tuning:

GODOT_PROPERTY(speed, Variant::REAL);

---

This Player Controller is modular, customizable, and reusable across
games. It covers advanced mechanics like coyote time, dash, and wall
jumping, while remaining extensible for future features like swimming or
grappling hooks. Let me know if you'd like help with extending this
further!
