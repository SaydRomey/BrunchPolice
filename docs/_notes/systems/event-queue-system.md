Event Queue System

Useful for managing a sequence of events like cutscenes or scripted
gameplay moments.

Header File (EventQueue.h)

#ifndef EVENT_QUEUE_H

#define EVENT_QUEUE_H

#include <godot_cpp/classes/node.hpp>

#include <queue>

#include <string>

using namespace godot;

class EventQueue : public Node {

GDCLASS(EventQueue, Node);

private:

std::queue<Callable> events;

public:

void _init();

void add_event(Callable event);

void execute_next_event();

};

#endif // EVENT_QUEUE_H

Implementation File (EventQueue.cpp)

#include "EventQueue.h"

void EventQueue::_init() {

while (!events.empty()) {

events.pop();

}

}

void EventQueue::add_event(Callable event) {

events.push(event);

}

void EventQueue::execute_next_event() {

if (!events.empty()) {

Callable event = events.front();

event.call();

events.pop();

}

}
