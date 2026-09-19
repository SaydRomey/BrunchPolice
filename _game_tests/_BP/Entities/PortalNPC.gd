# Entities/PortalNPC.gd
extends Area2D

# Choose which level this NPC launches from inspector
@export var level_name: String = "Level: Test Zone"
@export_file("*.tscn") var level_to_load: String


func interact():
	if level_to_load != "":
		print("The culprit is fleeing !")
		# Save level info in the GameManager
		GameManager.target_level_path = level_to_load
		GameManager.target_level_name = level_name
	
		# Launching the inspection scene
		GameManager.goto_scene("res://UI/InspectionMode.tscn")
		#GameManager.goto_scene(level_to_load)
	else:
		print("Error: No level is assigned to this NPC.")
