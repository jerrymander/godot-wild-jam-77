class_name PlayerBaseState extends CharacterState

func enter() -> void:
	active = true
	print("Player entering Base state...")
	parent_character.move_speed = parent_character.base_move_speed

func _unhandled_key_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("transform"):
		
		if parent_character.energy_node.can_transform:
			parent_character.energy_node.gain_energy(-parent_character.energy_node.transform_cost)
			transition.emit(self, "Transforming")
			get_viewport().set_input_as_handled()
			
		else:
			print("Energy not full.")

func exit() -> void:
	active = false
