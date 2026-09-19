Dynamic Camera System

Modular camera behavior:

Smooth follow and adjustable offsets for player tracking.

Zooming and panning for specific scenes or events.

Screen shake effect for explosions or impacts.

Dynamic Camera System

Purpose:

Smoothly follow the player.

Handle zooming in/out based on context.

Adjust view to fit specific level areas.

Class Design:

Header File (DynamicCamera.h):

#ifndef DYNAMIC_CAMERA_H

#define DYNAMIC_CAMERA_H

#include <godot_cpp/classes/camera2d.hpp>

#include <godot_cpp/classes/vector2.hpp>

using namespace godot;

class DynamicCamera : public Camera2D {

GDCLASS(DynamicCamera, Camera2D);

private:

Node2D *target;

float follow_speed;

public:

void _init();

void set_target(Node2D *target);

void set_follow_speed(float speed);

void _process(float delta);

void zoom_to(float factor, float duration);

};

#endif // DYNAMIC_CAMERA_H

Implementation File (DynamicCamera.cpp):

#include "DynamicCamera.h"

void DynamicCamera::_init() {

target = NULL;

follow_speed = 5.0f;

}

void DynamicCamera::set_target(Node2D *target) {

this->target = target;

}

void DynamicCamera::set_follow_speed(float speed) {

follow_speed = speed;

}

void DynamicCamera::_process(float delta) {

if (target) {

Vector2 target_position = target->get_position();

Vector2 current_position = get_position();

set_position(current_position.linear_interpolate(target_position,
follow_speed * delta));

}

}

void DynamicCamera::zoom_to(float factor, float duration) {

Vector2 start_zoom = get_zoom();

Vector2 end_zoom = Vector2(factor, factor);

Tween *tween = Tween::_new();

add_child(tween);

tween->interpolate_property(this, "zoom", start_zoom, end_zoom,
duration, Tween::TRANS_LINEAR, Tween::EASE_IN_OUT);

tween->start();

}
