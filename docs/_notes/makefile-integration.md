Makefile

A Makefile can help automate the build process, manage dependencies, and
provide a clear structure for compiling your C++ code. Below is a
step-by-step guide on how to set up a Makefile for your Godot + C++
project.

---

Why Use a Makefile in This Project?

1. Automation: Compile your C++ code and generate the .so (Linux), .dll
(Windows), or .dylib (Mac) library with a single command.

2. Customization: Add specific build configurations, like debug or
release builds.

3. Cross-Platform Builds: Easily adapt the Makefile for different
platforms.

4. Readability: Clearly define the build process for yourself and
others.

---

Example Makefile for GDNative Project

Structure

Here's the assumed project structure:

project/

├── src/

│ ├── MyClass.cpp

│ ├── MyClass.hpp

│ ├── SConstruct (optional for SCons users)

├── gdnative/

│ ├── MyLibrary.gdnlib

│ ├── MyLibrary.gdns

├── Makefile

Makefile

# Project settings

PROJECT_NAME := MyLibrary

SRC_DIR := src

BUILD_DIR := build

GODOT_HEADERS := /path/to/godot-cpp # Path to Godot C++ bindings

PLATFORM := linux # Change to windows or macos if needed

# Compiler and flags

CXX := g++

CXXFLAGS := -std=c++98 -fPIC -I$(GODOT_HEADERS)/include
-I$(GODOT_HEADERS)/include/core -I$(GODOT_HEADERS)/include/gen

LDFLAGS := -shared

ifeq ($(PLATFORM), linux)

OUTPUT := $(BUILD_DIR)/$(PROJECT_NAME).so

else ifeq ($(PLATFORM), macos)

OUTPUT := $(BUILD_DIR)/$(PROJECT_NAME).dylib

else ifeq ($(PLATFORM), windows)

OUTPUT := $(BUILD_DIR)/$(PROJECT_NAME).dll

CXXFLAGS += -D_WIN32

endif

# Source files and objects

SOURCES := $(wildcard $(SRC_DIR)/*.cpp)

OBJECTS := $(patsubst $(SRC_DIR)/%.cpp, $(BUILD_DIR)/%.o, $(SOURCES))

# Targets

all: $(BUILD_DIR) $(OUTPUT)

# Build output

$(BUILD_DIR):

mkdir -p $(BUILD_DIR)

# Compile sources into objects

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp

$(CXX) $(CXXFLAGS) -c $< -o $@

# Link objects into shared library

$(OUTPUT): $(OBJECTS)

$(CXX) $(LDFLAGS) $^ -o $@

# Clean build files

clean:

rm -rf $(BUILD_DIR)

.PHONY: all clean

---

How to Use This Makefile

1. Set Paths:

Replace /path/to/godot-cpp with the actual path to the Godot C++
bindings directory.

Ensure the SRC_DIR and BUILD_DIR variables match your directory
structure.

2. Build: Run the following command in your terminal:

make

3. Clean: To remove the build/ directory and all compiled files, run:

make clean

---

Advantages

1. Modular Builds:

Easily add or remove source files without modifying the build command.

2. Debugging:

Add -g to CXXFLAGS for debug builds.

3. Portability:

Adjust the PLATFORM variable to target different operating systems.

4. Customization:

Add rules for testing, profiling, or packaging.

---

Tips for Managing Larger Projects

1. Header Dependencies: Use tools like makedepend or gcc -MM to
automatically generate header dependencies:

depend:

$(CXX) $(CXXFLAGS) -MM $(SOURCES) > .depend

-include .depend

2. Build Configurations: Add debug and release targets:

debug: CXXFLAGS += -g

debug: all

release: CXXFLAGS += -O2

release: all

3. Multiple Libraries: If your project grows, extend the Makefile to
manage multiple libraries by using subdirectories and recursive rules.

---

Integrating the Library with Godot

1. Compile: After running make, the shared library (.so, .dll, or
.dylib) will appear in the build/ directory.

2. Add to Godot:

Place the compiled library in the gdnative/ folder.

Ensure the .gdnlib file points to the correct path for the library.
