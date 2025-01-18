class_name PlayerTransformingState extends CharacterState

func enter() -> void:
	
	print("Player entering Transforming State...")
	
	if parent_character.shield_mode == Global.Damage_Type.ROCK:
		#print("Transforming to Block state!")
		#play transformation to Blocker animation.
		transition.emit(self, "block")
		
	elif parent_character.shield_mode == Global.Damage_Type.PAPER:
		#print("Transforming to Heal state!")
		#play transformation to Attacker animation.
		transition.emit(self, "heal")
		
	elif parent_character.shield_mode == Global.Damage_Type.SCISSORS:
		#print("Transforming to Attack state!")
		#play transformation to Healer animation.
		transition.emit(self, "attack")
