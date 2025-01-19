extends StaticBody2D

@export var spawns: PackedScene
@export var mob_stats: MobResource
@export var bullet: Bullet

var player: Player
var direction: Vector2
var cooldown: float
var animation: AnimatedSprite2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	animation = get_node("AnimatedSprite2D")

func _process(delta: float) -> void:
	if cooldown > 0:
		cooldown = max(0, cooldown - delta)

func _physics_process(_delta: float) -> void:
	direction = player.global_position - global_position
	# arbitrary value within screen size to see animation happen
	if direction.length() <= 100:
		_try_spawn()

func _try_spawn() -> void:
	if cooldown == 0:
		# arbitrary value greater than animation loop time
		cooldown += 5
		_begin_spawn()

func _begin_spawn() -> void:
	animation.play()

func _on_animated_sprite_2d_animation_finished() -> void:
	animation.set_frame(0)
	var new_spawn = spawns.instantiate()
	new_spawn.global_position = global_position
	new_spawn.add_to_group("NewMob")
	get_parent().add_child(new_spawn)
