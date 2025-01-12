class_name MobFollowState extends MobState

var direction: Vector2
var attack_cooldown_timer
var is_attacking: bool

func enter():
	print("%s is now following the player." % parent_character.name)
	player = get_tree().get_first_node_in_group("Player")
	attack_cooldown_timer = parent_character.attack_pattern.attack_cooldown

func update(delta):
	pass

func physics_update(delta):
	direction = player.global_position - parent_character.global_position
	
	if direction.length() <= parent_character.mob_stats.vision_range:
		parent_character.velocity = direction.normalized() * parent_character.mob_stats.move_speed
		
		attack_cooldown_timer -= delta
		if attack_cooldown_timer <= 0:
			Transitioned.emit(self, "attack")
	
	if direction.length() > parent_character.mob_stats.vision_range:
		Transitioned.emit(self, "idle")

func exit():
	print("%s is leaving follow state." % parent_character.name)
