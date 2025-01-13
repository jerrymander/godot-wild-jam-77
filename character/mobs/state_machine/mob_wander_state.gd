class_name MobWanderState extends MobState

var wander_time
var wander_direction

func enter():
	randomize_walk()

func update(delta):
	wander_time -= delta
	if wander_time < 0:
		transition.emit(self, "idle")
	

func physics_update(delta):
	parent_character.velocity = wander_direction * parent_character.mob_stats.move_speed

func randomize_walk():
	wander_time = randf_range(1.5, 5.0)
	wander_direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized()
