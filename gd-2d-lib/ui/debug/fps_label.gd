extends Label

@export var target_node: Node2D # Drag your Player or Camera here in the Inspector

func _process(delta: float) -> void:
	#text = "FPS: %d" % Engine.get_frames_per_second()
	#text += "\nAverage FPS: %d" % int(1.0 / delta)

# Update Position tracking if a target exists
	if is_instance_valid(target_node):
		var pos = target_node.global_position
		text = "Pos X: %d | Y: %d" % [int(pos.x), int(pos.y)]
	else:
		text = "Pos: No Target Assigned"
