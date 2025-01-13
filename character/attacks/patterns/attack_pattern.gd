class_name AttackPattern extends Resource

enum Type{TARGET, CIRCLE, SPRAY}
@export var pattern: Type
@export var number_of_bullets: int = 1
