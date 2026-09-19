extends Node
class_name EventQueue

signal event_added(queue_size: int)
signal event_started(index: int)
signal event_finished(index: int)
signal queue_finished()

var _events: Array[Dictionary] = []
var _is_running: bool = false

func add_event(event: Callable) -> void:
	if event.is_valid():
		_events.append({"type": "callback", "callback": event})
		event_added.emit(_events.size())

func add_delay(seconds: float) -> void:
	_events.append({"type": "delay", "duration": maxf(0.0, seconds)})
	event_added.emit(_events.size())

func execute_next_event() -> void:
	if _events.is_empty():
		queue_finished.emit()
		return
	await _run_event(_events.pop_front(), 0)
	if _events.is_empty():
		queue_finished.emit()

func execute_all() -> void:
	if _is_running:
		return
	_is_running = true
	var index := 0
	while not _events.is_empty():
		await _run_event(_events.pop_front(), index)
		index += 1
	_is_running = false
	queue_finished.emit()

func clear() -> void:
	_events.clear()
	_is_running = false

func get_queue_size() -> int:
	return _events.size()

func _run_event(event: Dictionary, index: int) -> void:
	event_started.emit(index)
	match String(event.get("type", "callback")):
		"delay":
			await get_tree().create_timer(float(event.get("duration", 0.0))).timeout
		_:
			var callback: Callable = event.get("callback", Callable())
			if callback.is_valid():
				callback.call()
	event_finished.emit(index)
