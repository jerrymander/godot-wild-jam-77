class_name PlayerTransformingState extends CharacterState

func enter() -> void:
	
	print("Player entering Transforming State...")
	
	if parent_character.shield_mode == parent_character.ShieldState.ROCK:
		#print("Transforming to Block state!")
		#play transformation to Blocker animation.
		transition.emit(self, "Block")
		
	elif parent_character.shield_mode == parent_character.ShieldState.PAPER:
		#print("Transforming to Heal state!")
		#play transformation to Attacker animation.
		transition.emit(self, "Heal")
		
	elif parent_character.shield_mode == parent_character.ShieldState.SCISSORS:
		#print("Transforming to Attack state!")
		#play transformation to Healer animation.
		transition.emit(self, "Attack")
