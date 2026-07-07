# scripts/IsoLevel.gd
extends Node2D

const TILE_W := 96.0
const TILE_H := 48.0
const ORIGIN: Vector2 = Vector2(640, 130)

var floor_tiles: Array[Vector2i] = []
var blocked_cells: Dictionary = {}

func _ready() -> void:
	z_as_relative = false
	_build_floor()
	_build_props()
	queue_redraw()

func iso_to_screen(cell: Vector2i) -> Vector2:
	return ORIGIN + Vector2((cell.x - cell.y) * TILE_W * 0.5, (cell.x + cell.y) * TILE_H * 0.5)

func _build_floor() -> void:
	for x in range(-2, 11):
		for y in range(-2, 9):
			if x + y < -2 or x + y > 16:
				continue
			floor_tiles.append(Vector2i(x, y))

func _build_props() -> void:
	# Blocked brunch furniture cells. These are visual and collision props.
	var props := [
		{"cell": Vector2i(2, 1), "name": "Pancake Table", "color": Color(0.95, 0.70, 0.32), "size": Vector2(64, 28)},
		{"cell": Vector2i(5, 2), "name": "Waffle Booth", "color": Color(0.78, 0.42, 0.16), "size": Vector2(78, 30)},
		{"cell": Vector2i(7, 5), "name": "Juice Stand", "color": Color(1.0, 0.46, 0.14), "size": Vector2(70, 34)},
		{"cell": Vector2i(3, 6), "name": "Bagel Cart", "color": Color(0.84, 0.54, 0.22), "size": Vector2(68, 28)}
	]
	for p in props:
		blocked_cells[p.cell] = true
		_add_prop(p.cell, p.name, p.color, p.size)

func _add_prop(cell: Vector2i, label_text: String, color: Color, size: Vector2) -> void:
	var pos := iso_to_screen(cell)
	var body := StaticBody2D.new()
	body.position = pos + Vector2(0, -14)
	body.z_index = int(body.position.y)
	add_child(body)
	var col := CollisionShape2D.new()
	var shape := RectangleShape2D.new()
	shape.size = size
	col.shape = shape
	col.position = Vector2(0, 8)
	body.add_child(col)
	var visual := ColorRect.new()
	visual.size = size
	visual.position = -size * 0.5
	visual.color = color
	body.add_child(visual)
	var top := Polygon2D.new()
	top.polygon = PackedVector2Array([Vector2(0,-28), Vector2(size.x*0.55,-6), Vector2(0,16), Vector2(-size.x*0.55,-6)])
	top.color = color.lightened(0.22)
	body.add_child(top)
	var label := Label.new()
	label.text = label_text
	label.position = Vector2(-55, -60)
	label.modulate = Color(0.18, 0.12, 0.08)
	body.add_child(label)

func _draw() -> void:
	for cell: Vector2i in floor_tiles:
		var p: Vector2 = iso_to_screen(cell)
		var poly := PackedVector2Array([
			p + Vector2(0, -TILE_H * 0.5),
			p + Vector2(TILE_W * 0.5, 0),
			p + Vector2(0, TILE_H * 0.5),
			p + Vector2(-TILE_W * 0.5, 0)
		])

		var checker: bool = ((cell.x + cell.y) % 2) == 0
		var fill: Color = Color(0.98, 0.82, 0.48) if checker else Color(0.95, 0.75, 0.38)

		draw_colored_polygon(poly, fill)
		draw_polyline(
			poly + PackedVector2Array([poly[0]]),
			Color(0.55, 0.33, 0.14, 0.32),
			1.0
		)

	for cell: Vector2i in [
		Vector2i(0, 4),
		Vector2i(1, 4),
		Vector2i(2, 4),
		Vector2i(4, 4),
		Vector2i(5, 4),
		Vector2i(6, 4),
		Vector2i(8, 4),
		Vector2i(9, 4)
	]:
		var p: Vector2 = iso_to_screen(cell)
		draw_circle(p, 5.0, Color(1.0, 0.95, 0.72, 0.7))
