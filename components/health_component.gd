class_name Health extends Node

signal dying

@export var max_health: float = 10
var current_health: float = 10

func take_damage(defend_type, attack: Attack) -> void:
	current_health -= attack.damage
