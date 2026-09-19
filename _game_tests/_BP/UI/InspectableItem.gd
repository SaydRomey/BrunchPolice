# UI/InspectableItem.gd
extends Area2D

# Default is non-suspicious/decoy items
# Change the values in the editor for suspicious items
@export var is_suspicious: bool = false
@export var feedback_text: String = "Nothing supicious here."

var already_inspected: bool = false

@onready var inspection_mode: Node2D = get_node("../..")


# This signal of Area2D triggers when the mouse interacts with the zone
func _on_input_event(
	_viewport: Node,
	event: InputEvent,
	_shape_idx: int
) -> void:
	if not (
		event is InputEventMouseButton
		and event.button_index == MOUSE_BUTTON_LEFT
		and event.pressed
	):
		return
	
	if already_inspected:
		inspection_mode.call(
			&"show_feedback",
			"Evidence already noted."
		)
		return
	
	already_inspected = true
	
	inspection_mode.call(
		&"element_inspected",
		is_suspicious,
		feedback_text
	)
	
	# TODO: Use signals later instead
