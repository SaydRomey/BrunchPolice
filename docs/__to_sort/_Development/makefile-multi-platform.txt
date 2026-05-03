Makefile - Multi-Platform

Here’s how you can make your Makefile modular and conditionally include
helper Makefiles based on the operating system. This will make your
build system clean, extensible, and adaptable to multiple platforms
(Linux, macOS, and Windows).

---

Key Features

1. Dynamic OS Detection: Automatically detect the operating system and
include the corresponding helper Makefile.

2. Helper Makefiles: Each helper Makefile (Linux.mk, macOS.mk,
Windows.mk) defines platform-specific variables, paths, and dependency
management logic.

3. Prompted Installation Scripts: If dependencies are missing, provide a
clean way to prompt the user for installation.

---

Main Makefile

# Project settings

PROJECT_NAME := MyLibrary

SRC_DIR := src

INC_DIR := inc

OBJ_DIR := obj

BUILD_DIR := build

# OS Detection

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

# Targets

all: $(BUILD_DIR) $(OUTPUT)

# Build directories

$(BUILD_DIR):

mkdir -p $(BUILD_DIR)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp

mkdir -p $(dir $@)

$(CXX) $(CXXFLAGS) -c $< -o $@

# Generate shared library

$(OUTPUT): $(OBJECTS)

$(CXX) $(LDFLAGS) $^ -o $@

# Clean object files

clean:

rm -rf $(OBJ_DIR)

# Full clean (object files and shared library)

fclean: clean

rm -rf $(BUILD_DIR)

# Rebuild everything

re: fclean all

# Include dependencies for header tracking

-include $(DEPS)

# Create dependency files

$(OBJ_DIR)/%.d: $(SRC_DIR)/%.cpp

mkdir -p $(dir $@)

$(CXX) -MM $(CXXFLAGS) $< -MF $@ -MT $(@:.d=.o)

.PHONY: all clean fclean re

---

Helper Makefiles

Linux.mk

# Compiler and flags for Linux

CXX := g++

CXXFLAGS := -std=c++98 -fPIC -Wall -I$(INC_DIR) -I/usr/include/godot-cpp

LDFLAGS := -shared

OUTPUT := $(BUILD_DIR)/$(PROJECT_NAME).so

# Source, object, and dependency files

