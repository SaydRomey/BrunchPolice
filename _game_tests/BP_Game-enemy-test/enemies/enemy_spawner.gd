# enemies/enemy_spawner.gd
class_name EnemySpawner
extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_on_ready := false
@export var max_alive := 3
@export var spawn_count := 1
@export var respawn_delay := 2.0

var alive_enemies: Array[Node] = []
var _respawn_timer := 0.0


func _ready() -> void:
	if spawn_on_ready:
		spawn_enemies(spawn_count)


func _physics_process(delta: float) -> void:
	alive_enemies = alive_enemies.filter(func(enemy): return is_instance_valid(enemy))

	if alive_enemies.size() < max_alive and respawn_delay >= 0.0:
		_respawn_timer -= delta
		if _respawn_timer <= 0.0:
			spawn_enemies(1)
			_respawn_timer = respawn_delay


func get_spawn_points() -> Array[EnemySpawnPoint]:
	var points: Array[EnemySpawnPoint] = []

	for child in get_children():
		var point := child as EnemySpawnPoint
		if point != null and point.is_enabled:
			points.append(point)

	if points.is_empty():
		var fallback := EnemySpawnPoint.new()
		fallback.global_position = global_position
		points.append(fallback)

	return points


func spawn_enemies(count: int = 1) -> void:
	if enemy_scene == null:
		push_warning("EnemySpawner has no enemy_scene.")
		return

	var points := get_spawn_points()
	var spawned := 0

	for i in count:
		if alive_enemies.size() >= max_alive:
			return

		var point := points[i % points.size()]
		var enemy := enemy_scene.instantiate()
		get_tree().current_scene.add_child(enemy)
		enemy.global_position = point.global_position

		if enemy.has_signal("died"):
			enemy.died.connect(_on_enemy_died)

		alive_enemies.append(enemy)
		spawned += 1


func _on_enemy_died(enemy: Node) -> void:
	alive_enemies.erase(enemy)
