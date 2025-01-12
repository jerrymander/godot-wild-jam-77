class_name AttackPattern extends Node

var bullet_ui = preload("res://attacks/bullets/bullet.tscn")
@export var bullet: Bullet

enum Pattern{TARGET, CIRCLE, SPRAY}
@export var pattern: Pattern

@export var attack_cooldown: float = 1.0
var attack_cooldown_timer

@export var number_of_bullets: int = 1

signal fire_bullet

func _ready() -> void:
	attack_cooldown_timer = attack_cooldown

func _process(delta: float) -> void:
	pass

func get_player_location():
	pass
