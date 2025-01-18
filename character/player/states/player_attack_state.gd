class_name PlayerAttackState extends CharacterState

signal do_action

@export var attack_speed: float = 0.5
@export var attack_cost: float = 4.0
var attack_cooldown: float


func enter() -> void:
	print("Player entering Attack State...")
	attack_cooldown = 0
	parent_character.speed = 0


func update(delta) -> void:
	attack_cooldown -= delta
	
	if parent_character.energy_node.current_energy == 0:
		transition.emit(self, "base")
	
	elif attack_cooldown <= 0:
		do_action.emit("attack")
		attack_cooldown = attack_speed


func _unhandled_key_input(event: InputEvent) -> void:
	
	if Input.is_action_pressed("transform"):
		transition.emit(self, "base")


func exit() -> void:
	get_viewport().set_input_as_handled()
