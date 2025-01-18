class_name PlayerBlockState extends CharacterState

signal do_action

@export var block_speed: float = 0.5
var block_cooldown: float


func enter() -> void:
	print("Player entering Block State...")
	block_cooldown = 0
	parent_character.speed = 50


func update(delta) -> void:
	block_cooldown -= delta
	
	if parent_character.energy_node.current_energy == 0:
		transition.emit(self, "base")
	
	elif block_cooldown <= 0:
		do_action.emit("block")
		block_cooldown = block_speed


func _unhandled_key_input(event: InputEvent) -> void:
	
	if Input.is_action_pressed("transform"):
		transition.emit(self, "base")


func exit() -> void:
	get_viewport().set_input_as_handled()
