class_name PlayerHealState extends CharacterState

signal do_action

@export var heal_speed: float = 0.5
var heal_cooldown: float
var heal_amount: float

func enter() -> void:
	print("Player entering Heal State...")
	heal_cooldown = 0
	parent_character.speed = 125


func _unhandled_key_input(event: InputEvent) -> void:
	
	if Input.is_action_pressed("transform"):
		transition.emit(self, "base")


func update(delta) -> void:
	heal_cooldown -= delta
	
	if parent_character.energy_node.current_energy == 0:
		transition.emit(self, "base")
	
	elif heal_cooldown <= 0:
		do_action.emit("heal")
		heal_cooldown = heal_speed


func exit() -> void:
	get_viewport().set_input_as_handled()
