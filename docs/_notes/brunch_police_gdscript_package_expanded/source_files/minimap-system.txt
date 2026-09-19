Minimap System

Minimap System Features

1. Round Minimap:

Displays the player's surroundings in a circular frame.

Keeps the player at the center.

2. Rotating Player Arrow:

The minimap rotates based on the player's direction, with the arrow
always pointing up.

3. Zoom:

Adjustable zoom level for a broader or closer view.

4. Toggle On/Off:

Allows the player to enable or disable the minimap.

5. Additional Features:

Highlights points of interest (e.g., enemies, objectives).

Shows environmental features (e.g., walls, paths).

---

Implementation

Header File (Minimap.h)

#ifndef MINIMAP_H

#define MINIMAP_H

#include <godot_cpp/classes/node2d.hpp>

#include <godot_cpp/classes/sprite.hpp>

#include <godot_cpp/classes/texture.hpp>

#include <godot_cpp/classes/viewport.hpp>

#include <godot_cpp/classes/circle_shape2d.hpp>

#include <map>

#include <string>

using namespace godot;

class Minimap : public Node2D {

GDCLASS(Minimap, Node2D);

private:

Ref<Viewport> minimap_viewport; // Viewport for rendering the minimap

Ref<Sprite> minimap_frame; // Circular frame for the minimap

Ref<Node2D> minimap_content; // Content displayed in the minimap

Ref<Sprite> player_arrow; // Arrow representing the player

float zoom_level; // Current zoom level

bool is_visible; // Minimap toggle state

public:

void _init();

// Minimap setup

void set_frame(Ref<Texture> frame_texture);

void set_player_arrow(Ref<Texture> arrow_texture);

void set_zoom(float zoom);

void toggle_minimap(bool visible);

// Minimap updates

void update_player_position(Vector2 position, float rotation);

void add_point_of_interest(const String &key, Vector2 position,
Ref<Texture> icon_texture);

void remove_point_of_interest(const String &key);

};

#endif // MINIMAP_H

---

Implementation File (Minimap.cpp)

#include "Minimap.h"

void Minimap::_init() {

// Initialize viewport for the minimap

minimap_viewport = Viewport::_new();

minimap_viewport->set_size(Vector2(256, 256)); // Default size

minimap_viewport->set_scale(Vector2(1, 1));

minimap_viewport->set_clear_mode(Viewport::CLEAR_MODE_ONLY_BACKGROUND);

add_child(minimap_viewport);

// Minimap content

minimap_content = Node2D::_new();

minimap_viewport->add_child(minimap_content);

// Minimap frame

minimap_frame = Sprite::_new();

add_child(minimap_frame);

// Player arrow

player_arrow = Sprite::_new();

minimap_content->add_child(player_arrow);

zoom_level = 1.0f;

is_visible = true;

}

void Minimap::set_frame(Ref<Texture> frame_texture) {

minimap_frame->set_texture(frame_texture);

minimap_frame->set_scale(Vector2(2, 2)); // Scale the frame to match the
viewport

}

void Minimap::set_player_arrow(Ref<Texture> arrow_texture) {

player_arrow->set_texture(arrow_texture);

player_arrow->set_position(Vector2(128, 128)); // Centered in the
viewport

player_arrow->set_scale(Vector2(1, 1));

}

void Minimap::set_zoom(float zoom) {

zoom_level = zoom;

minimap_content->set_scale(Vector2(zoom, zoom));

}

void Minimap::toggle_minimap(bool visible) {

is_visible = visible;

minimap_viewport->set_visible(visible);

minimap_frame->set_visible(visible);

}

void Minimap::update_player_position(Vector2 position, float rotation) {

// Center the minimap content on the player

minimap_content->set_position(-position * zoom_level);

// Rotate the minimap content to match the player's rotation

minimap_content->set_rotation(-rotation);

// Keep the player arrow pointing up

player_arrow->set_rotation(0);

}

void Minimap::add_point_of_interest(const String &key, Vector2 position,
Ref<Texture> icon_texture) {

Ref<Sprite> poi_icon = Sprite::_new();

poi_icon->set_texture(icon_texture);

poi_icon->set_position(position);

minimap_content->add_child(poi_icon);

poi_icon->set_name(key);

}

void Minimap::remove_point_of_interest(const String &key) {

Node *poi_icon = minimap_content->find_node(key, true);

if (poi_icon) {

minimap_content->remove_child(poi_icon);

poi_icon->queue_free();

} else {

Godot::print("Point of interest not found: " + key);

}

}

---

Usage

Setup

1. Add Minimap to your scene tree.

2. Set the minimap frame texture and player arrow texture.

Ref<Minimap> minimap = get_node<Minimap>("/root/Minimap");

Ref<Texture> frame_texture =
ResourceLoader::get_singleton()->load("res://textures/minimap_frame.png");

Ref<Texture> arrow_texture =
ResourceLoader::get_singleton()->load("res://textures/player_arrow.png");

minimap->set_frame(frame_texture);

minimap->set_player_arrow(arrow_texture);

Update Player Position

Update the minimap's position and rotation based on the player's state:

Vector2 player_position = get_node<Player>("Player")->get_position();

float player_rotation = get_node<Player>("Player")->get_rotation();

minimap->update_player_position(player_position, player_rotation);

Toggle Minimap

Allow the player to toggle the minimap on or off:

bool minimap_visible = true;

void toggle_minimap() {

minimap_visible = !minimap_visible;

minimap->toggle_minimap(minimap_visible);

}

Zoom Control

Allow the player to adjust the minimap zoom:

float zoom = 1.0f;

void adjust_zoom(float amount) {

zoom += amount;

zoom = Math::clamp(zoom, 0.5f, 3.0f); // Clamp zoom between 0.5x and 3x

minimap->set_zoom(zoom);

}

Points of Interest

Add enemies, objectives, or collectibles to the minimap:

Ref<Texture> enemy_icon =
ResourceLoader::get_singleton()->load("res://textures/enemy_icon.png");

minimap->add_point_of_interest("enemy1", Vector2(300, 400), enemy_icon);

// Remove it later

minimap->remove_point_of_interest("enemy1");

---

Optional Features

1. Blip Animation for POIs

Make points of interest "blip" on the minimap using scale or opacity
changes with a Tween node.

2. Fog of War

Hide unexplored areas by overlaying a semi-transparent texture and
revealing sections as the player moves.

3. Mini-Boss Indicators

Highlight major enemies or objectives with larger, animated icons.

4. Map Transition Effects

Fade in/out the minimap when toggled to improve visual appeal.

---

Summary

This Minimap System provides:

1. Dynamic Positioning: Keeps the player at the center and rotates the
minimap.

2. Customizability: Supports zoom, toggle, and points of interest.

3. Modular Design: Can be reused for any top-down or side-scrolling
game.

Let me know if you'd like to expand this further or integrate it with
other systems!

...
