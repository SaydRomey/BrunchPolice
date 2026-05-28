A Level Editor System is an excellent addition for Brunch Police to
create, edit, and test levels dynamically within the game. Below is a
detailed implementation plan for building a Level Editor System in
C++98.

---

1. Goals

Features:

Tilemap Editing: Place, remove, and modify tiles on a grid.

Entity Placement: Add, move, and delete objects like enemies, pickups,
and decorations.

Save and Load Levels: Store level data in files for later use.

User-Friendly UI: Use in-game tools like buttons and selection menus.

Real-Time Testing: Switch between editing and testing modes.

---

2. System Design

The Level Editor System will include the following components:

1. Level Editor Manager

Handles the overall functionality of the editor (e.g., editing modes,
saving/loading).

2. Tilemap Editor

Manages placing and removing tiles.

3. Object Editor

Manages entity placement, movement, and deletion.

---

3. Implementation

---

Header File (LevelEditor.h)

#ifndef LEVEL_EDITOR_H

#define LEVEL_EDITOR_H

#include <godot_cpp/classes/node2d.hpp>

#include <godot_cpp/classes/tile_map.hpp>

#include <godot_cpp/classes/resource_loader.hpp>

#include <map>

#include <string>

using namespace godot;

class LevelEditor : public Node2D {

GDCLASS(LevelEditor, Node2D);

private:

Ref<TileMap> tilemap; // Main tilemap for the level

std::map<String, Ref<PackedScene>> object_templates; // Object templates

std::vector<Node2D *> placed_objects; // Placed entities

String current_tool; // Current editor tool (e.g., "tile", "enemy")

int current_tile_id; // Tile ID to place

Ref<PackedScene> current_object; // Object to place

public:

void _init();

// Tilemap editing

void set_tilemap(Ref<TileMap> tilemap_node);

void select_tile(int tile_id);

void place_tile(Vector2 position);

void remove_tile(Vector2 position);

// Object editing

void preload_object(const String &key, const String &path);

void select_object(const String &key);

void place_object(Vector2 position);

void remove_object(Vector2 position);

// Save and load

void save_level(const String &file_path);

void load_level(const String &file_path);

// UI Integration

void set_tool(const String &tool);

};

#endif // LEVEL_EDITOR_H

---

Implementation File (LevelEditor.cpp)

#include "LevelEditor.h"

void LevelEditor::_init() {

tilemap = NULL;

current_tool = "tile";

current_tile_id = -1;

current_object = NULL;

object_templates.clear();

placed_objects.clear();

}

void LevelEditor::set_tilemap(Ref<TileMap> tilemap_node) {

tilemap = tilemap_node;

}

void LevelEditor::select_tile(int tile_id) {

current_tile_id = tile_id;

current_tool = "tile";

}

void LevelEditor::place_tile(Vector2 position) {

if (!tilemap.is_valid()) {

Godot::print("Tilemap not set.");

return;

}

tilemap->set_cell(position.x, position.y, current_tile_id);

}

void LevelEditor::remove_tile(Vector2 position) {

if (!tilemap.is_valid()) {

Godot::print("Tilemap not set.");

return;

}

tilemap->set_cell(position.x, position.y, -1); // -1 for empty

}

void LevelEditor::preload_object(const String &key, const String &path)
{

Ref<PackedScene> object = ResourceLoader::get_singleton()->load(path);

if (object.is_valid()) {

object_templates[key] = object;

Godot::print("Preloaded object: " + path);

} else {

Godot::print("Failed to preload object: " + path);

}

}

void LevelEditor::select_object(const String &key) {

if (object_templates.find(key) != object_templates.end()) {

current_object = object_templates[key];

current_tool = "object";

} else {

Godot::print("Object not found: " + key);

}

}

void LevelEditor::place_object(Vector2 position) {

if (!current_object.is_valid()) {

Godot::print("No object selected.");

return;

}

Node2D *object_instance = dynamic_cast<Node2D
*>(current_object->instantiate());

if (object_instance) {

object_instance->set_position(position);

add_child(object_instance);

placed_objects.push_back(object_instance);

}

}

void LevelEditor::remove_object(Vector2 position) {

for (size_t i = 0; i < placed_objects.size(); ++i) {

Node2D *obj = placed_objects[i];

if (obj->get_position() == position) {

remove_child(obj);

obj->queue_free();

placed_objects.erase(placed_objects.begin() + i);

return;

}

}

Godot::print("No object found at position: " + String(position));

}

void LevelEditor::save_level(const String &file_path) {

Ref<FileAccess> file = FileAccess::open(file_path, FileAccess::WRITE);

if (!file.is_valid()) {

Godot::print("Failed to open file for saving: " + file_path);

return;

}

// Save tiles

file->store_line("[Tiles]");

for (int x = 0; x < tilemap->get_used_rect().size.x; ++x) {

for (int y = 0; y < tilemap->get_used_rect().size.y; ++y) {

int tile_id = tilemap->get_cell(x, y);

if (tile_id != -1) {

file->store_line(String(x) + "," + String(y) + "=" + String(tile_id));

}

}

}

// Save objects

file->store_line("[Objects]");

for (size_t i = 0; i < placed_objects.size(); ++i) {

Node2D *obj = placed_objects[i];

file->store_line(obj->get_name() + "," + String(obj->get_position().x) +
"," + String(obj->get_position().y));

}

file->close();

Godot::print("Level saved: " + file_path);

}

void LevelEditor::load_level(const String &file_path) {

Ref<FileAccess> file = FileAccess::open(file_path, FileAccess::READ);

if (!file.is_valid()) {

Godot::print("Failed to open file for loading: " + file_path);

return;

}

tilemap->clear();

placed_objects.clear();

String section = "";

while (!file->eof_reached()) {

String line = file->get_line().strip_edges();

if (line == "[Tiles]") {

section = "Tiles";

} else if (line == "[Objects]") {

section = "Objects";

} else if (!line.empty()) {

if (section == "Tiles") {

Array parts = line.split("=");

Array coords = parts[0].split(",");

int x = coords[0].to_int();

int y = coords[1].to_int();

int tile_id = parts[1].to_int();

tilemap->set_cell(x, y, tile_id);

} else if (section == "Objects") {

Array parts = line.split(",");

String name = parts[0];

float x = parts[1].to_float();

float y = parts[2].to_float();

if (object_templates.find(name) != object_templates.end()) {

place_object(Vector2(x, y));

}

}

}

}

file->close();

Godot::print("Level loaded: " + file_path);

}

void LevelEditor::set_tool(const String &tool) {

current_tool = tool;

Godot::print("Current tool set to: " + tool);

}

---

4. Features

Tilemap Editing

Place and remove tiles dynamically using set_tile and remove_tile.

Object Editing

Preload objects (e.g., enemies, pickups, decorations).

Place and delete objects dynamically.

Save/Load

Save tiles and objects to a file.

Load levels from saved files.

---

Summary

This Level Editor System:

1. Supports real-time tile and object placement.

2. Saves and loads level layouts for reuse.

3. Provides modular, reusable functionality.

Let me know if you’d like additional features like UI integration or
hotkey support!
