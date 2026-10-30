## Reusable resource containing a theme name, 
## a placeholder fill color and optional texture/tint.
##
## Appearance setters call [method Resource.emit_changed] 
## so sharing elements can refresh their visuals.

@tool
extends Resource
class_name LE_VisualPreset
## Optional shareable appearance preset. Editing a shared .tres changes every
## element that references it; use Make Unique for per-element customization.

## Friendly name for this reusable appearance resource.
@export var theme_name: String = "Custom"
## Theme placeholder fill color; changing it emits Resource.changed.
@export var fill_color: Color = Color(0.31, 0.64, 0.91):
	set(value):
		fill_color = value
		emit_changed()
## Optional theme texture used when an element has no art_texture override.
@export var texture: Texture2D:
	set(value):
		texture = value
		emit_changed()
## Color modulation for a texture coming from this preset.
@export var texture_tint: Color = Color.WHITE:
	set(value):
		texture_tint = value
		emit_changed()
