Tilemap Loader

A class to load and manage tilemaps for levels dynamically:

Supports parallax scrolling for backgrounds.

Handles different layers (e.g., collision, visuals).

Enables procedural generation if needed.

Tilemap Loader

Purpose:

Dynamically load and manage tilemaps for levels.

Support multiple layers (e.g., collision, visuals).

Enable procedural generation if needed.

Handle parallax scrolling for backgrounds.

Class Design:

Header File (TilemapLoader.h):

#ifndef TILEMAP_LOADER_H

#define TILEMAP_LOADER_H

#include <godot_cpp/classes/node2d.hpp>

#include <godot_cpp/classes/tile_map.hpp>

#include <string>

using namespace godot;

class TilemapLoader : public Node2D {

GDCLASS(TilemapLoader, Node2D);

private:

String tilemap_path;

TileMap *visual_layer;

TileMap *collision_layer;

void load_layer(const String &layer_path, TileMap *layer);

public:

void _init();

void load_tilemap(const String &tilemap_path);

void enable_parallax_scrolling(Node2D *background, float
parallax_factor);

};

#endif // TILEMAP_LOADER_H

Implementation File (TilemapLoader.cpp):

#include "TilemapLoader.h"

void TilemapLoader::_init() {

visual_layer = TileMap::_new();

collision_layer = TileMap::_new();

add_child(visual_layer);

add_child(collision_layer);

}

void TilemapLoader::load_tilemap(const String &tilemap_path) {

// Assuming the tilemap is split into layers (e.g., visuals.tres,
collision.tres)

this->tilemap_path = tilemap_path;

load_layer(tilemap_path + "_visuals.tres", visual_layer);

load_layer(tilemap_path + "_collision.tres", collision_layer);

}

void TilemapLoader::load_layer(const String &layer_path, TileMap *layer)
{

Ref<TileSet> tileset =
ResourceLoader::get_singleton()->load(layer_path);

if (tileset.is_valid()) {

layer->set_tileset(tileset);

}

}

void TilemapLoader::enable_parallax_scrolling(Node2D *background, float
parallax_factor) {

// Adjust background position based on player's position and parallax
factor

background->connect("position_changed", this,
"on_player_position_changed", varray(parallax_factor));

}

void TilemapLoader::on_player_position_changed(Vector2 position, float
parallax_factor) {

visual_layer->set_position(position * parallax_factor);

}
