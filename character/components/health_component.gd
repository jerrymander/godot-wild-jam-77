class_name HealthComponent extends Node2D

signal dying

@onready var health_bar: CharacterResourceBar = $HealthBar

@export var max_health: float = 10
var current_health: float = 10

func take_damage(damage) -> void:
	current_health -= damage
	health_bar.update_target_value(current_health)
	print("Player took %s damage." % damage)
	if current_health <= 0:
		dying.emit()

func _ready() -> void:
	reset_health()

func reset_health() -> void:
	current_health = max_health
	health_bar.set_values(max_health, max_health)
	health_bar.target_value = max_health
