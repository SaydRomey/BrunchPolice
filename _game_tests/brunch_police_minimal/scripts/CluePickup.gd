extends Area2D

@export var clue_name := "Clue"
var collected := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if collected:
		return
	if body.has_method("add_clue"):
		collected = true
		body.add_clue()
		queue_free()

func _process(delta: float) -> void:
	rotation += delta * 1.8

func _draw() -> void:
	draw_circle(Vector2.ZERO, 14.0, Color(1.0, 0.82, 0.22, 1.0))
	draw_circle(Vector2.ZERO, 7.0, Color(0.55, 0.22, 0.95, 1.0))
