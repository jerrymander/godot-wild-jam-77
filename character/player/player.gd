class_name Player extends CharacterBody2D

var speed := 100.0

const COLOR_ARRAY = [Color.DODGER_BLUE, Color.YELLOW, Color.HOT_PINK]

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var camera_node: Camera2D = $Camera2D
@onready var health_node: HealthComponent = $HealthComponent
@onready var energy_node: EnergyComponent = $EnergyComponent

enum ShieldState{ROCK, PAPER, SCISSORS, NONE}
var shield_mode: ShieldState

func _ready() -> void:
	health_node.connect("dying", on_dying)
	shield_mode = ShieldState.ROCK
	sprite.modulate = COLOR_ARRAY[shield_mode]


func _physics_process(delta: float) -> void:
	
	move_and_collide(velocity * delta)
	
	if velocity.length() > 0:
		animation_player.play("walk")
	else:
		animation_player.play("idle")
	

func _unhandled_input(event: InputEvent) -> void:
	
	var direction := Vector2(0,0)
	
	if Input.is_action_pressed("up"):
		direction += Vector2(0,-1)
	if Input.is_action_pressed("down"):
		direction += Vector2(0,1)
	if Input.is_action_pressed("left"):
		direction += Vector2(-1,0)
		sprite.flip_h = false
	if Input.is_action_pressed("right"):
		direction += Vector2(1,0)
		sprite.flip_h = true
	
	if Input.is_action_just_pressed("shift"):
		shift_mode()
	
	direction = direction.normalized()
	
	velocity = direction * speed


func shift_mode():
	shield_mode = (shield_mode + 1) % 3
	sprite.modulate = COLOR_ARRAY[shield_mode]


func morph():
	pass


func hit_by(bullet: Bullet) -> void:
	if bullet.type == shield_mode:
		energy_node.update_energy(bullet.damage)
	else:
		health_node.take_damage(bullet.damage)


func on_dying() -> void:
	print("Player died. Reviving...")
	health_node.reset_health()
