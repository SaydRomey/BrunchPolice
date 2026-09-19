extends Area2D
class_name Checkpoint

signal activated(checkpoint: Checkpoint)

@export var checkpoint_id: String = ""
@export var activate_once: bool = true
@export var manager_path: NodePath

var is_active: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func activate(body: Node = null) -> void:
	if activate_once and is_active:
		return
	is_active = true
	var manager := get_node_or_null(manager_path)
	if manager == null and get_tree().root.has_node("CheckpointSystem"):
		manager = get_node("/root/CheckpointSystem")
	if manager and manager.has_method("set_checkpoint"):
		manager.set_checkpoint(global_position, checkpoint_id)
	if manager and body and manager.has_method("save_player_state"):
		manager.save_player_state(body)
	activated.emit(self)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player") or body.name == "Player":
		activate(body)
