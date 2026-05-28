In-Game Resource Management

Features

Collectibles: Coins, keys, power-ups, etc., tracked globally or per
level.

Limited Resources: Track and enforce limits for health, stamina, magic,
etc.

Regeneration: Implement systems for resources that recover over time
(e.g., stamina, shield energy).

---

Class Design

---

Global Resource Manager

This tracks global resources like total coins, magic, or shared
power-ups.

Header File (GameResourceManager.h)

#ifndef GAME_RESOURCE_MANAGER_H

#define GAME_RESOURCE_MANAGER_H

#include <godot_cpp/classes/node.hpp>

#include <map>

#include <string>

using namespace godot;

class GameResourceManager : public Node {

GDCLASS(GameResourceManager, Node);

private:

std::map<String, int> resources;

std::map<String, int> resource_limits;

public:

void _init();

void set_resource_limit(const String &name, int limit);

void add_resource(const String &name, int amount);

void subtract_resource(const String &name, int amount);

int get_resource(const String &name) const;

int get_resource_limit(const String &name) const;

bool is_resource_full(const String &name) const;

bool is_resource_empty(const String &name) const;

};

#endif // GAME_RESOURCE_MANAGER_H

---

Implementation File (GameResourceManager.cpp)

#include "GameResourceManager.h"

void GameResourceManager::_init() {

resources.clear();

resource_limits.clear();

}

void GameResourceManager::set_resource_limit(const String &name, int
limit) {

resource_limits[name] = limit;

}

void GameResourceManager::add_resource(const String &name, int amount) {

if (resources.find(name) == resources.end()) {

resources[name] = 0;

}

resources[name] += amount;

// Enforce limit

if (resource_limits.find(name) != resource_limits.end() &&
resources[name] > resource_limits[name]) {

resources[name] = resource_limits[name];

}

}

void GameResourceManager::subtract_resource(const String &name, int
amount) {

if (resources.find(name) == resources.end()) {

Godot::print("Resource not found: " + name);

return;

}

resources[name] -= amount;

// Enforce minimum of 0

if (resources[name] < 0) {

resources[name] = 0;

}

}

int GameResourceManager::get_resource(const String &name) const {

std::map<String, int>::const_iterator it = resources.find(name);

return (it != resources.end()) ? it->second : 0;

}

int GameResourceManager::get_resource_limit(const String &name) const {

std::map<String, int>::const_iterator it = resource_limits.find(name);

return (it != resource_limits.end()) ? it->second : -1;

}

bool GameResourceManager::is_resource_full(const String &name) const {

return get_resource(name) == get_resource_limit(name);

}

bool GameResourceManager::is_resource_empty(const String &name) const {

return get_resource(name) == 0;

}

---

Integration

Setting Up Resources:

Ref<GameResourceManager> resource_manager =
get_node<GameResourceManager>("/root/GameResourceManager");

resource_manager->set_resource_limit("coins", 999);

resource_manager->set_resource_limit("magic", 100);

resource_manager->set_resource_limit("stamina", 50);

resource_manager->add_resource("coins", 50);

resource_manager->add_resource("magic", 30);

resource_manager->subtract_resource("magic", 10);

---

2. Collectibles

Coin Script Example (Coin.gd)

extends Area2D

func _on_body_entered(body):

if body.name == "Player":

var resource_manager = get_node("/root/GameResourceManager")

resource_manager.add_resource("coins", 1)

queue_free() # Remove the coin

---

3. Limited and Regenerating Resources

Stamina Example

Header File (Stamina.h)

#ifndef STAMINA_H

#define STAMINA_H

#include <godot_cpp/classes/node.hpp>

using namespace godot;

class Stamina : public Node {

GDCLASS(Stamina, Node);

private:

float stamina;

float max_stamina;

float regen_rate; // Regeneration per second

public:

void _init();

void _process(float delta);

void set_max_stamina(float max);

void set_regen_rate(float rate);

void use_stamina(float amount);

float get_stamina() const;

bool is_stamina_full() const;

bool is_stamina_empty() const;

};

#endif // STAMINA_H

---

Implementation File (Stamina.cpp)

#include "Stamina.h"

void Stamina::_init() {

stamina = 50;

max_stamina = 50;

regen_rate = 5; // Default 5 points per second

}

void Stamina::_process(float delta) {

if (stamina < max_stamina) {

stamina += regen_rate * delta;

if (stamina > max_stamina) {

stamina = max_stamina;

}

}

}

void Stamina::set_max_stamina(float max) {

max_stamina = max;

if (stamina > max_stamina) {

stamina = max_stamina;

}

}

void Stamina::set_regen_rate(float rate) {

regen_rate = rate;

}

void Stamina::use_stamina(float amount) {

if (stamina >= amount) {

stamina -= amount;

}

}

float Stamina::get_stamina() const {

return stamina;

}

bool Stamina::is_stamina_full() const {

return stamina == max_stamina;

}

bool Stamina::is_stamina_empty() const {

return stamina == 0;

}

---

Example Use Case

Player Actions and Stamina

void Player::jump() {

Ref<Stamina> stamina = get_node<Stamina>("/root/Stamina");

if (!stamina->is_stamina_empty()) {

stamina->use_stamina(10);

// Trigger jump logic

} else {

Godot::print("Not enough stamina to jump!");

}

}

---

Summary

Global Resource Manager

Tracks global, game-wide resources like:

Coins: Persistent across levels.

Keys: Unlock specific areas.

Power-ups: Temporary or collectible.

Stamina and Regenerating Resources

Manages per-player resources like:

Stamina: Used for actions like jumping or dashing.

Magic: Used for abilities or weapons.

Regenerates over time, with adjustable rates.

Collectibles

Simple systems for coins, keys, or power-ups.

Easily integrated with the Game Resource Manager.
