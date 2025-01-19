extends Area2D

var bodies: Dictionary = {}
var placeable: bool = true

func _ready() -> void:
	#body_entered.connect(_on_body_entered)
	#body_exited.connect(_on_body_exited)
	pass


func _on_body_entered(body: Node2D):
	bodies[body.name] = body
	placeable = false
	print("Blocks are not placeable!")


func _on_body_exited(body: Node2D):
	if bodies.has(body):
		bodies.erase(body)
	if bodies.is_empty():
		placeable = true
		print("Blocks are placeable!")
