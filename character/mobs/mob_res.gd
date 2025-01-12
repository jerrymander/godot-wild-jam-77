class_name MobResource extends Resource

enum CharacterType{ROCK, PAPER, SCISSORS}

@export var character_name : String
@export var charcter_type : CharacterType

@export var MAX_HEALTH : float
var current_health : float

@export var move_speed := 100.0
@export var vision_range := 250.0

#func take_damage(attack : Attack) -> void:
#	current_health -= attack.damage
