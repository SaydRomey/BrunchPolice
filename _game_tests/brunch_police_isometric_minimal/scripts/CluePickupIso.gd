extends Area2D

@export var clue_name := "Clue"
var collected := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	z_as_relative = false

func _process(delta: float) -> void:
	rotation += delta * 1.6
	z_index = int(global_position.y)

func _on_body_entered(body: Node) -> void:
	if collected:
		return
	if body.has_method("add_clue"):
		collected = true
		body.add_clue()
		queue_free()

func _draw() -> void:
	var diamond := PackedVector2Array([Vector2(0,-16), Vector2(18,0), Vector2(0,16), Vector2(-18,0)])
	draw_colored_polygon(diamond, Color(1.0, 0.82, 0.16, 1.0))
	draw_polyline(diamond + PackedVector2Array([diamond[0]]), Color(0.46, 0.20, 0.82, 1.0), 3.0)
	draw_circle(Vector2.ZERO, 5.0, Color(0.46, 0.20, 0.82, 1.0))
