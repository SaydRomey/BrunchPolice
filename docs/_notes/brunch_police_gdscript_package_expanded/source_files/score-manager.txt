Score Manager

Tracks the player’s score and displays it on the UI.

Header File (ScoreManager.h)

#ifndef SCORE_MANAGER_H

#define SCORE_MANAGER_H

#include <godot_cpp/classes/node.hpp>

class ScoreManager : public Node {

GDCLASS(ScoreManager, Node);

private:

int score;

public:

void _init();

void add_score(int points);

int get_score() const;

};

#endif // SCORE_MANAGER_H

Implementation File (ScoreManager.cpp)

#include "ScoreManager.h"

void ScoreManager::_init() {

score = 0;

}

void ScoreManager::add_score(int points) {

score += points;

Godot::print("Score: " + String::num_int64(score));

}

int ScoreManager::get_score() const {

return score;

}
