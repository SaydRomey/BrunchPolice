extends CanvasLayer


func _ready() -> void:
	# Automatically shuts down the entire debug UI block in final production release builds
	if not OS.is_debug_build():
		queue_free() 
