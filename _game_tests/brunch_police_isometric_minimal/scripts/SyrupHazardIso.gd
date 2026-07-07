# scripts/SyrupHazardIso.gd
extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	z_as_relative = false

func _process(_delta: float) -> void:
	z_index = int(global_position.y) - 1

func _on_body_entered(body: Node) -> void:
	if body.has_method("respawn"):
		body.respawn()

func _draw() -> void:
	var poly := PackedVector2Array([Vector2(0,-18), Vector2(64,0), Vector2(0,22), Vector2(-64,0)])
	draw_colored_polygon(poly, Color(0.55, 0.22, 0.08, 0.98))
	draw_polyline(poly + PackedVector2Array([poly[0]]), Color(1.0, 0.50, 0.12, 1.0), 4.0)
	draw_circle(Vector2(18,1), 8.0, Color(0.95, 0.45, 0.12, 0.85))
	draw_circle(Vector2(-24,2), 6.0, Color(0.95, 0.45, 0.12, 0.85))
