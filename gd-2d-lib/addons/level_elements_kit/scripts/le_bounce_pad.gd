@tool
extends LE_PlatformBase
class_name LE_BouncePad

signal actor_launched(actor: Node2D, launch_velocity: Vector2)

@export_group("Launch")
@export var launch_velocity: Vector2 = Vector2(0, -520)

func _ready() -> void:
	super._ready()
	_sync_trigger()
	if not Engine.is_editor_hint():
		(get_node("Trigger") as Area2D).body_entered.connect(_on_enter)

func _refresh() -> void:
	super._refresh()
	_sync_trigger()

func _sync_trigger() -> void:
	if not is_inside_tree():
		return
	var shape_node := get_node_or_null("Trigger/CollisionShape2D") as CollisionShape2D
	if shape_node != null:
		var rect := shape_node.shape as RectangleShape2D
		if rect != null:
			rect.size = Vector2(element_size.x, 8)
		shape_node.position = Vector2(0, -element_size.y * 0.5 - 4)

func _on_enter(body: Node2D) -> void:
	if not body is CharacterBody2D:
		return
	
	if body.velocity.y < -1.0:
		return
	
	if body.has_method("apply_launch"):
		body.call("apply_launch", launch_velocity)
	else:
		(body as CharacterBody2D).velocity = launch_velocity
		#body.velocity = launch_velocity
	
	actor_launched.emit(body, launch_velocity)
