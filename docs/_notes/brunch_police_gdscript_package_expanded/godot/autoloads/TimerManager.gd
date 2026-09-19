extends Node
class_name TimerManager

signal timer_added(id: int, duration: float, repeat: bool)
signal timer_finished(id: int)
signal timers_cleared()

var _timed_events: Array[Dictionary] = []
var _next_id: int = 1

func _process(delta: float) -> void:
	var finished_indices: Array[int] = []
	for i in range(_timed_events.size()):
		var event := _timed_events[i]
		event["remaining"] -= delta
		_timed_events[i] = event
		if event["remaining"] <= 0.0:
			var callback: Callable = event["callback"]
			if callback.is_valid():
				callback.call()
			timer_finished.emit(event["id"])
			if event["repeat"]:
				event["remaining"] += event["duration"]
				_timed_events[i] = event
			else:
				finished_indices.append(i)

	for j in range(finished_indices.size() - 1, -1, -1):
		_timed_events.remove_at(finished_indices[j])

func add_timer(duration: float, callback: Callable, repeat: bool = false) -> int:
	var id := _next_id
	_next_id += 1
	_timed_events.append({
		"id": id,
		"duration": maxf(0.0, duration),
		"remaining": maxf(0.0, duration),
		"callback": callback,
		"repeat": repeat
	})
	timer_added.emit(id, duration, repeat)
	return id

func cancel_timer(id: int) -> bool:
	for i in range(_timed_events.size()):
		if _timed_events[i]["id"] == id:
			_timed_events.remove_at(i)
			return true
	return false

func clear_all_timers() -> void:
	_timed_events.clear()
	timers_cleared.emit()
