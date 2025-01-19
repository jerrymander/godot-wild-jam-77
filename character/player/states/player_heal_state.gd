class_name PlayerHealState extends CharacterState

signal do_action

@export var move_speed: float = 100.0
@export var heal_speed: float = 0.5
@export var heal_cost: float = 3.0
@export var heal_amount: float = 1.0

var heal_cooldown: float

func enter() -> void:
	active = true
	print("Player entering Heal State...")
	heal_cooldown = 0
	parent_character.move_speed = 125


func _unhandled_key_input(event: InputEvent) -> void:
	if active:
		if event.is_action_pressed("transform"):
			transition.emit(self, "base")
			get_viewport().set_input_as_handled()


func update(delta) -> void:
	heal_cooldown -= delta
	
	if parent_character.energy_node.current_energy == 0:
		transition.emit(self, "base")
	
	elif heal_cooldown <= 0:
		do_action.emit("heal")
		heal_cooldown = heal_speed


func exit() -> void:
	active = false
	parent_character.sprite.frame = 0
	get_viewport().set_input_as_handled()
