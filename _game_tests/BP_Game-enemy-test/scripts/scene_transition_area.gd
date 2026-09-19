# scripts/scene_transition_area.gd
class_name SceneTransitionArea extends Area2D

@export_file("*.tscn") var target_scene_path := ""
@export var required_group := "player"

var _is_transitioning := false


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node) -> void:
	if _is_transitioning:
		return

	if target_scene_path.is_empty():
		push_warning("SceneTransitionArea has no target_scene_path set.")
		return

	if not required_group.is_empty() and not body.is_in_group(required_group):
		return

	_is_transitioning = true
	get_tree().change_scene_to_file(target_scene_path)
