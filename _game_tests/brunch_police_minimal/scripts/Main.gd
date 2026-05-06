extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var clue_label: Label = $CanvasLayer/HUD/ClueLabel
@onready var status_label: Label = $CanvasLayer/HUD/StatusLabel
@onready var toast: Label = $CanvasLayer/HUD/Toast

var total_clues := 0

func _ready() -> void:
	_create_level()
	_create_clues()
	_create_hazards()
	player.clue_collected.connect(_on_clue_collected)
	player.player_respawned.connect(_on_player_respawned)
	_update_hud(0)
	toast.text = "Investigate the Brunch Zone. Collect 5 clues."

func _create_level() -> void:
	var platforms := [
		[Vector2(640, 660), Vector2(1350, 80), "Main Brunch Street"],
		[Vector2(360, 510), Vector2(240, 34), "Pancake Ledge"],
		[Vector2(690, 430), Vector2(230, 34), "Waffle Overpass"],
		[Vector2(1010, 350), Vector2(260, 34), "Toast Roof"],
		[Vector2(1340, 560), Vector2(300, 34), "Cafe Exit"]
	]
	for p in platforms:
		_add_platform(p[0], p[1], p[2])

func _add_platform(pos: Vector2, size: Vector2, label_text: String) -> void:
	var body := StaticBody2D.new()
	body.position = pos
	add_child(body)
	var shape := CollisionShape2D.new()
	var rect := RectangleShape2D.new()
	rect.size = size
	shape.shape = rect
	body.add_child(shape)
	var panel := ColorRect.new()
	panel.position = -size / 2.0
	panel.size = size
	panel.color = Color(0.95, 0.67, 0.28, 1.0)
	body.add_child(panel)
	var label := Label.new()
	label.text = label_text
	label.position = Vector2(-size.x / 2.0 + 8.0, -size.y / 2.0 - 26.0)
	body.add_child(label)

func _create_clues() -> void:
	var clue_scene := preload("res://scenes/CluePickup.tscn")
	var positions := [Vector2(260, 470), Vector2(690, 390), Vector2(1010, 310), Vector2(1350, 520), Vector2(1580, 615)]
	total_clues = positions.size()
	for i in positions.size():
		var clue := clue_scene.instantiate()
		clue.position = positions[i]
		clue.clue_name = "Clue %d" % (i + 1)
		add_child(clue)

func _create_hazards() -> void:
	var hazard_scene := preload("res://scenes/SyrupHazard.tscn")
	for pos in [Vector2(520, 625), Vector2(1180, 625)]:
		var hazard := hazard_scene.instantiate()
		hazard.position = pos
		add_child(hazard)

func _on_clue_collected(amount: int) -> void:
	_update_hud(amount)
	if amount >= total_clues:
		toast.text = "Case closed: brunch disturbance contained."
	else:
		toast.text = "Evidence logged. Keep moving."

func _on_player_respawned() -> void:
	toast.text = "Syrup spill! Returned to checkpoint."

func _update_hud(amount: int) -> void:
	clue_label.text = "Clues: %d / %d" % [amount, total_clues]
	status_label.text = "Controls: A/D or arrows move | Space/W jump | Shift sprint"
