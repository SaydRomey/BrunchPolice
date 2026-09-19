extends Node
class_name GameResourceManager

signal resource_changed(name: String, value: int, limit: int)

var resources: Dictionary = {}
var resource_limits: Dictionary = {}

func set_resource_limit(resource_name: String, limit: int) -> void:
	resource_limits[resource_name] = limit
	if resources.has(resource_name):
		resources[resource_name] = clampi(resources[resource_name], 0, limit)
	resource_changed.emit(resource_name, get_resource(resource_name), get_resource_limit(resource_name))

func add_resource(resource_name: String, amount: int) -> int:
	resources[resource_name] = get_resource(resource_name) + amount
	_apply_limits(resource_name)
	resource_changed.emit(resource_name, get_resource(resource_name), get_resource_limit(resource_name))
	return get_resource(resource_name)

func subtract_resource(resource_name: String, amount: int) -> int:
	resources[resource_name] = max(0, get_resource(resource_name) - amount)
	resource_changed.emit(resource_name, get_resource(resource_name), get_resource_limit(resource_name))
	return get_resource(resource_name)

func set_resource(resource_name: String, amount: int) -> void:
	resources[resource_name] = amount
	_apply_limits(resource_name)
	resource_changed.emit(resource_name, get_resource(resource_name), get_resource_limit(resource_name))

func get_resource(resource_name: String) -> int:
	return int(resources.get(resource_name, 0))

func get_resource_limit(resource_name: String) -> int:
	return int(resource_limits.get(resource_name, -1))

func is_resource_full(resource_name: String) -> bool:
	var limit := get_resource_limit(resource_name)
	return limit >= 0 and get_resource(resource_name) >= limit

func is_resource_empty(resource_name: String) -> bool:
	return get_resource(resource_name) <= 0

func get_state() -> Dictionary:
	return {
		"resources": resources.duplicate(true),
		"limits": resource_limits.duplicate(true)
	}

func set_state(state: Dictionary) -> void:
	resources = state.get("resources", {}).duplicate(true)
	resource_limits = state.get("limits", {}).duplicate(true)
	for resource_name in resources.keys():
		resource_changed.emit(resource_name, get_resource(resource_name), get_resource_limit(resource_name))

func _apply_limits(resource_name: String) -> void:
	if resource_limits.has(resource_name):
		resources[resource_name] = clampi(resources[resource_name], 0, resource_limits[resource_name])
	else:
		resources[resource_name] = max(0, resources[resource_name])
