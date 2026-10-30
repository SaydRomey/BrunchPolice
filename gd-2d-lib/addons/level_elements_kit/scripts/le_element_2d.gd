## Common Node2D root for reusable level elements: Inspector identity, 
## placeholder art, visual presets and debug labels.[br]
## 
## The label can show a state suffix supplied by [_get_debug_state_text].[br]
## An optional [LE_ElementVisual] draws art in a moving physics child.

@tool
extends Node2D
class_name LE_Element2D
## Shared editor-facing appearance, metadata, and debug-label behavior.
## Every reusable element root in this starter kit inherits this class.

# The moving platform keeps its anchor fixed and moves its physics child.
# Offset only the root-drawn placeholder to match that child.
## Current offset applied to the root-drawn placeholder, used by moving platforms.
var _visual_offset: Vector2 = Vector2.ZERO

@export_group("Identity")
## Optional stable identifier for this placed element; included in the debug label when nonempty.
@export var element_id: String = ""
## Human-readable label for this element in the editor/game debug display.
@export var display_name: String = "Level Element":
	set(value):
		display_name = value
		_refresh()
## Designer-facing category tag. This metadata does not determine collision or behavior.
@export_enum("platform", "moving_platform", "collapsing_platform", "slippery_surface", "sticky_surface", "hazard", "soft_hazard", "launcher", "rope", "switch", "destructible", "background_prop", "foreground_fx", "ambience_audio", "boss_arena_element", "evidence_prop", "inclusive_detail", "other") var category: String = "other"

@export_group("Appearance")
## Optional shared [LE_VisualPreset] with placeholder fill, texture and tint.
@export var visual_preset: LE_VisualPreset:
	set(value):
		if visual_preset != null and visual_preset.changed.is_connected(_refresh):
			visual_preset.changed.disconnect(_refresh)
		visual_preset = value
		_connect_preset()
		_refresh()

## Size in local pixels; concrete elements also use this value for rectangle colliders.
@export var element_size: Vector2 = Vector2(128, 24):
	set(value):
		element_size = Vector2(maxf(2.0, absf(value.x)), maxf(2.0, absf(value.y)))
		_refresh()
## Draw the root placeholder rectangle/texture when true.
@export var show_placeholder: bool = true:
	set(value):
		show_placeholder = value
		_refresh()
## Fallback placeholder fill used without a preset; can be overridden by the preset.
@export var fill_color: Color = Color(0.31, 0.64, 0.91):
	set(value):
		fill_color = value
		_refresh()
## Optional texture drawn in place of the plain placeholder; overrides a preset texture.
@export var art_texture: Texture2D:
	set(value):
		art_texture = value
		_refresh()
## Tint applied to art_texture or used when the element has no preset.
@export var texture_tint: Color = Color.WHITE:
	set(value):
		texture_tint = value
		_refresh()

@export_group("Debug Label")
## Display the DebugLabel in the 2D editor.
@export var show_label_in_editor: bool = true:
	set(value):
		show_label_in_editor = value
		_refresh()
## Display the DebugLabel when running the level.
@export var show_label_in_game: bool = false:
	set(value):
		show_label_in_game = value
		_refresh()
## Choose Above, Below, Center, or Custom for debug label placement.
@export_enum("Above", "Below", "Center", "Custom") var label_position_mode: int = 0:
	set(value):
		label_position_mode = value
		_refresh()
## Additional local pixel offset applied after the chosen label position.
@export var label_offset: Vector2 = Vector2.ZERO:
	set(value):
		label_offset = value
		_refresh()
## Text color for the DebugLabel.
@export var label_color: Color = Color.WHITE:
	set(value):
		label_color = value
		_refresh()
## Font size in pixels for the DebugLabel.
@export_range(8, 40, 1) var label_font_size: int = 13:
	set(value):
		label_font_size = value
		_refresh()


## Connects to the selected visual preset and applies the initial placeholder, label and editor appearance.
func _ready() -> void:
	_connect_preset()
	_refresh()


## Subscribes [_refresh] to changes on the active [LE_VisualPreset], avoiding duplicate connections.
func _connect_preset() -> void:
	if visual_preset != null and not visual_preset.changed.is_connected(_refresh):
		visual_preset.changed.connect(_refresh)


# Override this in elements that have a state.
## Override in stateful elements to return a short suffix such as ON or OFF. Returns an empty string for elements without a state.
func _get_debug_state_text() -> String:
	return ""


## Updates the placeholder and optional DebugLabel when Inspector or runtime settings change. Looks for DebugLabel or Body/DebugLabel and appends [_get_debug_state_text] when nonempty.
func _refresh() -> void:
	if not is_inside_tree():
		return
	queue_redraw()
	
	var label := get_node_or_null("DebugLabel") as Label
	if label == null:
		label = get_node_or_null("Body/DebugLabel") as Label # le_moing_platform fix
	if label == null:
		return
	
	label.text = display_name if element_id.is_empty() else "%s [%s]" % [display_name, element_id]
	
	# Append the element's state when available.
	var state_text := _get_debug_state_text()
	
	if not state_text.is_empty():
		label.text += " | " + state_text
	
	label.visible = show_label_in_editor if Engine.is_editor_hint() else show_label_in_game
	
	label.add_theme_color_override("font_color", label_color)
	label.add_theme_font_size_override("font_size", label_font_size)
	label.reset_size()
	
	var anchor := Vector2.ZERO
	match label_position_mode:
		0: anchor.y = -element_size.y * 0.5 - 18.0
		1: anchor.y = element_size.y * 0.5 + 18.0
		2: anchor = Vector2.ZERO
		3: anchor = Vector2.ZERO
	
	label.position = anchor + label_offset - label.size * 0.5


## Draws a centered placeholder rectangle or texture, shifted by [_visual_offset]. Uses [member visual_preset] colors and texture unless overridden.
func _draw() -> void:
	if not show_placeholder:
		return
	var rect := Rect2(
		_visual_offset - element_size * 0.5, 
		element_size
	)
	var texture_to_draw := art_texture
	var tint_to_draw := texture_tint
	var color_to_draw := fill_color
	if visual_preset != null:
		color_to_draw = visual_preset.fill_color
		if texture_to_draw == null:
			texture_to_draw = visual_preset.texture
			tint_to_draw = visual_preset.texture_tint
	if texture_to_draw != null:
		draw_texture_rect(texture_to_draw, rect, false, tint_to_draw)
	else:
		draw_rect(rect, color_to_draw, true)
	draw_rect(rect, Color(0.08, 0.1, 0.15, 0.8), false, 1.0)
