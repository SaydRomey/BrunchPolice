extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.has_method("_respawn"):
		body._respawn()

func _draw() -> void:
	draw_rect(Rect2(-80, -16, 160, 32), Color(0.55, 0.22, 0.08, 1.0))
	draw_rect(Rect2(-72, -12, 144, 24), Color(0.95, 0.45, 0.12, 0.9))
