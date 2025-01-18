class_name Block extends StaticBody2D

@onready var health_node: HealthComponent = $HealthComponent

func _ready() -> void:
	health_node.connect("dying", on_dying)

func hit_by(bullet: Bullet) -> void:
	health_node.take_damage(bullet.damage)

func on_dying() -> void:
	queue_free()
