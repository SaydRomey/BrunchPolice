@tool
extends LE_Element2D
class_name LE_PlatformBase
## Platform logic shared by static, moving, collapsing, and conveyor variants.

@export_group("Collision")
@export var solid: bool = true:
	set(value):
		solid = value
		_refresh()
@export var one_way: bool = false:
	set(value):
		one_way = value
		_refresh()

func _refresh() -> void:
	super._refresh()
	if not is_inside_tree():
		return
	var collider := get_node_or_null("Body/CollisionShape2D") as CollisionShape2D
	if collider == null:
		return
	# RectangleShape2D in each .tscn is marked resource_local_to_scene.
	var rect := collider.shape as RectangleShape2D
	if rect != null:
		rect.size = element_size
	collider.one_way_collision = one_way
	if not Engine.is_editor_hint():
		collider.disabled = not solid
