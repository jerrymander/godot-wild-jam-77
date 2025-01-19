class_name EnergyComponent extends Node2D

@onready var energy_bar: CharacterResourceBar = $EnergyBar

@export var max_energy: float = 50
var current_energy: float = 0

@export var transform_cost: float = 10

var can_transform: bool = false

func gain_energy(amount: float):
	current_energy += amount
	
	if current_energy >= transform_cost:
		can_transform = true
	elif current_energy < transform_cost:
		can_transform = false
	
	if current_energy >= max_energy:
		current_energy = max_energy
	
	energy_bar.update_target_value(current_energy)
	print("Player gained %s energy." % amount)
	
	if current_energy < 0:
		current_energy = 0

func _ready() -> void:
	energy_bar.set_values(max_energy, 0)
