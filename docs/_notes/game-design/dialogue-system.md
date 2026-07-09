# Dialogue System

A reusable system to handle branching dialogues with NPCs.

Purpose:
- Display NPC dialogue (typewriter effect?).
- Allow branching paths (e.g., player choices or NPC reactions).
- Handle dialogue-specific events (e.g., accusations, triggering NPC fleeing behavior).

---

## Class Design

Header File (DialogueManager.h)
```cpp
#ifndef DIALOGUE_MANAGER_H
#define DIALOGUE_MANAGER_H

#include <godot_cpp/classes/node.hpp>
#include <vector>
#include <string>

using namespace godot;

class DialogueManager : public Node {
    GDCLASS(DialogueManager, Node);

public:
    struct Dialogue {
        String speaker;
        String text;
        std::vector<String> choices;
        std::vector<int> next_indices; // Indexes for branching dialogues
    };

private:
    std::vector<Dialogue> dialogues;
    int current_index;

public:
    void _init();
    void load_dialogue(const std::vector<Dialogue> &dialogue_data);
    void start_dialogue(int start_index = 0);
    void show_next();
    void handle_choice(int choice_index);
};

#endif // DIALOGUE_MANAGER_H
```

Implementation File (DialogueManager.cpp)
```cpp
#include "DialogueManager.h"

void DialogueManager::_init() {
    current_index = -1;
    dialogues.clear();
}

void DialogueManager::load_dialogue(const std::vector<Dialogue> &dialogue_data) {
    dialogues = dialogue_data;
}

void DialogueManager::start_dialogue(int start_index) {
    if (start_index < 0 || start_index >= dialogues.size()) {
        Godot::print("Invalid dialogue start index.");
        return;
    }
    current_index = start_index;
    show_next();
}

void DialogueManager::show_next() {
    if (current_index < 0 || current_index >= dialogues.size()) {
        Godot::print("Dialogue finished.");
        return;
    }

    Dialogue &dialogue = dialogues[current_index];
    Godot::print(dialogue.speaker + ": " + dialogue.text);

    if (!dialogue.choices.empty()) {
        Godot::print("Choices:");
        for (size_t i = 0; i < dialogue.choices.size(); ++i) {
            Godot::print(String::num_int64(i + 1) + ". " + dialogue.choices[i]);
        }
    }
}

void DialogueManager::handle_choice(int choice_index) {
    if (current_index < 0 || current_index >= dialogues.size()) {
        Godot::print("Dialogue not active.");
        return;
    }

    Dialogue &dialogue = dialogues[current_index];
    if (choice_index < 0 || choice_index >= dialogue.next_indices.size()) {
        Godot::print("Invalid choice.");
        return;
    }

    current_index = dialogue.next_indices[choice_index];
    show_next();
}
```

---

## Example Usage

Dialogue Data:
```cpp
std::vector<DialogueManager::Dialogue> dialogue_data = {
    {"NPC1", "Welcome to Brunch Police!", {}, {}},
    {"NPC1", "Can I help you?", {"Yes", "No"}, {2, 3}},
    {"NPC1", "Sure! Let me assist.", {}, {}},
    {"NPC1", "Alright, have a great day!", {}, {}}
};
```

Integration:
```gdscript
Ref<DialogueManager> dialogue_manager = get_node<DialogueManager>("/root/DialogueManager");
dialogue_manager->load_dialogue(dialogue_data);
dialogue_manager->start_dialogue();
```

---
