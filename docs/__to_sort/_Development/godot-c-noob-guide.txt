Godot (c++) Noob Guide

Here’s a beginner-friendly guide to understanding Godot and integrating
C++ code. It will help you get started with the basics, terminology, and
setup for using C++ in your projects.

---

What is Godot?

Godot is a free and open-source game engine for creating 2D and 3D
games. It has a lightweight design, supports multiple platforms, and is
beginner-friendly. Godot uses GDScript as its primary scripting language
but supports other languages like C#, VisualScript, and C++.

Why Use Godot with C++?

Performance: C++ is faster and better for low-level,
performance-critical tasks.

Flexibility: If you already know C++, you can leverage your knowledge.

Native Code: Write custom logic and integrate directly into Godot's core
systems.

---

Godot Basics

Here are some key terms and concepts in Godot:

1. Nodes

Nodes are the building blocks of a Godot project. Everything in the
scene is a node.

Examples: Sprite, Area2D, CollisionShape2D.

Nodes can have children, forming a Scene Tree.

2. Scene

A Scene is a collection of nodes. For example:

A level could be a scene.

A player character could be a scene.

3. Resources

Assets like textures, audio, and scripts are called resources. These are
reusable and stored in the project.

4. Scripting

Godot uses GDScript for most scripting, but you can also use C++ via the
Godot C++ Module or the GDNative system.

---

Key Components for C++ Integration

Godot allows integrating C++ code using GDNative or by creating Custom
Modules.

GDNative

This is the easiest way to integrate C++ into Godot.

What is GDNative?

It allows you to write scripts in C++ and attach them to nodes.

C++ code runs as a library loaded by Godot at runtime.

No need to recompile the Godot engine.

---

Setting Up C++ for Godot

Here’s how you can integrate C++ with Godot using GDNative.

1. Prerequisites

Install Godot Engine (preferably the latest stable version).

Install a C++ compiler (like GCC, Clang, or MSVC).

Install SCons, a build system Godot uses to compile C++ code:

sudo apt install scons

2. Create a Godot Project

1. Open Godot.

2. Create a new project and name it (e.g., BrunchPolice).

3. Add folders like src/ for your C++ code.

---

3. Create GDNative Libraries

GDNative requires a .gdnlib file to define how the library interacts
with Godot.

Example Folder Structure:

project/

├── src/

│ ├── MyClass.cpp

│ ├── MyClass.hpp

├── gdnative/

│ ├── MyLibrary.gdnlib

│ ├── MyLibrary.gdns

MyLibrary.gdnlib

This file tells Godot how to load your compiled C++ library.

[general]

singleton=false

load_once=true

symbol_prefix="godot_"

reloadable=true

[entry]

OSX.64="res://gdnative/MyLibrary.dylib"

Windows.64="res://gdnative/MyLibrary.dll"

Linux.64="res://gdnative/MyLibrary.so"

---

4. Write C++ Code

Godot C++ bindings let you create and manage nodes, signals, and more.

MyClass.hpp

#ifndef MYCLASS_HPP

#define MYCLASS_HPP

#include <Godot.hpp>

#include <Node.hpp>

class MyClass : public godot::Node {

GODOT_CLASS(MyClass, godot::Node)

public:

static void _register_methods();

MyClass();

~MyClass();

void _init(); // Godot constructor

void say_hello(); // Example method

};

#endif

MyClass.cpp

#include "MyClass.hpp"

#include <Godot.hpp>

using namespace godot;

void MyClass::_register_methods() {

register_method("say_hello", &MyClass::say_hello);

}

MyClass::MyClass() {}

MyClass::~MyClass() {}

void MyClass::_init() {

Godot::print("MyClass initialized!");

}

void MyClass::say_hello() {

Godot::print("Hello from C++!");

}

---

5. Compile the Library

Use SCons to build your C++ library.

1. Create a SConstruct file in your src/ directory:

env = Environment()

env.SharedLibrary(target='MyLibrary', source=['MyClass.cpp'])

2. Compile:

cd src/

scons

This generates a .so (Linux), .dll (Windows), or .dylib (Mac).

---

6. Attach C++ to Godot

1. Create a .gdns file:

[gd_resource type="NativeScript" load_steps=2 format=2]

[ext_resource path="res://gdnative/MyLibrary.gdnlib"
type="GDNativeLibrary" id=1]

[resource]

class_name = "MyClass"

library = ExtResource( 1 )

2. Add it to a node in Godot:

Add a Node to your scene.

Attach your .gdns file as its script.

---

7. Run the Game

When you run the game, you’ll see the messages from your C++ code in the
Godot output.

---

Core Godot C++ Concepts

1. GODOT_CLASS Macro: Registers the class with Godot.

2. register_method(): Exposes functions to Godot for scripting.

3. Godot::print(): Logs messages to the console.

4. Signals: Use emit_signal to trigger events in Godot.

---

Expanding Your Knowledge

1. Documentation: Godot's GDNative Docs

https://docs.godotengine.org/en/stable/

2. Community: Join Godot forums and Discord channels for help.

3. Learning Path:

Start with small projects (e.g., displaying text or moving a sprite).

Gradually add features like custom logic, animations, and physics.
