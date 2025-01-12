class_name Player extends CharacterBody2D

const SPEED := 100.0

const COLOR_ARRAY = [Color.BLUE, Color.RED, Color.GREEN, Color.WHITE]
var mod_color: int = 3

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var camera_node: Camera2D = $Camera2D

func _ready() -> void:
	#camera_node.make_current()
	pass

func _physics_process(delta: float) -> void:
	
	move_and_slide()
	
	#if velocity.x < 0:
	#	sprite.flip_h = false
	#else:
	#	sprite.flip_h = true
	
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
		mod_color = (mod_color + 1) % 4
		modulate = COLOR_ARRAY[mod_color]
	
	direction = direction.normalized()
	
	velocity = direction * SPEED
