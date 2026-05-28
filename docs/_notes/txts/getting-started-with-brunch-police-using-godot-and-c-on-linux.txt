Getting Started with Brunch Police using Godot and C++ on Linux

This guide will help you set up your environment, understand core
concepts, and begin development with minimal features for Brunch Police.

---

1. Install Godot Engine

1. Download Godot:

Visit the Godot website and download the latest stable version for
Linux.

2. Extract and Run:

Extract the downloaded file and run the Godot executable.

---

2. Set Up Godot with C++ (GDNative)

Godot's default scripting language is GDScript, but you can use C++ with
GDNative for high-performance tasks.

2.1 Install Required Tools

sudo apt update

sudo apt install build-essential python3-pip scons clang

pip3 install --user gdnative-godot-cpp

2.2 Clone the Godot C++ Bindings

git clone https://github.com/godotengine/godot-cpp.git

cd godot-cpp

git submodule update --init --recursive

scons platform=linux generate_bindings=yes

This generates the C++ bindings that allow your custom C++ code to
interact with Godot.

---

3. Create Your Project

1. Open Godot:

Start Godot and create a new project. Name it BrunchPolice.

2. Organize Files:

Inside your project folder, create these directories:

src/ # For C++ code

assets/ # For graphics, sounds, and animations

scenes/ # For Godot scene files

3. Set Up GDNative:

In your project root, create a gdnative/ folder to store compiled .so
files for your C++ code.

---

4. Minimal Features to Start

To begin, we'll implement:

1. Player Movement (top-down in the brunch area).

2. Basic NPC Interaction.

3. Simple Scene Management (transition between scenes).

---

5. Write Your First C++ Script

5.1 Create a Player Controller

1. Player.cpp

#include <godot_cpp/classes/node2d.hpp>

#include <godot_cpp/classes/input.hpp>

#include <godot_cpp/classes/engine.hpp>

#include <godot_cpp/core/class_db.hpp>

#include <godot_cpp/variant/vector2.hpp>

using namespace godot;

class Player : public Node2D {

GDCLASS(Player, Node2D);

private:

Vector2 velocity;

public:

void _init() {} // Initialization

void _process(float delta) {

velocity = Vector2();

if (Input::get_singleton()->is_action_pressed("ui_up")) {

velocity.y -= 200;

}

if (Input::get_singleton()->is_action_pressed("ui_down")) {

velocity.y += 200;

}

if (Input::get_singleton()->is_action_pressed("ui_left")) {

velocity.x -= 200;

}

if (Input::get_singleton()->is_action_pressed("ui_right")) {

velocity.x += 200;

}

set_position(get_position() + velocity * delta);

}

};

2. SConstruct Create a SConstruct file in the src/ directory:

Import("env")

env.add_source_files(env.modules_sources, "*.cpp")

3. Compile: Navigate to the src directory and compile the script:

scons platform=linux

---

5.2 Add Player Node in Godot

1. Create a Scene:

In Godot, create a new Node2D scene and save it as Player.tscn.

2. Attach the GDNative Script:

Add a GDNative instance to the node and link the compiled .so file from
your gdnative/ directory.

---

6. Add Basic NPC Interaction

NPC.cpp

#include <godot_cpp/classes/node2d.hpp>

#include <godot_cpp/classes/label.hpp>

#include <godot_cpp/classes/engine.hpp>

#include <godot_cpp/core/class_db.hpp>

using namespace godot;

class NPC : public Node2D {

GDCLASS(NPC, Node2D);

public:

void _init() {}

void _process(float delta) {

// Detect proximity to the player and display interaction text

}

};

---

7. Implement Scene Management

1. Create a Main.tscn:

Add your Player scene and basic NPCs.

2. Add an Area2D for interaction triggers:

Connect signals to handle player interactions.

---

8. Test the Game

1. Add input actions for movement in Project Settings > Input Map:

ui_up, ui_down, ui_left, ui_right.

2. Run the scene and test movement and NPC interaction.

---

9. Expand Features

Once the basics are working, you can:

1. Add animations using AnimatedSprite2D.

2. Implement transitions to the 2D platformer scenes.

3. Start designing the level layouts for your game.

---

10. Learn and Iterate

Explore the Godot documentation for more:

Godot C++ Tutorial

https://docs.godotengine.org/en/stable/tutorials/scripting/gdnative/using_gdnative_with_cpp.html

C++ API Reference

https://docs.godotengine.org/en/stable/classes/class_list.html

Let me know if you'd like help with any specific part!
