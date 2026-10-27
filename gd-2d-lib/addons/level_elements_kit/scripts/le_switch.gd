@tool
extends LE_Element2D
class_name LE_Switch

signal toggled(is_on: bool)

@export_group("Interaction")
@export var auto_activate_on_touch: bool = true
@export var starts_on: bool = false:
	set(value):
		starts_on = value
		if Engine.is_editor_hint():
			_refresh()

var is_on: bool = false
var _actor_inside: bool = false


func _ready() -> void:
	super._ready()
	_sync_shape()
	if Engine.is_editor_hint():
		return
	
	is_on = starts_on
	_refresh() # Update label to show the initial state.
	
	var area := get_node("Area") as Area2D
	area.body_entered.connect(_on_enter)
	area.body_exited.connect(_on_exit)


func _get_debug_state_text() -> String:
	var current_state := starts_on if Engine.is_editor_hint() else is_on
	return "ON" if current_state else "OFF"


func _refresh() -> void:
	super._refresh()
	_sync_shape()


func _sync_shape() -> void:
	if not is_inside_tree():
		return
	var node := get_node_or_null("Area/CollisionShape2D") as CollisionShape2D
	if node != null and node.shape is RectangleShape2D:
		(node.shape as RectangleShape2D).size = element_size


func _on_enter(body: Node2D) -> void:
	if not body is CharacterBody2D:
		return
	_actor_inside = true
	if auto_activate_on_touch:
		toggle()


func _on_exit(body: Node2D) -> void:
	if body is CharacterBody2D:
		_actor_inside = false


func _unhandled_input(event: InputEvent) -> void:
	if _actor_inside and not auto_activate_on_touch and event.is_action_pressed("interact"):
		toggle()
		get_viewport().set_input_as_handled()


func toggle() -> void:
	is_on = not is_on
	_refresh() # Update label
	toggled.emit(is_on)
