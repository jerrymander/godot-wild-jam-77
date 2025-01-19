extends PanelContainer

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_released("exit"):
		visible = !visible
		get_viewport().set_input_as_handled()

func _on_close_panel_button_up() -> void:
	visible = false
