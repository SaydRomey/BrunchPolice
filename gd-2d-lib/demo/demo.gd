extends Node2D

func _ready() -> void:
	$Switch.toggled.connect($Conveyor.set_enabled)
	$Conveyor.set_enabled(false)
	$Collectible.collected.connect(_on_collected)

func _on_collected(actor: Node2D, _item_id: String, value: int) -> void:
	if actor.has_method("add_score"):
		actor.call("add_score", value)
