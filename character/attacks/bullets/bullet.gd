class_name Bullet extends Resource

enum Type{ROCK, PAPER, SCISSORS, NONE}
@export var type: Type = Type.NONE

@export var damage: float = 1.0
@export var speed: float = 50.0
@export var color: Color = Color.WHITE
