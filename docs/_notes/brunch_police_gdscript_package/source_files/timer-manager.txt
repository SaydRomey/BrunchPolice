Timer Manager

A central manager for timed events:

Delayed actions like explosions or triggers.

Cooldowns for abilities or power-ups.

Timer Manager

Purpose:

Centralized management of timed events.

Handle delayed actions like explosions, triggers, or cooldowns for
abilities/power-ups.

Allow modular and reusable timing logic.

---

Class Design

Header File (TimerManager.h)

#ifndef TIMER_MANAGER_H

#define TIMER_MANAGER_H

#include <godot_cpp/classes/node.hpp>

#include <godot_cpp/classes/timer.hpp>

#include <vector>

using namespace godot;

class TimerManager : public Node {

GDCLASS(TimerManager, Node);

private:

struct TimedEvent {

Callable callback;

float remaining_time;

bool repeat;

};

std::vector<TimedEvent> timed_events;

public:

void _init();

void _process(float delta);

void add_timer(float duration, Callable callback, bool repeat = false);

void clear_all_timers();

};

#endif // TIMER_MANAGER_H

Implementation File (TimerManager.cpp)

#include "TimerManager.h"

void TimerManager::_init() {

timed_events.clear();

}

void TimerManager::_process(float delta) {

for (size_t i = 0; i < timed_events.size(); ++i) {

TimedEvent &event = timed_events[i];

event.remaining_time -= delta;

if (event.remaining_time <= 0.0f) {

event.callback.call(); // Trigger the callback

if (event.repeat) {

event.remaining_time += event.remaining_time; // Reset timer

} else {

timed_events.erase(timed_events.begin() + i);

--i; // Adjust index after removal

}

}

}

}

void TimerManager::add_timer(float duration, Callable callback, bool
repeat) {

TimedEvent event = {callback, duration, repeat};

timed_events.push_back(event);

}

void TimerManager::clear_all_timers() {

timed_events.clear();

}

---

Usage

1. Add the TimerManager to your game scene as a child node.

2. Use add_timer to schedule events.

Example:

Ref<TimerManager> timer_manager =
get_node<TimerManager>("/root/TimerManager");

// Add a one-time timer

timer_manager->add_timer(3.0f, Callable(this,
"on_explosion_triggered"));

// Add a repeating timer

timer_manager->add_timer(1.0f, Callable(this, "on_cooldown_ready"),
true);

Callback Example:

void on_explosion_triggered() {

Godot::print("Explosion triggered!");

}

void on_cooldown_ready() {

Godot::print("Ability cooldown ready!");

}
