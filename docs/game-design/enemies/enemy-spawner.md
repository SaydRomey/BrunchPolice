# Enemy Spawner

Spawns enemies at predefined locations or dynamically during gameplay.
```cpp
Header File (EnemySpawner.h)

#ifndef ENEMY_SPAWNER_H
#define ENEMY_SPAWNER_H

#include <godot_cpp/classes/node2d.hpp>
#include <godot_cpp/classes/packed_scene.hpp>
#include <vector>

using namespace godot;

class EnemySpawner : public Node2D {
    GDCLASS(EnemySpawner, Node2D);

private:
    Ref<PackedScene> enemy_scene;
    std::vector<Vector2> spawn_points;

public:
    void _init();
    void set_enemy_scene(Ref<PackedScene> scene);
    void add_spawn_point(Vector2 position);
    void spawn_enemies(int count);
};

#endif // ENEMY_SPAWNER_H
```

Implementation File (EnemySpawner.cpp)
```cpp
#include "EnemySpawner.h"

void EnemySpawner::_init() {
    spawn_points.clear();
}

void EnemySpawner::set_enemy_scene(Ref<PackedScene> scene) {
    enemy_scene = scene;
}

void EnemySpawner::add_spawn_point(Vector2 position) {
    spawn_points.push_back(position);
}

void EnemySpawner::spawn_enemies(int count) {
    for (int i = 0; i < count && i < spawn_points.size(); ++i) {
        Node2D *enemy = cast_to<Node2D>(enemy_scene->instantiate());
        if (enemy) {
            add_child(enemy);
            enemy->set_position(spawn_points[i]);
        }
    }
}
```

---
