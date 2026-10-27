@tool
extends Resource
class_name LE_VisualPreset
## Optional shareable appearance preset. Editing a shared .tres changes every
## element that references it; use Make Unique for per-element customization.

@export var theme_name: String = "Custom"
@export var fill_color: Color = Color(0.31, 0.64, 0.91):
	set(value):
		fill_color = value
		emit_changed()
@export var texture: Texture2D:
	set(value):
		texture = value
		emit_changed()
@export var texture_tint: Color = Color.WHITE:
	set(value):
		texture_tint = value
		emit_changed()
