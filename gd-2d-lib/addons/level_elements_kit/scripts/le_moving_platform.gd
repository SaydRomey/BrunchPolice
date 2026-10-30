## Moves an AnimatableBody2D back and forth along a configurable travel vector.
##
## The placed root stays fixed.[br]
## Its Body and root-drawn placeholder move during physics ticks; 
## custom artwork should follow Body.

@tool
extends LE_PlatformBase
class_name LE_MovingPlatform
## Moves its AnimatableBody2D between the placed position and placed position + travel.
## The Node2D root stays at its authored position as a stable path anchor.

@export_group("Motion")
## Body displacement in local pixels from the initial placed position to the other endpoint.
@export var travel: Vector2 = Vector2(200, 0)
## Travel speed in pixels per second.
@export_range(1, 1000, 1) var speed_px_per_second: float = 90.0
## Whether the platform Body progresses along its route at runtime.
@export var motion_enabled: bool = true

## Moving AnimatableBody2D child controlled by the platform.
@onready var _body: AnimatableBody2D = $Body

## Starting local Body position.
var _body_origin: Vector2 = Vector2.ZERO
## Accumulated progress along the travel segment in pixels.
var _distance: float = 0.0
## Current travel direction: 1 toward the end, -1 toward the start.
var _direction: float = 1.0

## Caches the child Body initial local position, sets the placeholder offset, and enables physics processing only during gameplay.
func _ready() -> void:
	super._ready()
	_body_origin = _body.position
	_visual_offset = _body_origin
	queue_redraw()
	set_physics_process(not Engine.is_editor_hint())

## Updates the AnimatableBody2D local position between its origin and travel end and redraws the placeholder. Pauses movement when motion_enabled is false.
func _physics_process(delta: float) -> void:
	if not motion_enabled:
		return
	var length := travel.length()
	if length <= 0.01:
		return

	_distance += speed_px_per_second * delta * _direction
	if _distance >= length:
		_distance = length
		_direction = -1.0
	elif _distance <= 0.0:
		_distance = 0.0
		_direction = 1.0

	# Change the body's LOCAL transform, rather than its parent Node2D.
	# This reliably notifies AnimatableBody2D when sync_to_physics is true.
	_body.position = _body_origin + travel * (_distance / length)
	# The kit's temporary art is drawn by the anchor root, so redraw it at
	# the physical body's offset. Any custom art belongs under Body instead.
	_visual_offset = _body.position
	queue_redraw()

## Enables or pauses movement without removing collision or resetting the current travel position. [param value] is the desired enabled state.
func set_enabled(value: bool) -> void:
	motion_enabled = value


#@tool
#extends LE_PlatformBase
#class_name LE_MovingPlatform
### Travels between its placed position and placed position + travel.
#
#@export_group("Motion")
#@export var travel: Vector2 = Vector2(200, 0)
#@export_range(1, 1000, 1) var speed_px_per_second: float = 90.0
#@export var motion_enabled: bool = true
#
#var _origin: Vector2
#var _distance: float = 0.0
#var _direction: float = 1.0
#
#func _ready() -> void:
	#super._ready()
	#if not Engine.is_editor_hint():
		#_origin = position
		#set_physics_process(true)
	#else:
		#set_physics_process(false)
#
#func _physics_process(delta: float) -> void:
	#if not motion_enabled:
		#return
	#var length := travel.length()
	#if length <= 0.01:
		#return
	#_distance += speed_px_per_second * delta * _direction
	#if _distance >= length:
		#_distance = length
		#_direction = -1.0
	#elif _distance <= 0.0:
		#_distance = 0.0
		#_direction = 1.0
	#position = _origin + travel * (_distance / length)
#
#func set_enabled(value: bool) -> void:
	#motion_enabled = value
