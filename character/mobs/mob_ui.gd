class_name MobUI extends CharacterBody2D

@export var mob_stats: MobResource
@export var attack_pattern: AttackPattern
@export var bullet: Bullet

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: MobStateMachine = $StateMachine

@export var attack_cooldown: float = 0.5
var attack_cooldown_timer

signal fire_bullet

func _ready() -> void:
	self.add_to_group("Enemy")
	reset_attack_cooldown()
	state_machine.connect("attack", _on_attack)
	
	if !mob_stats:
		mob_stats = load("res://character/mobs/basic_rock.tres")
		bullet = load("res://character/attacks/bullets/rock_bullet.tres")

func _physics_process(delta: float) -> void:
	if velocity.x < 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	
	if state_machine.current_state.name == "Wander" or state_machine.current_state.name == "Follow":
		animation_player.play("walk")
	else:
		animation_player.play("idle")
	
	move_and_slide()

func _process(delta: float) -> void:
	attack_cooldown_timer -= delta

func reset_attack_cooldown() -> void:
	attack_cooldown_timer = attack_cooldown

func _on_attack() -> void:
	var bullet_position = self.global_position
	var bullet_direction = (get_tree().get_first_node_in_group("Player").global_position - self.global_position).normalized()
	fire_bullet.emit(bullet, bullet_position, bullet_direction)
