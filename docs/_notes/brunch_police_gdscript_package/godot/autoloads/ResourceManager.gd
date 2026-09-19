extends Node
class_name BPResourceManager

signal resource_loaded(path: String)
signal resource_unloaded(path: String)
signal cache_cleared()

var resource_cache: Dictionary = {}

func load_resource(path: String) -> Resource:
	if path.is_empty():
		return null
	if resource_cache.has(path):
		return resource_cache[path]

	var resource := load(path)
	if resource == null:
		push_warning("Failed to load resource: %s" % path)
		return null

	resource_cache[path] = resource
	resource_loaded.emit(path)
	return resource

func preload_resources(paths: Array[String]) -> void:
	for path in paths:
		load_resource(path)

func unload_resource(path: String) -> void:
	if resource_cache.erase(path):
		resource_unloaded.emit(path)

func is_resource_loaded(path: String) -> bool:
	return resource_cache.has(path)

func clear_cache() -> void:
	resource_cache.clear()
	cache_cleared.emit()
