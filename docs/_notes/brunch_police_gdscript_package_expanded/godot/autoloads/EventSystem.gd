extends Node
class_name EventSystem

signal event_triggered(event_name: String, payload: Dictionary)

var _listeners: Dictionary = {}

func register_event(event_name: String, callback: Callable) -> void:
	if event_name.is_empty() or not callback.is_valid():
		return
	if not _listeners.has(event_name):
		_listeners[event_name] = []
	var callbacks: Array = _listeners[event_name]
	if not callbacks.has(callback):
		callbacks.append(callback)
	_listeners[event_name] = callbacks

func unregister_event(event_name: String, callback: Callable) -> void:
	if not _listeners.has(event_name):
		return
	var callbacks: Array = _listeners[event_name]
	callbacks.erase(callback)
	if callbacks.is_empty():
		_listeners.erase(event_name)
	else:
		_listeners[event_name] = callbacks

func trigger_event(event_name: String, payload: Dictionary = {}) -> void:
	if _listeners.has(event_name):
		var callbacks: Array = _listeners[event_name].duplicate()
		for callback in callbacks:
			if callback.is_valid():
				callback.call(payload)
	event_triggered.emit(event_name, payload)

func clear_event(event_name: String) -> void:
	_listeners.erase(event_name)

func clear_all_events() -> void:
	_listeners.clear()
