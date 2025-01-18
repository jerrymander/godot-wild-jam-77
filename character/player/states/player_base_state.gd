class_name PlayerBaseState extends CharacterState

func enter() -> void:
	print("Player entering Base state...")

func _unhandled_key_input(event: InputEvent) -> void:
	
	if Input.is_action_pressed("transform"):
		
		if parent_character.energy_node.can_transform:
			parent_character.energy_node.update_energy(-parent_character.energy_node.transform_cost)
			transition.emit(self, "Transforming")
			get_viewport().set_input_as_handled()
			
		else:
			print("Energy not full.")
