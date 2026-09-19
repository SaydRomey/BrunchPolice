# Entities/PlayerHub.gd
extends CharacterBody2D

const SPEED: float = 250.0

@onready var interaction_area: Area2D = $InteractionArea


func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector(
		&"move_left",
		&"move_right",
		&"move_up",
		&"move_down"
	)
	velocity = direction * SPEED
	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if not event.is_action_pressed(&"interact"):
		return
	
	var viewport := get_viewport()
	if viewport != null:
		viewport.set_input_as_handled()
	
	_try_interact()
	

func _try_interact() -> void:
	# Gather all the zones (NPCs) in the InteractionArea of the player
	for area: Area2D in interaction_area.get_overlapping_areas():
		var target: Node = area

		if not target.has_method(&"interact"):
			target = area.get_parent()
		
		# If the zone has an 'interact' method (It's an NPC)
		if target != null and target.has_method(&"interact"):
			target.call(&"interact")
			return # We interact with only one NPC at a time
