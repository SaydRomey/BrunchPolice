Visual Effects Manager

Purpose:

Centralize management of visual effects (e.g., explosions, dashes,
environmental effects like rain or smoke).

Reuse effects across different levels.

Dynamically control effect properties (e.g., size, duration).

---

Implementation

Header File (VisualEffectsManager.h)

#ifndef VISUAL_EFFECTS_MANAGER_H

#define VISUAL_EFFECTS_MANAGER_H

#include <godot_cpp/classes/node.hpp>

#include <godot_cpp/classes/particle2d.hpp>

#include <godot_cpp/classes/resource_loader.hpp>

#include <map>

#include <string>

using namespace godot;

class VisualEffectsManager : public Node {

GDCLASS(VisualEffectsManager, Node);

private:

std::map<std::string, Ref<Particle2D>> effect_templates;

public:

void _init();

void preload_effect(const String &key, const String &path);

Ref<Particle2D> create_effect(const String &key, const Vector2
&position, const Vector2 &scale = Vector2(1, 1));

void clear_effects();

};

#endif // VISUAL_EFFECTS_MANAGER_H

---

Implementation File (VisualEffectsManager.cpp)

#include "VisualEffectsManager.h"

void VisualEffectsManager::_init() {

effect_templates.clear();

}

void VisualEffectsManager::preload_effect(const String &key, const
String &path) {

Ref<Particle2D> effect = ResourceLoader::get_singleton()->load(path);

if (effect.is_valid()) {

effect_templates[key.utf8().get_data()] = effect;

Godot::print("Preloaded visual effect: " + path);

} else {

Godot::print("Failed to preload visual effect: " + path);

}

}

Ref<Particle2D> VisualEffectsManager::create_effect(const String &key,
const Vector2 &position, const Vector2 &scale) {

if (effect_templates.find(key.utf8().get_data()) !=
effect_templates.end()) {

Ref<Particle2D> effect_instance =
effect_templates[key.utf8().get_data()];

Node2D *effect_node = effect_instance->instance();

effect_node->set_position(position);

effect_node->set_scale(scale);

add_child(effect_node);

effect_instance->start(); // Trigger the effect

return effect_instance;

} else {

Godot::print("Visual effect not found: " + key);

return NULL;

}

}

void VisualEffectsManager::clear_effects() {

for (int i = get_child_count() - 1; i >= 0; --i) {

Node *child = get_child(i);

if (dynamic_cast<Particle2D *>(child)) {

remove_child(child);

child->queue_free();

}

}

Godot::print("Cleared all active visual effects.");

}

---

Usage

Setup

Add VisualEffectsManager to your scene tree as a global singleton:

Ref<VisualEffectsManager> effects_manager =
get_node<VisualEffectsManager>("/root/VisualEffectsManager");

Preload Effects

effects_manager->preload_effect("explosion",
"res://effects/explosion_particles.tres");

effects_manager->preload_effect("smoke",
"res://effects/smoke_particles.tres");

Create Effects

effects_manager->create_effect("explosion", Vector2(100, 200),
Vector2(2, 2)); // Large explosion

effects_manager->create_effect("smoke", Vector2(300, 400));

Clear Effects

effects_manager->clear_effects();

Summary

Handles particle effects like explosions, smoke, and dashes.

Modular, reusable, and easily integrated with other systems
