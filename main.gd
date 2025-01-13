extends Node2D

var bullet_ui = preload("res://attacks/bullets/bullet.tscn")

@onready var bullets_node: Node = $Bullets
#maybe pool bullets in future
#var bullet_pool : Array[BulletUI]

func _ready() -> void:
	for mob in get_tree().get_nodes_in_group("Mob"):
		mob.connect("fire_bullet", on_bullet_fired)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_bullet_fired(bullet: Bullet, bullet_position: Vector2, bullet_direction: Vector2) -> void:
	print("%s received fire_bullet signal." % self.name)
	var new_bullet = bullet_ui.instantiate()
	new_bullet.bullet = bullet
	new_bullet.position = bullet_position
	new_bullet.direction = bullet_direction
	bullets_node.add_child(new_bullet)
