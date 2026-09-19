# ui/camera_2d.gd
extends Camera2D

@export var target: CharacterBody2D


func _ready() -> void:
	make_current()


func _process(_delta: float) -> void:
	if target:
		global_position = target.global_position
