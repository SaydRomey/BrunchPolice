## Interactive toggle with touch activation or an interact action, 
## a toggled signal and a live debug state label.
##
## The Inspector starts_on flag previews ON/OFF in the editor; 
## runtime is_on is initialized from that flag.

@tool
extends LE_Element2D
class_name LE_Switch

## Emitted after is_on changes; provides new boolean state for signals and control connections.
signal toggled(is_on: bool)

@export_group("Interaction")
## If true, entering the Area toggles immediately; otherwise press the interact action while inside.
@export var auto_activate_on_touch: bool = true
## Author-time initial switch state; also drives the ON/OFF editor preview.
@export var starts_on: bool = false:
	set(value):
		starts_on = value
		if Engine.is_editor_hint():
			_refresh()

## Runtime toggle state; initialized from starts_on when the scene runs.
var is_on: bool = false
## Whether a CharacterBody2D is currently within the switch Area.
var _actor_inside: bool = false


## Synchronizes its Area, initializes runtime [member is_on] from [member starts_on], refreshes the state label and connects body events.
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


## Returns ON/OFF for the DebugLabel. Uses starts_on in the editor and runtime is_on while playing.
func _get_debug_state_text() -> String:
	var current_state := starts_on if Engine.is_editor_hint() else is_on
	return "ON" if current_state else "OFF"


## Updates the shared debug text and placeholder, then synchronizes Area dimensions.
func _refresh() -> void:
	super._refresh()
	_sync_shape()


## Resizes the switch interaction rectangle to [member element_size].
func _sync_shape() -> void:
	if not is_inside_tree():
		return
	var node := get_node_or_null("Area/CollisionShape2D") as CollisionShape2D
	if node != null and node.shape is RectangleShape2D:
		(node.shape as RectangleShape2D).size = element_size


## Records a CharacterBody2D in range; toggles immediately when auto_activate_on_touch is enabled.
func _on_enter(body: Node2D) -> void:
	if not body is CharacterBody2D:
		return
	_actor_inside = true
	if auto_activate_on_touch:
		toggle()


## Clears the inside flag when a CharacterBody2D exits the interaction area.
func _on_exit(body: Node2D) -> void:
	if body is CharacterBody2D:
		_actor_inside = false


## When an actor is inside and touch activation is disabled, consumes the interact action to toggle the switch.
func _unhandled_input(event: InputEvent) -> void:
	if _actor_inside and not auto_activate_on_touch and event.is_action_pressed("interact"):
		toggle()
		get_viewport().set_input_as_handled()


## Flips runtime is_on, refreshes the DebugLabel and emits toggled(is_on) to connected elements.
func toggle() -> void:
	is_on = not is_on
	_refresh() # Update label
	toggled.emit(is_on)
