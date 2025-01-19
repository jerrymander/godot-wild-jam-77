class_name PlayerBlockState extends CharacterState

signal do_action

@export var move_speed: float = 50.0
@export var block_speed: float = 0.5
@export var block_cost: float = 5.0

var block_cooldown: float


func enter() -> void:
	active = true
	print("Player entering Block State...")
	block_cooldown = 0
	parent_character.move_speed = move_speed
	parent_character.sprite


func update(delta) -> void:
	block_cooldown -= delta
	
	if parent_character.energy_node.current_energy == 0:
		transition.emit(self, "base")


func _unhandled_key_input(event: InputEvent) -> void:
	if active:
		if event.is_action_pressed("transform"):
			transition.emit(self, "base")
			get_viewport().set_input_as_handled()
		
		if event.is_action_pressed("action") and block_cooldown <= 0:
			parent_character.energy_node.gain_energy(-block_cost)
			do_action.emit("block")
			print("Emitting block signal from block state.")
			block_cooldown = block_speed
			get_viewport().set_input_as_handled()
		elif event.is_action_pressed("action"):
			print("Block skill on cooldown.")
			get_viewport().set_input_as_handled()


func exit() -> void:
	active = false
	parent_character.sprite.frame = 0
	get_viewport().set_input_as_handled()
