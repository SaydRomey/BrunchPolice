Event System

A publisher-subscriber system to manage game events:

Example: Notify systems when the player collects an item or defeats a
boss.

Decouples game logic for cleaner code.

Event System

A modular event handler to trigger level events like enemy spawns or
traps.

Header File (EventSystem.h):

#ifndef EVENT_SYSTEM_H

#define EVENT_SYSTEM_H

#include <godot_cpp/classes/node.hpp>

#include <map>

#include <string>

using namespace godot;

class EventSystem : public Node {

GDCLASS(EventSystem, Node);

private:

std::map<String, Callable> events;

public:

void _init();

void register_event(const String &name, Callable callback);

void trigger_event(const String &name);

};

#endif // EVENT_SYSTEM_H

Implementation File (EventSystem.cpp):

#include "EventSystem.h"

void EventSystem::_init() {

events.clear();

}

void EventSystem::register_event(const String &name, Callable callback)
{

events[name] = callback;

}

void EventSystem::trigger_event(const String &name) {

if (events.find(name) != events.end()) {

events[name].call();

}

}
