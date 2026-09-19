# enemies/enemy_data.gd
class_name EnemyData
extends Resource

@export var enemy_id := ""
@export var display_name := ""
@export var level_source := ""
@export var enemy_class := ""

@export var max_health := 3
@export var speed := 90.0
@export var damage := 1
@export var detection_range := 220.0
@export var attack_range := 32.0
@export var attack_cooldown := 0.8
@export var knockback_force := 320.0
@export var gravity := 4000.0

@export var movement_behavior := "patrol"
@export var attack_behavior := "contact"
@export var status_resistances: Array[String] = []
@export var drops: Array[PackedScene] = []
@export_multiline var notes := ""
