extends Label

@export var target_node: Node2D # Drag your Player or Camera here in the Inspector


func _ready() -> void:
	# Wait brief frame initialization to ensure the main level scene is loaded
	await get_tree().process_frame
	
	# Safely fetch the first node tagged in the "player" group
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		target_node = players[0] as Node2D
	else:
		push_warning("Debug Position Label: No node found in the 'player' group!")

func _process(_delta: float) -> void:
	if is_instance_valid(target_node):
		var pos = target_node.global_position
		text = "Pos X: %d | Y: %d" % [int(pos.x), int(pos.y)]
	else:
		text = "Pos: Searching for Target..."


#todo: mouse pos label:
#
#func _process(delta: float) -> void:
	#var mouse_pos = get_global_mouse_position()
	#text = "X: %d | Y: %d" % [int(mouse_pos.x), int(mouse_pos.y)]
