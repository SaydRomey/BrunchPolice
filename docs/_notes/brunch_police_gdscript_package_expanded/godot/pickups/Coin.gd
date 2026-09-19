extends Area2D
class_name CoinPickup

@export var resource_name: String = "coins"
@export var amount: int = 1
@export var collect_sfx_key: String = "coin"

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("player") and body.name != "Player":
		return
	var resource_manager := get_node_or_null("/root/GameResourceManager")
	if resource_manager != null and resource_manager.has_method("add_resource"):
		resource_manager.add_resource(resource_name, amount)
	var sound_manager := get_node_or_null("/root/SoundManager")
	if sound_manager != null and sound_manager.has_method("play_sfx") and collect_sfx_key != "":
		sound_manager.play_sfx(collect_sfx_key)
	queue_free()
