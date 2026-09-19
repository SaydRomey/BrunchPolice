extends CanvasLayer
class_name AmbianceManager

signal filter_changed(color: Color, opacity: float)
signal day_night_updated(time_of_day: float)

@export var overlay_layer: int = 100
@export var enable_day_night_cycle: bool = false
@export var day_night_speed: float = 0.01
@export var day_color: Color = Color(1, 1, 1, 0.0)
@export var night_color: Color = Color(0.02, 0.04, 0.18, 0.55)

var filter_color: Color = Color(1, 1, 1, 0.0)
var filter_opacity: float = 0.0
var time_of_day: float = 0.0
var light_sources: Array[Light2D] = []
var filter_overlay: ColorRect

func _ready() -> void:
	layer = overlay_layer
	filter_overlay = ColorRect.new()
	filter_overlay.name = "FilterOverlay"
	filter_overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	filter_overlay.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(filter_overlay)
	apply_filter()

func _process(delta: float) -> void:
	if enable_day_night_cycle:
		update_day_night_cycle(delta)

func set_filter_color(color: Color) -> void:
	filter_color = color
	apply_filter()

func set_filter_opacity(opacity: float) -> void:
	filter_opacity = clampf(opacity, 0.0, 1.0)
	apply_filter()

func apply_filter() -> void:
	if filter_overlay == null:
		return
	var color := filter_color
	color.a = filter_opacity
	filter_overlay.color = color
	filter_changed.emit(color, filter_opacity)

func fade_filter(target_color: Color, target_opacity: float, duration: float = 0.5) -> void:
	if filter_overlay == null:
		return
	filter_color = target_color
	filter_opacity = clampf(target_opacity, 0.0, 1.0)
	var final_color := target_color
	final_color.a = filter_opacity
	var tween := create_tween()
	tween.tween_property(filter_overlay, "color", final_color, maxf(0.0, duration))
	filter_changed.emit(final_color, filter_opacity)

func add_light_source(light: Light2D) -> void:
	if light and not light_sources.has(light):
		light_sources.append(light)

func remove_light_source(light: Light2D) -> void:
	light_sources.erase(light)

func update_lighting(enabled: bool = true) -> void:
	for light in light_sources:
		if is_instance_valid(light):
			light.enabled = enabled

func update_day_night_cycle(delta: float) -> void:
	time_of_day = fmod(time_of_day + delta * day_night_speed, 1.0)
	var night_weight := absf(sin(time_of_day * TAU))
	var color := day_color.lerp(night_color, night_weight)
	filter_color = color
	filter_opacity = color.a
	apply_filter()
	day_night_updated.emit(time_of_day)

func set_fog(opacity: float = 0.45) -> void:
	set_filter_color(Color(0.65, 0.65, 0.65, 1.0))
	set_filter_opacity(opacity)

func set_toxic_gas(opacity: float = 0.35) -> void:
	set_filter_color(Color(0.45, 0.9, 0.25, 1.0))
	set_filter_opacity(opacity)

func clear_filter() -> void:
	set_filter_opacity(0.0)
