class_name BulletUI extends Area2D

@export var bullet: Bullet
var direction: Vector2 = Vector2(1,1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set("modulate", bullet.color)
	_set_collision_properties()

func _physics_process(delta: float) -> void:
	if visible:
		position += direction.normalized() * bullet.speed * delta

func _on_body_entered(body: Node2D) -> void:
	body.hit_by(bullet)
	queue_free()

func _set_collision_properties() -> void:
	if bullet.type == Global.Damage_Type.NONE:
		collision_layer = 0b10000
		collision_mask = 0b100010
	else:
		collision_layer = 0b100
		collision_mask = 0b101001