SOURCES := $(wildcard $(SRC_DIR)/**/*.cpp $(SRC_DIR)/*.cpp)

OBJECTS := $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/%.o, $(SOURCES))

DEPS := $(OBJECTS:.o=.d)

# Dependency check and prompt for installation

check-deps:

@which g++ >/dev/null || echo "G++ is missing. Please install it using
'sudo apt install g++'."

@which scons >/dev/null || echo "SCons is missing. Please install it
using 'sudo apt install scons'."

.PHONY: check-deps

macOS.mk

# Compiler and flags for macOS

CXX := clang++

CXXFLAGS := -std=c++98 -fPIC -Wall -I$(INC_DIR)
-I/usr/local/include/godot-cpp

LDFLAGS := -shared

OUTPUT := $(BUILD_DIR)/$(PROJECT_NAME).dylib

# Source, object, and dependency files

SOURCES := $(wildcard $(SRC_DIR)/**/*.cpp $(SRC_DIR)/*.cpp)

OBJECTS := $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/%.o, $(SOURCES))

DEPS := $(OBJECTS:.o=.d)

# Dependency check and prompt for installation

check-deps:

@which clang++ >/dev/null || echo "Clang++ is missing. Install Xcode
command-line tools using 'xcode-select --install'."

@which scons >/dev/null || echo "SCons is missing. Please install it
using 'brew install scons'."

.PHONY: check-deps

Windows.mk

# Compiler and flags for Windows

CXX := g++

CXXFLAGS := -std=c++98 -Wall -I$(INC_DIR) -I"C:/godot-cpp/include"

LDFLAGS := -shared

OUTPUT := $(BUILD_DIR)/$(PROJECT_NAME).dll

# Source, object, and dependency files

SOURCES := $(wildcard $(SRC_DIR)/**/*.cpp $(SRC_DIR)/*.cpp)

OBJECTS := $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/%.o, $(SOURCES))

DEPS := $(OBJECTS:.o=.d)

# Dependency check and prompt for installation

check-deps:

@if not exist "$(CXX)" echo "G++ is missing. Install MinGW or a
compatible compiler."

@if not exist "$(GODOT_CPP)" echo "Godot C++ bindings path is missing.
Please ensure the correct path."

.PHONY: check-deps

---

How It Works

1. Dynamic Helper Inclusion:

The main Makefile detects the operating system using uname -s (for
Linux/macOS) or the OS environment variable (for Windows).

It includes the corresponding helper Makefile (Linux.mk, macOS.mk, or
Windows.mk).

2. Centralized Build Logic:

The main Makefile contains the core build logic.

Helper Makefiles populate platform-specific variables and handle
platform-specific quirks (e.g., dependency paths, compiler flags).

3. Dependency Checks:

Each helper Makefile has a check-deps target that verifies required
tools and libraries.

Missing dependencies are reported with installation instructions.

---

Commands

1. Build:

make

2. Clean Object Files:

make clean

3. Full Clean:

make fclean

4. Rebuild:

make re

5. Check Dependencies:

make check-deps

---

Advantages of This Setup

1. Cross-Platform: Automatically adapts to the operating system.

2. Modularity: Platform-specific logic is isolated in helper Makefiles.

3. Ease of Use: Clearly defined check-deps target ensures smooth setup.

4. Scalability: Adding new platforms or configurations is as simple as
creating a new helper Makefile.

---

This setup is clean, efficient, and suitable for large, multi-platform
projects.

---

Full Directory Structure

project/

├── src/ # Source files for your project

│ ├── core/ # Core game logic

│ │ ├── MyClass.cpp

│ │ ├── AnotherClass.cpp

│ ├── utils/ # Utility classes or helpers

│ │ ├── Timer.cpp

│ │ ├── ResourceManager.cpp

│ ├── main.cpp # Entry point (if required)

├── inc/ # Header files for your project

│ ├── MyClass.hpp

│ ├── AnotherClass.hpp

│ ├── Timer.hpp

│ ├── ResourceManager.hpp

├── obj/ # Compiled object files (auto-generated)

│ ├── core/

│ │ ├── MyClass.o

│ │ ├── AnotherClass.o

│ ├── utils/

│ │ ├── Timer.o

│ │ ├── ResourceManager.o

├── build/ # Compiled output libraries (auto-generated)

│ ├── MyLibrary.so # Linux shared library

│ ├── MyLibrary.dylib # macOS shared library

│ ├── MyLibrary.dll # Windows DLL

├── gdnative/ # Godot-specific files

│ ├── MyLibrary.gdnlib # GDNative library configuration

│ ├── MyLibrary.gdns # NativeScript configuration

├── helpers/ # Platform-specific helper Makefiles

│ ├── Linux.mk

│ ├── macOS.mk

│ ├── Windows.mk

├── assets/ # Game assets (e.g., textures, audio)

│ ├── sprites/

│ │ ├── player.png

│ │ ├── enemy.png

│ ├── audio/

│ │ ├── theme.ogg

│ │ ├── jump.wav

├── scenes/ # Godot scene files

│ ├── main.tscn # Main game scene

│ ├── player.tscn # Player scene

│ ├── level1.tscn # First level scene

├── Makefile # Main Makefile for the project

├── README.md # Project documentation

└── LICENSE # License file

---

Explanation of Each Directory

src/ (Source Files)

Contains all C++ source files organized by purpose.

Subdirectories like core for game logic and utils for reusable utility
classes.

inc/ (Header Files)

Contains all header files for the C++ classes in src/.

obj/ (Object Files)

Automatically generated during compilation.

Mirrors the directory structure of src/.

build/ (Build Output)

Contains the final compiled shared library (.so, .dylib, .dll) depending
on the platform.

gdnative/ (Godot-Specific Configuration)

Contains .gdnlib and .gdns files required for integrating the C++
library into Godot.

helpers/ (Platform-Specific Makefiles)

Modular Makefiles for Linux, macOS, and Windows.

Each file sets platform-specific compiler flags, linker flags, and
dependency checks.

assets/ (Game Assets)

Stores all game assets like textures, sprites, audio, and other media.

scenes/ (Godot Scenes)

Stores Godot .tscn files for the game’s scenes (e.g., player, levels,
main menu).

Root Files

Makefile: The main entry point for the build process.

README.md: Documentation for the project, including setup instructions.

LICENSE: Open-source or proprietary license for your project.

---

Workflow

1. Building the Project:

make

2. Clean Builds:

Remove only object files:

make clean

Remove object files and shared libraries:

make fclean

Rebuild everything:

make re

3. Platform-Specific Logic:

Automatically handled by the helper Makefiles in helpers/.

4. Add New Source Files:

Place new .cpp files in src/ and corresponding .hpp files in inc/.

The Makefile will automatically detect them without modifications.

.....

.....

Automatic Dependency Checks and Installation

1. Check Dependencies

Use shell commands in the Makefile to check for required tools (e.g.,
g++, scons, etc.).

If a dependency is missing, prompt the user to install it.

2. Dynamic Path Detection

Use find or similar commands to locate include paths (e.g., Godot C++
headers) and add them to CXXFLAGS.

3. Example Implementation

Here’s an updated Makefile that includes automatic dependency checking
and path detection:

---

Makefile

# Project settings

PROJECT_NAME := MyLibrary

SRC_DIR := src

INC_DIR := inc

OBJ_DIR := obj

BUILD_DIR := build

HELPERS_DIR := helpers

# Compiler settings

CXX := g++

CXXFLAGS := -std=c++98 -fPIC -Wall

LDFLAGS := -shared

# Platform-specific settings

UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S), Linux)

include $(HELPERS_DIR)/Linux.mk

else ifeq ($(UNAME_S), Darwin)

include $(HELPERS_DIR)/macOS.mk

else ifeq ($(OS), Windows_NT)

include $(HELPERS_DIR)/Windows.mk

else

$(error "Unsupported operating system!")

endif

# Source, object, and dependency files

SOURCES := $(wildcard $(SRC_DIR)/**/*.cpp $(SRC_DIR)/*.cpp)

OBJECTS := $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/%.o, $(SOURCES))

DEPS := $(OBJECTS:.o=.d)

# Targets

all: check-deps paths $(BUILD_DIR) $(OUTPUT)

# Check dependencies and prompt for installation

check-deps:

@echo "Checking dependencies..."

@which $(CXX) >/dev/null || { echo "G++ is missing. Install it? (y/n)";
read ans && [ $$ans = y ] && sudo apt install g++; }

@which scons >/dev/null || { echo "SCons is missing. Install it? (y/n)";
read ans && [ $$ans = y ] && sudo apt install scons; }

# Automatically find include paths

paths:

@echo "Finding include paths..."

@export GODOT_HEADERS=$(shell find / -type d -name godot-cpp 2>/dev/null
| head -n 1)

@echo "Using Godot headers: $$GODOT_HEADERS"

@if [ -z "$$GODOT_HEADERS" ]; then \

echo "Godot headers not found. Please install them."; \

exit 1; \

fi

CXXFLAGS += -I$$GODOT_HEADERS/include -I$$GODOT_HEADERS/include/core
-I$$GODOT_HEADERS/include/gen

# Build directories

$(BUILD_DIR):

mkdir -p $(BUILD_DIR)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp

mkdir -p $(dir $@)

$(CXX) $(CXXFLAGS) -c $< -o $@

# Generate shared library

$(OUTPUT): $(OBJECTS)

$(CXX) $(LDFLAGS) $^ -o $@

# Clean object files

clean:

rm -rf $(OBJ_DIR)

# Full clean (object files and shared library)

fclean: clean

rm -rf $(BUILD_DIR)

# Rebuild everything

re: fclean all

# Include dependencies for header tracking

-include $(DEPS)

# Create dependency files

$(OBJ_DIR)/%.d: $(SRC_DIR)/%.cpp

mkdir -p $(dir $@)

$(CXX) -MM $(CXXFLAGS) $< -MF $@ -MT $(@:.d=.o)

.PHONY: all clean fclean re check-deps paths
