class_name CharacterStateMachine extends Node

@export var parent_character: CharacterBody2D
@export var debug_state_label: Label

var states: Dictionary = {}
@export var default_state: CharacterState
var current_state: CharacterState

var actions_array: Array[String] = ["attack", "defend", "heal"]

signal do_action

func _ready() -> void:
	for child in get_children():
		if child is CharacterState:
			states[child.name.to_lower()] = child
			child.parent_character = parent_character
			child.connect("transition", on_transition_states)
			if actions_array.has(child.name.to_lower()):
				child.connect("do_action", on_doing_action)
	
	current_state = default_state
	debug_state_label.text = "Current State: " + current_state.name
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
		print("Oops, attempting to transition from %s, but character is in %s." % [current_state.name, state.name])
		return
	
	if current_state:
		current_state.exit()
	
	var new_state = states[transition_to_state.to_lower()]
	current_state = new_state
	debug_state_label.text = "Current State: " + current_state.name
	current_state.enter()


func on_doing_action(action: String) -> void:
	do_action.emit(action)
