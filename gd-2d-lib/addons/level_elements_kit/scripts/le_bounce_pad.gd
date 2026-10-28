@tool
extends LE_PlatformBase
class_name LE_BouncePad

signal actor_launched(actor: Node2D, launch_velocity: Vector2)

@export_group("Launch")
@export var launch_velocity: Vector2 = Vector2(0, -520)
@export_range(1.0, 3.0, 0.1) var jump_boost_multiplier: float = 1.6
@export_range(0.05, 0.40, 0.01) var boost_window_seconds: float = 0.15


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

	var actor := body as CharacterBody2D

	# Only bounce when landing on the pad.
	if actor.velocity.y < 0.0:
		return
	
	# Step 1: Always perform the normal bounce.
	if body.has_method("apply_launch"):
		body.call("apply_launch", launch_velocity)
	else:
		actor.velocity = launch_velocity

	# Step 2: Calculate a possible extra jump impulse.
	if (
		body.has_method("get_base_jump_impulse")
		and body.has_method("start_bounce_boost_window")
	):
		var base_jump: float = float(
			body.call("get_base_jump_impulse")
		)

		var normal_up_speed: float = absf(launch_velocity.y)

		var boosted_up_speed: float = maxf(
			normal_up_speed,
			base_jump * jump_boost_multiplier
		)

		var extra_impulse: float = (
			boosted_up_speed - normal_up_speed
		)

		# Player handles the timing and fresh Jump input.
		body.call(
			"start_bounce_boost_window",
			boost_window_seconds,
			extra_impulse
		)

	actor_launched.emit(body, launch_velocity)
