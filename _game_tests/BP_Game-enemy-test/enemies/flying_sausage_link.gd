# enemies/flying_sausage_link.gd
class_name FlyingSausageLink
extends FlyingEnemy


func _ready() -> void:
	super()

	enemy_id = "flying_sausage_link"
	display_name = "Flying Sausage Link"
	level_source = "Grease Canyon"
	enemy_class = "Flying swooper"
	max_health = max(max_health, 1)
	health = max_health
