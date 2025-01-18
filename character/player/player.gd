class_name Player extends CharacterBody2D

signal fire_bullet
signal place_block

var base_move_speed := 100.0
var move_speed := 100.0
const RANGE := 250.0

var mobs_in_range: Dictionary = {}

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var camera_node: Camera2D = $Camera2D
@onready var health_node: HealthComponent = $HealthComponent
@onready var energy_node: EnergyComponent = $EnergyComponent
@onready var state_machine: CharacterStateMachine = $StateMachine

@export var bullet: Bullet

var shield_mode: Global.Damage_Type

const TIME_BETWEEN_SCANS := 1
var scan_cooldown: float = 1.0


func _ready() -> void:
	health_node.connect("dying", on_dying)
	shield_mode = Global.Damage_Type.ROCK
	sprite.modulate = Global.SHIELD_COLORS[shield_mode]
	state_machine.connect("do_action", on_doing_action)


func _process(delta: float) -> void:
	scan_cooldown -= delta
	#if scan_cooldown <= 0:
	#	mobs_in_range = get_mobs_in_range()
	#	scan_cooldown = TIME_BETWEEN_SCANS

func _physics_process(delta: float) -> void:
	
	move_and_collide(velocity * delta)
	
	if velocity.length() > 0:
		animation_player.play("walk")
	else:
		animation_player.play("idle")
	

func _unhandled_key_input(_event: InputEvent) -> void:
	
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
		shift_shield_mode()
	
	direction = direction.normalized()
	
	velocity = direction * move_speed


func shift_shield_mode():
	shield_mode = (shield_mode + 1) % 3 as Global.Damage_Type
	sprite.modulate = Global.SHIELD_COLORS[shield_mode]


func get_mobs_in_range() -> Dictionary:
	
	var mobs: Dictionary
	var distance_to_mob: float
	
	for mob in get_tree().get_nodes_in_group("Mob"):
		distance_to_mob = (mob.global_position - self.global_position).length()
		if distance_to_mob < RANGE:
			mobs[mob] = distance_to_mob
	
	return mobs


func get_closest_mob() -> MobUI:
	
	mobs_in_range = get_mobs_in_range()
	var closest: MobUI = null
	
	for mob in mobs_in_range:
		if !closest:
			closest = mob
		elif mobs_in_range[mob] < mobs_in_range[closest]:
			closest = mob
	
	return closest


func hit_by(bullet: Bullet) -> void:
	if bullet.type == shield_mode:
		energy_node.update_energy(bullet.damage)
	else:
		health_node.take_damage(bullet.damage)


func on_dying() -> void:
	print("Player died. Reviving...")
	health_node.reset_health()


func on_doing_action(action: String) -> void:
	
	if action == "attack":
		var bullet_position = self.global_position
		var target = get_closest_mob()
		if !target:
			return
		var bullet_direction = (target.global_position - self.global_position).normalized()
		fire_bullet.emit(bullet, bullet_position, bullet_direction)
		
	elif action == "block":
		place_block.emit()


func _on_max_energy_button_up() -> void:
	energy_node.update_energy(energy_node.max_energy)
