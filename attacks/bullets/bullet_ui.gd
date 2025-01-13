class_name BulletUI extends Area2D

@export var bullet: Bullet
var direction: Vector2 = Vector2(1,1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set("modulate", bullet.color)

func _physics_process(delta: float) -> void:
	if visible:
		position += direction.normalized() * bullet.speed * delta

func _on_body_entered(body: Node2D) -> void:
	print("Hit %s." % body.name)
	queue_free()
