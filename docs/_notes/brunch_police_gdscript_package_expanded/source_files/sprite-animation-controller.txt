Sprite Animation Controller

Purpose:

Manage sprite animations for various states (e.g., idle, running,
jumping).

Handle smooth transitions between states.

Adjust animation speed dynamically based on conditions (e.g., running
speed).

Reusable for any animated object (player, enemies, environment).

---

Class Design

Header File (SpriteAnimationController.h)

#ifndef SPRITE_ANIMATION_CONTROLLER_H

#define SPRITE_ANIMATION_CONTROLLER_H

#include <godot_cpp/classes/node2d.hpp>

#include <godot_cpp/classes/animated_sprite2d.hpp>

#include <map>

#include <string>

using namespace godot;

class SpriteAnimationController : public Node2D {

GDCLASS(SpriteAnimationController, Node2D);

private:

Ref<AnimatedSprite2D> sprite; // Sprite to control

std::map<std::string, String> animation_states; // State-to-animation
map

String current_state;

float animation_speed_scale;

public:

void _init();

void set_sprite(Ref<AnimatedSprite2D> sprite_node);

void add_animation_state(const std::string &state, const String
&animation_name);

void play_state(const std::string &state);

void set_animation_speed(float speed_scale);

String get_current_state() const;

};

#endif // SPRITE_ANIMATION_CONTROLLER_H

---

Implementation File (SpriteAnimationController.cpp)

#include "SpriteAnimationController.h"

void SpriteAnimationController::_init() {

sprite = NULL;

animation_speed_scale = 1.0f;

current_state = "";

animation_states.clear();

}

void SpriteAnimationController::set_sprite(Ref<AnimatedSprite2D>
sprite_node) {

sprite = sprite_node;

}

void SpriteAnimationController::add_animation_state(const std::string
&state, const String &animation_name) {

animation_states[state] = animation_name;

}

void SpriteAnimationController::play_state(const std::string &state) {

if (!sprite.is_valid()) {

Godot::print("SpriteAnimationController: Sprite node not set.");

return;

}

if (animation_states.find(state) != animation_states.end()) {

String animation_name = animation_states[state];

if (current_state != state) {

sprite->play(animation_name);

current_state = state;

}

} else {

Godot::print("Animation state not found: " + String(state.c_str()));

}

}

void SpriteAnimationController::set_animation_speed(float speed_scale) {

if (!sprite.is_valid()) {

Godot::print("SpriteAnimationController: Sprite node not set.");

return;

}

animation_speed_scale = speed_scale;

sprite->set_speed_scale(animation_speed_scale);

}

String SpriteAnimationController::get_current_state() const {

return current_state;

}

---

Features

1. Add Animation States

Maps logical states (e.g., idle, running, jumping) to sprite animations.

2. Play Animation State

Transitions the sprite to the specified state, ensuring animations don’t
restart unnecessarily.

3. Adjust Animation Speed

Allows dynamic scaling of animation speed for effects like sprinting or
slow motion.

4. Reusable Design

Works with any sprite that uses AnimatedSprite2D.

---

Usage

Setup

1. Add the SpriteAnimationController to your character or enemy node.

2. Set the AnimatedSprite2D node and map animations to states.

Initialization

Ref<SpriteAnimationController> anim_controller =
get_node<SpriteAnimationController>("/root/PlayerAnimation");

Ref<AnimatedSprite2D> player_sprite =
get_node<AnimatedSprite2D>("/root/Player/Sprite");

anim_controller->set_sprite(player_sprite);

// Add animations

anim_controller->add_animation_state("idle", "Idle");

anim_controller->add_animation_state("run", "Running");

anim_controller->add_animation_state("jump", "Jumping");

---

Playing Animations

Switch animations based on the player’s state:

void update_player_state(const String &state) {

Ref<SpriteAnimationController> anim_controller =
get_node<SpriteAnimationController>("/root/PlayerAnimation");

if (state == "idle") {

anim_controller->play_state("idle");

} else if (state == "run") {

anim_controller->play_state("run");

} else if (state == "jump") {

anim_controller->play_state("jump");

}

}

---

Adjusting Speed

Change animation speed dynamically, e.g., running faster:

float player_speed = 5.0f; // Example speed

float normalized_speed = player_speed / 10.0f; // Normalize to [0.0,
1.0]

anim_controller->set_animation_speed(normalized_speed);

---

Integration

With the Player

Integrate with player movement to update animations based on velocity:

Vector2 velocity = get_node<Vector2>("Player")->get_linear_velocity();

if (velocity.y < 0) {

anim_controller->play_state("jump");

} else if (velocity.x != 0) {

anim_controller->play_state("run");

anim_controller->set_animation_speed(abs(velocity.x) / max_speed);

} else {

anim_controller->play_state("idle");

}

With Enemies

Update animations based on enemy states:

if (enemy_state == "patrolling") {

anim_controller->play_state("run");

} else if (enemy_state == "attacking") {

anim_controller->play_state("attack");

} else {

anim_controller->play_state("idle");

}

With Environment Objects

For animated objects like rotating gears or blinking lights:

anim_controller->add_animation_state("rotate", "Rotation");

anim_controller->play_state("rotate");

anim_controller->set_animation_speed(1.5f); // Faster rotation

---

Extensions

1. Smooth Transitions

Add logic for blending between animations using a Tween node for
smoother transitions:

Ref<Tween> tween = Tween::_new();

add_child(tween);

tween->interpolate_property(sprite, "modulate:a", 0.0f, 1.0f, 0.2f);

tween->start();

2. Directional Animations

Support flipping or swapping animations based on character direction:

void set_direction(bool facing_right) {

sprite->set_flip_h(!facing_right);

}

3. Layered Animations

Combine multiple animations (e.g., a character running while holding an
item) by using multiple AnimatedSprite2D nodes for separate body parts.

---

Summary

The Sprite Animation Controller:

1. Manages animations based on logical states.

2. Adjusts animation speed dynamically.

3. Integrates seamlessly with players, enemies, and environmental
objects.

This design ensures reusability and scalability for all animated objects
in your game. Let me know if you'd like help adding advanced features or
integrating this into other systems!
