class_name CharacterResourceBar extends TextureProgressBar

@export var resource_name: String
@export var speed_curve: Curve

const SPEED: float = 25.0
const DISTANCE_THRESHOLD: float = 5.0
@export var target_value: float
var distance: float

var needs_update: bool = false

func update_target_value(amount: float) -> void:
	target_value = amount
	needs_update = true

func _process(delta: float) -> void:
	distance = value - target_value
	if needs_update:
		if abs(distance) < 0.01:
			value = target_value
			needs_update = false
		elif distance > 0:
			value -= delta * SPEED * speed_curve.sample(distance/DISTANCE_THRESHOLD)
		elif distance < 0:
			value += delta * SPEED * speed_curve.sample(-distance/DISTANCE_THRESHOLD)

func set_values(resource_max: float, resource_current: float, resource_min: float = 0) -> void:
	min_value = resource_min
	max_value = resource_max
	value = resource_current
