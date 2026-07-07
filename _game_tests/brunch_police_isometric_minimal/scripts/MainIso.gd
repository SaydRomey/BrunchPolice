# scripts/MainIso.gd
extends Node2D

@onready var level: Node2D = $World/IsoLevel
@onready var player: CharacterBody2D = $World/Player
@onready var clue_label: Label = $CanvasLayer/HUD/VBoxContainer/ClueLabel
@onready var status_label: Label = $CanvasLayer/HUD/VBoxContainer/StatusLabel
@onready var toast: Label = $CanvasLayer/HUD/VBoxContainer/Toast

var total_clues := 0

func _ready() -> void:
	$World.y_sort_enabled = true
	player.clue_collected.connect(_on_clue_collected)
	player.player_respawned.connect(_on_player_respawned)
	_create_clues()
	_create_hazards()
	_update_hud(0)
	toast.text = "Brunch Area prototype: collect 5 clues and avoid syrup spills."

func _create_clues() -> void:
	var clue_scene := preload("res://scenes/CluePickupIso.tscn")
	var cells := [Vector2i(0, 2), Vector2i(4, 0), Vector2i(6, 3), Vector2i(1, 7), Vector2i(9, 6)]
	total_clues = cells.size()
	for i in cells.size():
		var clue := clue_scene.instantiate()
		clue.position = level.iso_to_screen(cells[i]) + Vector2(0, -18)
		clue.clue_name = "Brunch Clue %d" % (i + 1)
		$World.add_child(clue)

func _create_hazards() -> void:
	var hazard_scene := preload("res://scenes/SyrupHazardIso.tscn")
	for cell in [Vector2i(4, 4), Vector2i(8, 2), Vector2i(6, 7)]:
		var hazard := hazard_scene.instantiate()
		hazard.position = level.iso_to_screen(cell)
		$World.add_child(hazard)

func _on_clue_collected(amount: int) -> void:
	_update_hud(amount)
	if amount >= total_clues:
		toast.text = "Case closed: brunch-area evidence secured."
	else:
		toast.text = "Clue logged. Sweep the next table."

func _on_player_respawned() -> void:
	toast.text = "Syrup spill. Returned to starting tile."

func _update_hud(amount: int) -> void:
	clue_label.text = "Clues: %d / %d" % [amount, total_clues]
	status_label.text = "Controls: WASD/arrows move on iso grid | Shift run"
