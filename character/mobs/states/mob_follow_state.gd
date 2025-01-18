class_name MobFollowState extends MobState

var direction: Vector2
var is_attacking: bool


func enter():
	player = get_tree().get_first_node_in_group("Player")


func physics_update(delta):
	
	direction = player.global_position - parent_character.global_position
	
	if direction.length() <= parent_character.mob_stats.vision_range:
		parent_character.velocity = direction.normalized() * parent_character.mob_stats.move_speed
		
		if parent_character.attack_cooldown_timer <= 0:
			transition.emit(self, "attack")
	
	if direction.length() > parent_character.mob_stats.vision_range:
		transition.emit(self, "idle")
