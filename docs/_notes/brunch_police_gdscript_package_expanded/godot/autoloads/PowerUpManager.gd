extends Node
class_name PowerUpManager

signal powerup_activated(name: String, duration: float)
signal powerup_expired(name: String)

var active_powerups: Dictionary = {}

func _process(delta: float) -> void:
	var expired: Array[String] = []
	for powerup_name in active_powerups.keys():
		active_powerups[powerup_name]["remaining"] -= delta
		if active_powerups[powerup_name]["remaining"] <= 0.0:
			expired.append(powerup_name)

	for powerup_name in expired:
		_expire_powerup(powerup_name)

func activate_powerup(powerup_name: String, duration: float, on_apply: Callable = Callable(), on_expire: Callable = Callable(), data: Dictionary = {}) -> void:
	active_powerups[powerup_name] = {
		"duration": duration,
		"remaining": duration,
		"on_expire": on_expire,
		"data": data.duplicate(true)
	}
	if on_apply.is_valid():
		on_apply.call(data)
	powerup_activated.emit(powerup_name, duration)

func has_powerup(powerup_name: String) -> bool:
	return active_powerups.has(powerup_name)

func get_remaining_time(powerup_name: String) -> float:
	return float(active_powerups.get(powerup_name, {}).get("remaining", 0.0))

func cancel_powerup(powerup_name: String) -> void:
	if active_powerups.has(powerup_name):
		_expire_powerup(powerup_name)

func clear_all() -> void:
	for powerup_name in active_powerups.keys():
		_expire_powerup(powerup_name)

func _expire_powerup(powerup_name: String) -> void:
	var info: Dictionary = active_powerups.get(powerup_name, {})
	active_powerups.erase(powerup_name)
	var on_expire: Callable = info.get("on_expire", Callable())
	if on_expire.is_valid():
		on_expire.call(info.get("data", {}))
	powerup_expired.emit(powerup_name)
