extends Node
class_name Stamina

signal stamina_changed(current: float, maximum: float)
signal stamina_empty()

@export var max_stamina: float = 50.0
@export var regen_rate: float = 5.0
@export var regen_enabled: bool = true

var stamina: float

func _ready() -> void:
	stamina = max_stamina
	stamina_changed.emit(stamina, max_stamina)

func _process(delta: float) -> void:
	if regen_enabled and stamina < max_stamina:
		stamina = minf(max_stamina, stamina + regen_rate * delta)
		stamina_changed.emit(stamina, max_stamina)

func use_stamina(amount: float) -> bool:
	if stamina < amount:
		stamina_empty.emit()
		return false
	stamina -= amount
	stamina_changed.emit(stamina, max_stamina)
	return true

func add_stamina(amount: float) -> void:
	stamina = minf(max_stamina, stamina + amount)
	stamina_changed.emit(stamina, max_stamina)

func set_max_stamina(value: float, refill: bool = false) -> void:
	max_stamina = maxf(1.0, value)
	if refill:
		stamina = max_stamina
	else:
		stamina = minf(stamina, max_stamina)
	stamina_changed.emit(stamina, max_stamina)

func is_stamina_full() -> bool:
	return stamina >= max_stamina

func is_stamina_empty() -> bool:
	return stamina <= 0.0
