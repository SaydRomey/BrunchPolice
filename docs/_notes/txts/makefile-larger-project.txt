Makefile - Larger Project

Assumed Project Structure

project/

├── src/

│ ├── core/

│ │ ├── MyClass.cpp

│ │ ├── AnotherClass.cpp

│ ├── main.cpp

├── inc/

│ ├── MyClass.hpp

│ ├── AnotherClass.hpp

├── obj/ # Object files will be placed here

│ ├── core/ # Mirrors src directory structure

├── build/ # Build directory for the final shared library

├── Makefile

---

Makefile

# Project settings

PROJECT_NAME := MyLibrary

SRC_DIR := src

INC_DIR := inc

OBJ_DIR := obj

BUILD_DIR := build

GODOT_HEADERS := /path/to/godot-cpp # Update with the actual path

PLATFORM := linux # Change to windows or macos if needed

# Compiler and flags

CXX := g++

CXXFLAGS := -std=c++98 -fPIC -Wall -I$(INC_DIR)
-I$(GODOT_HEADERS)/include -I$(GODOT_HEADERS)/include/core
-I$(GODOT_HEADERS)/include/gen

LDFLAGS := -shared

ifeq ($(PLATFORM), linux)

OUTPUT := $(BUILD_DIR)/$(PROJECT_NAME).so

else ifeq ($(PLATFORM), macos)

OUTPUT := $(BUILD_DIR)/$(PROJECT_NAME).dylib

else ifeq ($(PLATFORM), windows)

OUTPUT := $(BUILD_DIR)/$(PROJECT_NAME).dll

CXXFLAGS += -D_WIN32

endif

# Sources, objects, and dependencies

SOURCES := $(wildcard $(SRC_DIR)/**/*.cpp $(SRC_DIR)/*.cpp)

OBJECTS := $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/%.o, $(SOURCES))

DEPS := $(OBJECTS:.o=.d)

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

Key Features of This Makefile

1. Object File Organization:

Object files (*.o) are stored in the obj/ directory, maintaining the
same directory structure as src/.

For example:

src/core/MyClass.cpp -> obj/core/MyClass.o

2. Clean and Full Clean:

make clean: Removes object files and dependencies.

make fclean: Calls clean and removes the generated shared library (.so,
.dll, or .dylib).

3. Rebuild Target:

make re: Calls fclean and then all to rebuild everything from scratch.

4. Dependency Tracking:

Automatically tracks header dependencies using .d files.

Ensures changes in headers trigger recompilation of relevant .cpp files.

5. Cross-Platform Support:

Adjusts output file type (.so, .dll, .dylib) based on the PLATFORM
variable.

---

How to Use This Makefile

1. Build the Project:

make

2. Clean Object Files:

make clean

3. Full Clean:

make fclean

4. Rebuild:

make re

5. Customize:

Update the GODOT_HEADERS variable with the path to Godot’s C++ bindings.

Add or remove CXXFLAGS and LDFLAGS as needed.

---

Example Output

If you run make, the directory structure after building will look like
this:

project/

├── src/

├── inc/

├── obj/

│ ├── core/

│ │ ├── MyClass.o

│ │ ├── AnotherClass.o

│ ├── main.o

├── build/

│ ├── MyLibrary.so

├── Makefile

---
