# Setup and Build System

## Purpose

This note consolidates the Makefile strategy for building the Godot + C++ project across small, large, and multi-platform project layouts.

## Source files covered

- `makefile-integration.txt`
- `makefile-larger-project.txt`
- `makefile-multi-platform.txt`

## Why use a Makefile?

The source notes identify these benefits:

- Compile C++ and generate `.so`, `.dll`, or `.dylib` libraries with one command.
- Manage build directories and object files.
- Support debug and release builds.
- Adapt to different platforms.
- Keep the build process readable for collaborators.

## Basic Makefile structure

The basic setup assumes:

```text
project/
├── src/
│   ├── MyClass.cpp
│   ├── MyClass.hpp
│   └── SConstruct
├── gdnative/
│   ├── MyLibrary.gdnlib
│   └── MyLibrary.gdns
└── Makefile
```

Core variables:

```make
PROJECT_NAME := MyLibrary
SRC_DIR := src
BUILD_DIR := build
GODOT_HEADERS := /path/to/godot-cpp
PLATFORM := linux
CXX := g++
CXXFLAGS := -std=c++98 -fPIC
LDFLAGS := -shared
```

Platform output changes by target OS:

- Linux: `build/MyLibrary.so`
- macOS: `build/MyLibrary.dylib`
- Windows: `build/MyLibrary.dll`

## Larger project Makefile

The larger project Makefile introduces:

- `INC_DIR := inc`
- `OBJ_DIR := obj`
- Recursive source discovery.
- Mirrored object structure.
- Dependency files with `.d`.
- `clean`, `fclean`, and `re` targets.

Object mapping example:

```text
src/core/MyClass.cpp -> obj/core/MyClass.o
```

Important targets:

```make
all
clean
fclean
re
```

## Multi-platform Makefile layout

The multi-platform design splits platform logic into helper files:

```text
helpers/
├── Linux.mk
├── macOS.mk
└── Windows.mk
```

The main Makefile detects the operating system:

```make
UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S), Linux)
include helpers/Linux.mk
else ifeq ($(UNAME_S), Darwin)
include helpers/macOS.mk
else ifeq ($(OS), Windows_NT)
include helpers/Windows.mk
else
$(error "Unsupported operating system!")
endif
```

## Helper Makefile responsibilities

Each helper Makefile defines:

- Compiler.
- Compiler flags.
- Linker flags.
- Output extension.
- Source discovery.
- Object file mapping.
- Dependency files.
- Dependency-check target.

Examples:

Linux uses:

```make
CXX := g++
OUTPUT := $(BUILD_DIR)/$(PROJECT_NAME).so
```

macOS uses:

```make
CXX := clang++
OUTPUT := $(BUILD_DIR)/$(PROJECT_NAME).dylib
```

Windows uses:

```make
CXX := g++
OUTPUT := $(BUILD_DIR)/$(PROJECT_NAME).dll
```

## Recommended final build organization

Use the multi-platform approach once the project grows beyond a few files.

Recommended root files:

```text
Makefile
helpers/Linux.mk
helpers/macOS.mk
helpers/Windows.mk
src/
inc/
obj/
build/
gdnative/
assets/
scenes/
README.md
LICENSE
```

## Build commands

```bash
make
make clean
make fclean
make re
make check-deps
```

## Cleanup recommendations

The source files contain multiple Makefile versions. Treat them as a progression:

1. Basic Makefile for early experiments.
2. Larger-project Makefile once directories grow.
3. Multi-platform Makefile as the long-term target.

Use one canonical Makefile path in the final project to avoid contradictory build rules.
