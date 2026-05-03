Power-Up Manager

Manages active power-ups, applying their effects and tracking durations.

Header File (PowerUpManager.h)

#ifndef POWER_UP_MANAGER_H

#define POWER_UP_MANAGER_H

#include <godot_cpp/classes/node.hpp>

#include <map>

#include <string>

using namespace godot;

class PowerUpManager : public Node {

GDCLASS(PowerUpManager, Node);

private:

struct PowerUp {

String name;

Callable effect;

float duration;

};

std::map<String, PowerUp> active_powerups;

public:

void _init();

void activate_powerup(String name, Callable effect, float duration);

void _process(float delta);

};

#endif // POWER_UP_MANAGER_H

Implementation File (PowerUpManager.cpp)

#include "PowerUpManager.h"

void PowerUpManager::_init() {

active_powerups.clear();

}

void PowerUpManager::activate_powerup(String name, Callable effect,
float duration) {

PowerUp powerup = {name, effect, duration};

active_powerups[name] = powerup;

// Apply the effect

effect.call();

}

void PowerUpManager::_process(float delta) {

for (std::map<String, PowerUp>::iterator it = active_powerups.begin();
it != active_powerups.end();) {

it->second.duration -= delta;

if (it->second.duration <= 0.0f) {

Godot::print("Power-up expired: " + it->second.name);

it = active_powerups.erase(it); // Remove expired power-up

} else {

++it;

}

}

}
