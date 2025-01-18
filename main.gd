extends Node2D

var bullet_scene = preload("res://character/attacks/bullets/bullet.tscn")
var mob_scene = preload("res://character/mobs/mob.tscn")

@onready var bullets_node: Node = $Bullets
#maybe pool bullets in future
#var bullet_pool : Array[BulletUI]


func _ready() -> void:
	for mob in get_tree().get_nodes_in_group("Mob"):
		mob.connect("fire_bullet", on_bullet_fired)
	
	var player = get_tree().get_first_node_in_group("Player")
	player.connect("fire_bullet", on_bullet_fired)
	player.connect("place_block", on_block_placed)


func on_bullet_fired(bullet: Bullet, bullet_position: Vector2, bullet_direction: Vector2) -> void:
	var new_bullet = bullet_scene.instantiate()
	new_bullet.bullet = bullet
	new_bullet.position = bullet_position
	new_bullet.direction = bullet_direction
	bullets_node.add_child(new_bullet)


func on_block_placed():
	print("Block placed.")
