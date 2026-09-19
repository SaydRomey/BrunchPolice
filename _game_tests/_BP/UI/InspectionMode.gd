# UI/InspectionMode.gd
extends Node2D

var suspicious_elements_found: int = 0
var inspection_completed: bool = false
const REQUIRED_ELEMENTS: int = 3

@onready var feedback_label: Label = %FeedbackLabel
@onready var progress_label: Label = %ProgressLabel
@onready var feedback_timer: Timer = $CanvasLayer/UI/FeedbackTimer


func _ready() -> void:
	# Hide texte initially
	feedback_label.text = ""
	feedback_label.visible = false
	_update_progress()


# This function will be called by the clickable objects
func element_inspected(
	is_suspicious: bool,
	feedback_text: String
) -> void:
	show_feedback(feedback_text)
	
	if not is_suspicious:
		return
	
	print("Suspicious evidence found ! Total : ", suspicious_elements_found)
	
	suspicious_elements_found += 1
	_update_progress()
	
	if suspicious_elements_found >= REQUIRED_ELEMENTS:
		trigger_chase()


func _update_progress() -> void:
	progress_label.text = "%d / %d" % [
		suspicious_elements_found,
		REQUIRED_ELEMENTS
	]


func show_feedback(text: String) -> void:
	feedback_label.text = text
	feedback_label.visible = true
	feedback_timer.start() # Make the text disappear after 3 seconds


func _on_feedback_timer_timeout() -> void:
	feedback_label.visible = false


func trigger_chase() -> void:
	if inspection_completed:
		return
	
	inspection_completed = true
	
	print("The culprit is fleeing !!")
	# Maybe play a little animation here (e.g., the NPC leaves the screen)
	
	# We load the transition screen to the level
	GameManager.goto_scene("res://UI/LevelTransition.tscn")
