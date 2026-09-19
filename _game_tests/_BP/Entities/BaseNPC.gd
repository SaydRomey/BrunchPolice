# Entities/StaticBaseNPC.gd
class_name BaseNPC
extends CharacterBody2D

signal interacted(npc: BaseNPC)
signal dialogue_requested(
	npc: BaseNPC,
	speaker_name: String,
	text: String
)

@export_category("Identity")
@export var npc_name: String = ""
@export var npc_type: String = "NPC"

@export_category("Dialogue")
@export var dialogues: Array[String] = []

@export_category("Interaction")
@export var interaction_enabled: bool = true

@onready var npc_sprite: Sprite2D = %Sprite2D
@onready var body_collision: CollisionShape2D = %BodyCollision
@onready var interact_area: Area2D = %InteractArea
@onready var name_label: Label = %NameLabel


func _ready() -> void:
	refresh_name_label()
	set_interaction_enabled(interaction_enabled)


func interact() -> void:
	if not can_interact():
		return
	
	_on_interaction_started()
	
	var phrase := get_random_dialogue()
	
	if not phrase.is_empty():
		say(phrase)
	
	# Emit before the subclass potentially changes scenes.
	interacted.emit(self)
	
	_on_interaction_finished(phrase)


func can_interact() -> bool:
	return interaction_enabled


func get_random_dialogue() -> String:
	if dialogues.is_empty():
		return ""
		
	return String(dialogues.pick_random())


func say(text: String) -> void:
	var speaker_name := get_display_name()
	
	dialogue_requested.emit(
		self,
		speaker_name,
		text
	)
	
	# Temporary fallback until dialogue UI is connected.
	print("%s says: %s" % [speaker_name, text])


func get_display_name() -> String:
	if not npc_name.is_empty():
		return npc_name
		
	if not npc_type.is_empty():
		return npc_type
		
	return str(name)


func refresh_name_label() -> void:
	if name_label != null:
		name_label.text = get_display_name()


func set_interaction_enabled(enabled: bool) -> void:
	interaction_enabled = enabled
	
	if interact_area != null:
		interact_area.monitorable = enabled
		
	if %InteractionCollision != null:
		%InteractionCollision.disabled = not enabled


# Subclasses override these hooks instead of replacing interact().
func _on_interaction_started() -> void:
	pass


func _on_interaction_finished(_phrase: String) -> void:
	pass
