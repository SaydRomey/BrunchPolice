Checkpoint and Respawn System

Manages:

Checkpoints to save progress in levels.

Respawning the player at the latest checkpoint after death.

Checkpoint and Respawn System

Purpose:

Allow players to respawn at the last activated checkpoint.

Save player state (e.g., health, inventory).

Class Design:

Header File (CheckpointSystem.h):

#ifndef CHECKPOINT_SYSTEM_H

#define CHECKPOINT_SYSTEM_H

#include <godot_cpp/classes/node2d.hpp>

#include <godot_cpp/classes/vector2.hpp>

using namespace godot;

class CheckpointSystem : public Node2D {

GDCLASS(CheckpointSystem, Node2D);

private:

Vector2 last_checkpoint_position;

public:

void _init();

void set_checkpoint(Vector2 position);

Vector2 get_last_checkpoint() const;

void respawn(Node2D *player);

};

#endif // CHECKPOINT_SYSTEM_H

Implementation File (CheckpointSystem.cpp):

#include "CheckpointSystem.h"

void CheckpointSystem::_init() {

last_checkpoint_position = Vector2(0, 0); // Default spawn point

}

void CheckpointSystem::set_checkpoint(Vector2 position) {

last_checkpoint_position = position;

Godot::print("Checkpoint set at: " + String(position));

}

Vector2 CheckpointSystem::get_last_checkpoint() const {

return last_checkpoint_position;

}

void CheckpointSystem::respawn(Node2D *player) {

player->set_position(last_checkpoint_position);

Godot::print("Player respawned at: " +
String(last_checkpoint_position));

}
