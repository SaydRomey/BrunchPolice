extends CharacterBody2D
## Minimal demo player showing the optional contracts implemented by the kit.

@export var run_speed: float = 230.0
@export var jump_speed: float = 420.0
@export var gravity: float = 1050.0
@export var ground_acceleration: float = 1500.0

var checkpoint_position: Vector2 = Vector2(-190, 235)
var _surfaces: Dictionary = {}
var _collected_score: int = 0

func _ready() -> void:
	queue_redraw()

func _draw() -> void:
	draw_rect(Rect2(-11, -17, 22, 34), Color(1.0, 0.97, 0.91))
	draw_rect(Rect2(2, -9, 3, 3), Color(0.12, 0.12, 0.18))

func _physics_process(delta: float) -> void:
	var speed_factor := 1.0
	var traction_factor := 1.0
	for entry in _surfaces.values():
		speed_factor *= float(entry[0])
		traction_factor *= float(entry[1])
	if not is_on_floor():
		velocity.y += gravity * delta
	elif Input.is_action_just_pressed("ui_accept"):
		velocity.y = -jump_speed
	var direction := Input.get_axis("ui_left", "ui_right")
	var target_speed := direction * run_speed * speed_factor
	var accel := ground_acceleration * traction_factor
	velocity.x = move_toward(velocity.x, target_speed, accel * delta)
	move_and_slide()
	if global_position.y > 800.0:
		_respawn()

func apply_launch(new_velocity: Vector2) -> void:
	velocity = new_velocity

func receive_damage(_damage: int, _source: Vector2) -> void:
	_respawn()

func set_checkpoint(new_position: Vector2) -> void:
	checkpoint_position = new_position

func enter_surface(token: int, speed_factor: float, traction_factor: float) -> void:
	_surfaces[token] = [speed_factor, traction_factor]

func exit_surface(token: int) -> void:
	_surfaces.erase(token)

func _respawn() -> void:
	global_position = checkpoint_position
	velocity = Vector2.ZERO
	_surfaces.clear()

func add_score(value: int) -> void:
	_collected_score += value
	print("Demo score: ", _collected_score)
