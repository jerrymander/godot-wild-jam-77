class_name MobWanderState extends MobState

var wander_time: float
var wander_direction: Vector2

var distance_to_player: float

func enter():
	randomize_walk()


func update(delta):
	
	wander_time -= delta
	
	if wander_time < 0:
		transition.emit(self, "idle")
	
	distance_to_player = (player.global_position - parent_character.global_position).length()
	if distance_to_player <= parent_character.mob_stats.vision_range:
		transition.emit(self, "follow")


func physics_update(_delta):
	parent_character.velocity = wander_direction * parent_character.mob_stats.move_speed


func randomize_walk():
	wander_time = randf_range(1.5, 5.0)
	wander_direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized()
