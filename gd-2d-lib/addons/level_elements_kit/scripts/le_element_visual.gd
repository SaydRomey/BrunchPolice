@tool
extends Node2D
class_name LE_ElementVisual
## Draws an element's placeholder/texture in the LOCAL space of this Visual node.
## Parent this to Body or Area so physics and artwork share one transform.
## The owning LE_Element2D retains all existing Inspector appearance settings.

func _draw() -> void:
	var element := _find_element()
	if element == null or not element.show_placeholder:
		return

	var rect := Rect2(
		-element.element_size * 0.5, 
		element.element_size
	)
	var texture_to_draw: Texture2D = element.art_texture
	var tint_to_draw: Color = element.texture_tint
	var color_to_draw: Color = element.fill_color

	if element.visual_preset != null:
		color_to_draw = element.visual_preset.fill_color
		if texture_to_draw == null:
			texture_to_draw = element.visual_preset.texture
			tint_to_draw = element.visual_preset.texture_tint

	if texture_to_draw != null:
		draw_texture_rect(texture_to_draw, rect, false, tint_to_draw)
	else:
		draw_rect(rect, color_to_draw, true)
	draw_rect(rect, Color(0.08, 0.1, 0.15, 0.8), false, 1.0)

func _find_element() -> LE_Element2D:
	var ancestor: Node = get_parent()
	while ancestor != null:
		if ancestor is LE_Element2D:
			return ancestor as LE_Element2D
		ancestor = ancestor.get_parent()
	return null
