class_name EnergyComponent extends Node2D

@onready var energy_bar: CharacterResourceBar = $EnergyBar

@export var max_energy: float = 50
var current_energy: float = 0

func update_energy(amount: float):
	current_energy += amount
	if current_energy > max_energy:
		current_energy = max_energy
	energy_bar.update_target_value(current_energy)
	print("Player gained %s energy." % amount)

func _ready() -> void:
	energy_bar.set_values(max_energy, 0)
