extends Node
class_name VisualEffectsManager

signal effect_preloaded(key: String, path: String)
signal effect_created(key: String, effect: Node)
signal effects_cleared()

var effect_templates: Dictionary = {}

func preload_effect(key: String, path: String) -> void:
	var resource := load(path)
	if resource == null:
		push_warning("Failed to preload visual effect: %s" % path)
		return
	effect_templates[key] = resource
	effect_preloaded.emit(key, path)

func create_effect(key: String, position: Vector2, scale_value: Vector2 = Vector2.ONE, parent: Node = null) -> Node:
	if not effect_templates.has(key):
		push_warning("Visual effect not found: %s" % key)
		return null

	var resource: Resource = effect_templates[key]
	var effect_node: Node = null
	if resource is PackedScene:
		effect_node = (resource as PackedScene).instantiate()
	else:
		push_warning("Visual effect must be a PackedScene: %s" % key)
		return null

	var target_parent := parent if parent != null else self
	target_parent.add_child(effect_node)
	if effect_node is Node2D:
		effect_node.global_position = position
		effect_node.scale = scale_value
	if effect_node is GPUParticles2D:
		effect_node.emitting = true
	elif effect_node is CPUParticles2D:
		effect_node.emitting = true
	elif effect_node.has_method("play"):
		effect_node.call("play")

	effect_created.emit(key, effect_node)
	return effect_node

func clear_effects() -> void:
	for child in get_children():
		child.queue_free()
	effects_cleared.emit()
