class_name MobAttackState extends MobState

signal attack

var attack_delay: float = 0.3


func enter():
	parent_character.velocity = Vector2(0, 0)


func update(delta):
	
	attack_delay -= delta
	
	if attack_delay <= 0:
		attack.emit()
		parent_character.reset_attack_cooldown()
		transition.emit(self, "follow")


func exit():
	attack_delay = 0.3
