class_name MobIdleState extends MobState

var idle_time

func enter():
	print("%s is idling." % parent_character.name)
	parent_character.velocity = Vector2(0, 0)
	randomize_time()

func update(delta):
	idle_time -= delta
	if idle_time < 0:
		Transitioned.emit(self, "wander")

func randomize_time():
	idle_time = randf_range(1.5, 5.0)
