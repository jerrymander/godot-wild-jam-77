class_name MobUI extends CharacterBody2D

@export var mob_stats: MobResource
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: MobStateMachine = $StateMachine
@onready var attack_pattern: AttackPattern = $AttackPattern

func _ready() -> void:
	self.add_to_group("Enemy")

func _physics_process(delta: float) -> void:
	if velocity.x < 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	
	if velocity:
		animation_player.play("walk")
	else:
		animation_player.play("idle")
	
	move_and_slide()
