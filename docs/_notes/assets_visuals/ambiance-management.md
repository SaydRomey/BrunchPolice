Ambiance Management

Purpose:

Handle filters and overlays for ambiance, such as fog, toxic gas, or
day/night cycles.

Dynamically control lighting (e.g., lightbulbs, flashlights, candles).

Create immersive environments with visual effects.

---

Implementation

AmbianceManager Class

Header File (AmbianceManager.h)

#ifndef AMBIANCE_MANAGER_H

#define AMBIANCE_MANAGER_H

#include <godot_cpp/classes/node.hpp>

#include <godot_cpp/classes/color_rect.hpp>

#include <godot_cpp/classes/light2d.hpp>

#include <map>

#include <string>

using namespace godot;

class AmbianceManager : public Node {

GDCLASS(AmbianceManager, Node);

private:

Ref<ColorRect> filter_overlay; // For visual filters like fog or gas

std::vector<Light2D *> light_sources; // All dynamic light sources

Color filter_color;

float filter_opacity;

public:

void _init();

void set_filter_color(const Color &color);

void set_filter_opacity(float opacity);

void apply_filter();

void add_light_source(Light2D *light);

void remove_light_source(Light2D *light);

void update_lighting();

};

#endif // AMBIANCE_MANAGER_H

---

Implementation File (AmbianceManager.cpp)

#include "AmbianceManager.h"

void AmbianceManager::_init() {

filter_overlay = ColorRect::_new();

filter_color = Color(1, 1, 1, 0); // Default: transparent

filter_opacity = 0.0f;

add_child(filter_overlay);

light_sources.clear();

}

void AmbianceManager::set_filter_color(const Color &color) {

filter_color = color;

}

void AmbianceManager::set_filter_opacity(float opacity) {

filter_opacity = opacity;

apply_filter();

}

void AmbianceManager::apply_filter() {

filter_overlay->set_color(filter_color.with_alpha(filter_opacity));

}

void AmbianceManager::add_light_source(Light2D *light) {

light_sources.push_back(light);

}

void AmbianceManager::remove_light_source(Light2D *light) {

for (size_t i = 0; i < light_sources.size(); ++i) {

if (light_sources[i] == light) {

light_sources.erase(light_sources.begin() + i);

break;

}

}

}

void AmbianceManager::update_lighting() {

for (size_t i = 0; i < light_sources.size(); ++i) {

light_sources[i]->set_enabled(true); // Enable all lights

}

}

---

Usage

Setup

Add AmbianceManager to your scene as a global singleton:

Ref<AmbianceManager> ambiance_manager =
get_node<AmbianceManager>("/root/AmbianceManager");

Apply Filters

// Fog effect

ambiance_manager->set_filter_color(Color(0.5, 0.5, 0.5, 1));

ambiance_manager->set_filter_opacity(0.7);

ambiance_manager->apply_filter();

Add Light Sources

Ref<Light2D> candle_light = Light2D::_new();

candle_light->set_texture(ResourceLoader::get_singleton()->load("res://textures/candle_light.png"));

candle_light->set_position(Vector2(200, 300));

ambiance_manager->add_light_source(candle_light);

---

3. Dynamic Day/Night Cycles

Day/night cycles are a combination of filters and light source
management.

Day/Night Implementation

float time_of_day = 0.0f; // Ranges from 0 (midnight) to 1 (midday)

void update_day_night_cycle(float delta) {

time_of_day += delta * 0.01f; // Speed of time progression

if (time_of_day > 1.0f) time_of_day = 0.0f;

Color day_color = Color(1, 1, 1); // Bright during the day

Color night_color = Color(0, 0, 0.2); // Dark during the night

ambiance_manager->set_filter_color(day_color.linear_interpolate(night_color,
time_of_day));

ambiance_manager->apply_filter();

}

Summary

Controls visual filters (fog, toxic gas, etc.).

Manages light sources dynamically (candlelight, flashlights).

Supports day/night cycles for immersive environments.
