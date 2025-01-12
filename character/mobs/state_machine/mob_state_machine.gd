class_name MobStateMachine extends Node

@export var parent_character: MobUI

var states: Dictionary = {}
@export var default_state: MobState
var current_state: MobState

func _ready() -> void:
	if !parent_character and get_parent().is_class("MobUI"):
		parent_character = get_parent()
	else:
		print("MobStateMachine is not attached to a MobUI!")
	
	for child in get_children():
		if child is MobState:
			states[child.name.to_lower()] = child
			child.parent_character = parent_character
			child.player = get_tree().get_first_node_in_group("Player")
			child.connect("Transitioned", on_transition_states)
	
	current_state = default_state
	current_state.enter()
	
	print("%s is currently %s." % [get_parent().name, current_state.name])

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func on_transition_states(state, transition_to_state: String):
	if state != current_state:
		print("Oops, current state mismatched while attempting to transition states.")
		return
	
	if current_state:
		current_state.exit()
	
	var new_state = states[transition_to_state.to_lower()]
	new_state.enter()
	current_state = new_state
	
