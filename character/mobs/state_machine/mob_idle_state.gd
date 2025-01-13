class_name MobIdleState extends MobState

var idle_time: float
var distance_to_player: float

func enter():
	parent_character.velocity = Vector2(0, 0)
	randomize_time()

func update(delta):
	
	idle_time -= delta
	
	if idle_time < 0:
		transition.emit(self, "wander")
		
	distance_to_player = (player.global_position - parent_character.global_position).length()
	if distance_to_player <= parent_character.mob_stats.vision_range:
		transition.emit(self, "follow")

func randomize_time():
	idle_time = randf_range(1.5, 5.0)
