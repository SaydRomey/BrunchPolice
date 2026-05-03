Inventory System

A class to manage player inventory:

Add, remove, and use items.

Categorize items (e.g., weapons, consumables, collectibles).

Supports crafting or upgrading items.

Inventory System implementation in C++98, designed to manage items,
weapons, power-ups, and other objects for Brunch Police or any similar
game.

---

Inventory System Design

Purpose:

Store and manage the player's inventory.

Support adding, removing, equipping, and using items.

Allow limited inventory size (optional).

Track item categories (e.g., weapons, power-ups).

---

Class Design

Header File (Inventory.h)

#ifndef INVENTORY_H

#define INVENTORY_H

#include <godot_cpp/classes/node.hpp>

#include <map>

#include <string>

#include <vector>

using namespace godot;

class Inventory : public Node {

GDCLASS(Inventory, Node);

public:

struct Item {

String name;

String type; // e.g., "weapon", "power-up", "key"

int quantity;

Item(const String &n, const String &t, int q)

: name(n), type(t), quantity(q) {}

};

private:

std::vector<Item> items; // List of all items in the inventory

size_t max_size; // Maximum inventory size (optional)

Item *equipped_main_hand; // Equipped main-hand item

Item *equipped_off_hand; // Equipped off-hand item

Item *equipped_two_hand; // Equipped two-hand item (replaces both hands)

public:

void _init();

void set_max_size(size_t size);

bool add_item(const String &name, const String &type, int quantity = 1);

bool remove_item(const String &name, int quantity = 1);

bool has_item(const String &name, int quantity = 1) const;

void equip_item(const String &name, const String &hand = "main_hand");

void use_item(const String &name);

void list_inventory() const;

};

#endif // INVENTORY_H

---

Implementation File (Inventory.cpp)

#include "Inventory.h"

void Inventory::_init() {

max_size = 10; // Default max size

equipped_main_hand = NULL;

equipped_off_hand = NULL;

equipped_two_hand = NULL;

}

void Inventory::set_max_size(size_t size) {

max_size = size;

}

bool Inventory::add_item(const String &name, const String &type, int
quantity) {

if (items.size() >= max_size) {

Godot::print("Inventory full!");

return false;

}

// Check if item already exists

for (size_t i = 0; i < items.size(); ++i) {

if (items[i].name == name) {

items[i].quantity += quantity;

return true;

}

}

// Add new item

items.push_back(Item(name, type, quantity));

return true;

}

bool Inventory::remove_item(const String &name, int quantity) {

for (size_t i = 0; i < items.size(); ++i) {

if (items[i].name == name) {

if (items[i].quantity >= quantity) {

items[i].quantity -= quantity;

if (items[i].quantity == 0) {

items.erase(items.begin() + i);

}

return true;

}

}

}

Godot::print("Item not found or insufficient quantity: " + name);

return false;

}

bool Inventory::has_item(const String &name, int quantity) const {

for (size_t i = 0; i < items.size(); ++i) {

if (items[i].name == name && items[i].quantity >= quantity) {

return true;

}

}

return false;

}

void Inventory::equip_item(const String &name, const String &hand) {

// Check if item exists

for (size_t i = 0; i < items.size(); ++i) {

if (items[i].name == name) {

if (hand == "main_hand") {

equipped_main_hand = &items[i];

Godot::print("Equipped main-hand item: " + name);

} else if (hand == "off_hand") {

equipped_off_hand = &items[i];

Godot::print("Equipped off-hand item: " + name);

} else if (hand == "two_hand") {

equipped_two_hand = &items[i];

equipped_main_hand = NULL;

equipped_off_hand = NULL;

Godot::print("Equipped two-hand item: " + name);

}

return;

}

}

Godot::print("Item not found: " + name);

}

void Inventory::use_item(const String &name) {

for (size_t i = 0; i < items.size(); ++i) {

if (items[i].name == name) {

Godot::print("Using item: " + name);

remove_item(name, 1); // Remove one use

return;

}

}

Godot::print("Item not found: " + name);

}

void Inventory::list_inventory() const {

Godot::print("Inventory:");

for (size_t i = 0; i < items.size(); ++i) {

Godot::print("- " + items[i].name + " (" + items[i].type + "): " +
String::num_int64(items[i].quantity));

}

if (equipped_main_hand) {

Godot::print("Main-Hand: " + equipped_main_hand->name);

}

if (equipped_off_hand) {

Godot::print("Off-Hand: " + equipped_off_hand->name);

}

if (equipped_two_hand) {

Godot::print("Two-Hand: " + equipped_two_hand->name);

}

}

---

Features

1. Adding Items:

Adds a new item or increases the quantity if the item already exists.

Ensures inventory size is not exceeded.

2. Removing Items:

Removes the specified quantity or deletes the item if the quantity
reaches zero.

Prints an error message if the item doesn't exist or the quantity is
insufficient.

3. Equipping Items:

Handles equipping items to the main hand, off-hand, or both hands
(two-hand).

Automatically unequips incompatible items (e.g., unequips main/off-hand
if a two-hand weapon is equipped).

4. Using Items:

Triggers logic for item use (e.g., consuming a power-up or using a
special item).

Reduces the item's quantity.

5. Inventory Listing:

Displays the current inventory and equipped items.

---

Example Usage

Ref<Inventory> inventory = get_node<Inventory>("/root/Inventory");

inventory->add_item("Fork", "weapon", 1);

inventory->add_item("Butter Knife", "weapon", 1);

inventory->add_item("Jam Jar", "power-up", 3);

inventory->equip_item("Fork", "main_hand");

inventory->equip_item("Jam Jar", "off_hand");

inventory->list_inventory();

// Use an item

inventory->use_item("Jam Jar");

inventory->list_inventory();

// Equip a two-hand item

inventory->add_item("Baguette Maul", "weapon", 1);

inventory->equip_item("Baguette Maul", "two_hand");

inventory->list_inventory();

// Remove an item

inventory->remove_item("Butter Knife", 1);

inventory->list_inventory();

---

Expandable Features

1. Categories:

Add more item types (e.g., "quest items," "armor").

Limit certain slots to specific types (e.g., only weapons in hand
slots).

2. Weight System:

Add a weight limit to the inventory for realism.

3. UI Integration:

Connect the inventory system to a UI to visually display items and
equipped slots.

4. Save/Load:

Serialize the inventory to save player progress and load it later.

---

This system is modular and flexible, allowing for a wide range of item
management mechanics while remaining easy to expand and maintain. Let me
know if you'd like additional features or specific integrations!
