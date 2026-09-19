extends Node
class_name CheckpointSystem

signal checkpoint_set(position: Vector2, checkpoint_id: String)
signal player_respawned(player: Node, position: Vector2)

@export var default_spawn_position: Vector2 = Vector2.ZERO
@export var restore_health_on_respawn: bool = true

var last_checkpoint_position: Vector2 = Vector2.ZERO
var last_checkpoint_id: String = "default"
var saved_state: Dictionary = {}

func _ready() -> void:
	last_checkpoint_position = default_spawn_position

func set_checkpoint(position: Vector2, checkpoint_id: String = "") -> void:
	last_checkpoint_position = position
	last_checkpoint_id = checkpoint_id if not checkpoint_id.is_empty() else str(position)
	checkpoint_set.emit(last_checkpoint_position, last_checkpoint_id)

func save_player_state(player: Node) -> void:
	saved_state.clear()
	if player == null:
		return
	var health := _find_health_component(player)
	if health:
		saved_state["health"] = health.current_health

func get_last_checkpoint() -> Vector2:
	return last_checkpoint_position

func respawn_player(player: Node2D) -> void:
	if player == null:
		return
	player.global_position = last_checkpoint_position
	if player.get("velocity") != null:
		player.set("velocity", Vector2.ZERO)
	if restore_health_on_respawn:
		_restore_player_health(player)
	player_respawned.emit(player, last_checkpoint_position)

func _restore_player_health(player: Node) -> void:
	var health := _find_health_component(player)
	if health == null:
		return
	if saved_state.has("health"):
		health.current_health = clampf(float(saved_state["health"]), 1.0, health.max_health)
	else:
		health.current_health = health.max_health
	health.health_changed.emit(health.current_health, health.max_health)
	if health.has_method("clear_invincibility"):
		health.clear_invincibility()

func _find_health_component(player: Node) -> HealthComponent:
	if player is HealthComponent:
		return player
	return player.get_node_or_null("HealthComponent") as HealthComponent
