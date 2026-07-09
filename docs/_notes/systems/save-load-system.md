A save/load system for your game is crucial for preserving player
progress, such as:

Collected resources (coins, keys, etc.).

Equipped items or weapons.

Level progress.

Settings (e.g., audio, difficulty).

Here's how to design and implement a save/load system in C++98 for
Brunch Police.

---

Save/Load System Design

1. Features

Save and load game progress to/from a file.

Support for multiple save slots (optional).

Save global and level-specific data.

Easy integration with existing systems (e.g., inventory, resources).

---

2. Save/Load System Implementation

SaveData Class

This class stores all game data to be serialized.

Header File (SaveData.h)

#ifndef SAVE_DATA_H

#define SAVE_DATA_H

#include <string>

#include <map>

#include <vector>

class SaveData {

public:

std::map<std::string, int> resources; // Global resources (e.g., coins,
keys)

std::vector<std::string> unlocked_levels; // List of unlocked levels

std::string equipped_main_hand; // Equipped main-hand weapon

std::string equipped_off_hand; // Equipped off-hand weapon

std::string equipped_two_hand; // Equipped two-hand weapon

SaveData();

~SaveData();

void reset(); // Resets all data to default

};

#endif // SAVE_DATA_H

Implementation File (SaveData.cpp)

#include "SaveData.h"

SaveData::SaveData() {

reset();

}

SaveData::~SaveData() {}

void SaveData::reset() {

resources.clear();

unlocked_levels.clear();

equipped_main_hand = "Fork";

equipped_off_hand = "";

equipped_two_hand = "";

}

---

SaveManager Class

Handles the actual saving and loading of SaveData.

Header File (SaveManager.h)

#ifndef SAVE_MANAGER_H

#define SAVE_MANAGER_H

#include "SaveData.h"

#include <godot_cpp/classes/file_access.hpp>

#include <string>

using namespace godot;

class SaveManager {

private:

SaveData current_save;

bool save_to_file(const std::string &file_path, const SaveData &data);

bool load_from_file(const std::string &file_path, SaveData &data);

public:

SaveManager();

~SaveManager();

void save_game(const std::string &slot_name);

void load_game(const std::string &slot_name);

SaveData &get_save_data();

};

#endif // SAVE_MANAGER_H

Implementation File (SaveManager.cpp)

#include "SaveManager.h"

SaveManager::SaveManager() {}

SaveManager::~SaveManager() {}

bool SaveManager::save_to_file(const std::string &file_path, const
SaveData &data) {

Ref<FileAccess> file = FileAccess::open(file_path.c_str(),
FileAccess::WRITE);

if (!file.is_valid()) {

Godot::print("Failed to open save file: " + String(file_path.c_str()));

return false;

}

// Write resources

for (std::map<std::string, int>::const_iterator it =
data.resources.begin(); it != data.resources.end(); ++it) {

file->store_line(it->first.c_str() + std::string("=") +
std::to_string(it->second));

}

// Write unlocked levels

file->store_line("[UnlockedLevels]");

for (size_t i = 0; i < data.unlocked_levels.size(); ++i) {

file->store_line(data.unlocked_levels[i]);

}

// Write equipped items

file->store_line("[Equipped]");

file->store_line("MainHand=" + data.equipped_main_hand);

file->store_line("OffHand=" + data.equipped_off_hand);

file->store_line("TwoHand=" + data.equipped_two_hand);

file->close();

return true;

}

bool SaveManager::load_from_file(const std::string &file_path, SaveData
&data) {

Ref<FileAccess> file = FileAccess::open(file_path.c_str(),
FileAccess::READ);

if (!file.is_valid()) {

Godot::print("Failed to open save file: " + String(file_path.c_str()));

return false;

}

data.reset();

bool is_unlocked_levels = false;

bool is_equipped = false;

while (!file->eof_reached()) {

std::string line = file->get_line().strip_edges().utf8().get_data();

if (line.empty()) continue;

if (line == "[UnlockedLevels]") {

is_unlocked_levels = true;

is_equipped = false;

} else if (line == "[Equipped]") {

is_unlocked_levels = false;

is_equipped = true;

} else if (is_unlocked_levels) {

data.unlocked_levels.push_back(line);

} else if (is_equipped) {

size_t separator = line.find("=");

if (separator != std::string::npos) {

std::string key = line.substr(0, separator);

std::string value = line.substr(separator + 1);

if (key == "MainHand") data.equipped_main_hand = value;

else if (key == "OffHand") data.equipped_off_hand = value;

else if (key == "TwoHand") data.equipped_two_hand = value;

}

} else {

size_t separator = line.find("=");

if (separator != std::string::npos) {

std::string key = line.substr(0, separator);

int value = atoi(line.substr(separator + 1).c_str());

data.resources[key] = value;

}

}

}

file->close();

return true;

}

void SaveManager::save_game(const std::string &slot_name) {

std::string file_path = "user://" + slot_name + ".save";

if (save_to_file(file_path, current_save)) {

Godot::print("Game saved successfully: " + String(file_path.c_str()));

} else {

Godot::print("Failed to save game.");

}

}

void SaveManager::load_game(const std::string &slot_name) {

std::string file_path = "user://" + slot_name + ".save";

if (load_from_file(file_path, current_save)) {

Godot::print("Game loaded successfully: " + String(file_path.c_str()));

} else {

Godot::print("Failed to load game.");

}

}

SaveData &SaveManager::get_save_data() {

return current_save;

}

---

Integration

Saving Progress

Ref<SaveManager> save_manager =
get_node<SaveManager>("/root/SaveManager");

save_manager->get_save_data().resources["coins"] = 100;

save_manager->get_save_data().unlocked_levels.push_back("Pastry
Palace");

save_manager->save_game("slot1");

Loading Progress

save_manager->load_game("slot1");

int coins = save_manager->get_save_data().resources["coins"];

Godot::print("Loaded coins: " + String::num_int64(coins));

---

Extensions

1. Multiple Save Slots

Use filenames like slot1.save, slot2.save, etc.

Create a UI for managing save slots.

2. Compression/Encryption

Compress or encrypt save files to prevent tampering.

3. Autosave System

Periodically call save_game() during gameplay.

4. Persistent Settings

Extend SaveData to include settings like volume, difficulty, or
controls.

---

Summary

This Save/Load System:

1. Saves game progress (resources, levels, equipment).

2. Loads data back into the game seamlessly.

3. Supports extensions like multiple slots, autosaves, and settings.

Let me know if you'd like additional features or a UI implementation!
