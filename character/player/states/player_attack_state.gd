class_name PlayerAttackState extends CharacterState

signal do_action

@export var move_speed: float = 0.0
@export var attack_speed: float = 0.5
@export var attack_cost: float = 4.0

var attack_cooldown: float


func enter() -> void:
	active = true
	print("Player entering Attack State...")
	attack_cooldown = 0
	parent_character.move_speed = move_speed


func update(delta) -> void:
	attack_cooldown -= delta
	
	if parent_character.energy_node.current_energy == 0:
		transition.emit(self, "base")
	
	elif attack_cooldown <= 0:
		parent_character.energy_node.gain_energy(-attack_cost)
		do_action.emit("attack")
		attack_cooldown = attack_speed


func _unhandled_key_input(event: InputEvent) -> void:
	if active:
		if event.is_action_pressed("transform"):
			transition.emit(self, "base")
			get_viewport().set_input_as_handled()


func exit() -> void:
	active = false
	parent_character.sprite.frame = 0
	get_viewport().set_input_as_handled()
