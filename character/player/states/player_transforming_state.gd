class_name PlayerTransformingState extends CharacterState

var transition_to : String
var animation_start_frame : int
var animation_tick : float = 0
const TIME_BETWEEN_FRAMES := 0.5

func enter() -> void:
	active = true
	print("Player entering Transforming State...")
	
	if parent_character.shield_mode == Global.Damage_Type.ROCK:
		transition_to = "block"
		parent_character.sprite.frame = 7
		
	elif parent_character.shield_mode == Global.Damage_Type.PAPER:
		transition_to = "heal"
		parent_character.sprite.frame = 10
		
	elif parent_character.shield_mode == Global.Damage_Type.SCISSORS:
		transition_to = "attack"
		parent_character.sprite.frame = 4


func physics_update(delta) -> void:
	animation_tick += delta
	if animation_tick >= TIME_BETWEEN_FRAMES:
		parent_character.sprite.frame += 1
		animation_tick = 0
	if [6, 9, 12].has(parent_character.sprite.frame):
		transform_animation_done()
		
	#parent_character.animation_player.play("transform_to_" + transition_to)


func transform_animation_done() -> void:
	transition.emit(self, transition_to)
	print("Transforming to...%s state..." % transition_to)


func exit() -> void:
	active = false
