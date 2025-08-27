extends CardState

const MOUSE_Y_SNAPBACK_THRESHOLD := 138

func get_state_id() -> State:
	return State.AIMING

func enter() -> void:
	var parent = card_ui.get_parent()
	if parent is Control:
		var offset := Vector2(parent.size.x / 2, -card_ui.size.y / 2)
		offset.x -= card_ui.size.x / 2
		card_ui.animate_to_position(parent.global_position + offset, 0.2)
	else:
		var new_pos := get_viewport().get_visible_rect().size * Vector2(0.5, 0.5)
		card_ui.animate_to_position(new_pos, 0.2)
	Events.card.aim_start.emit(card_ui)


func exit() -> void:
	Events.card.aim_end.emit(card_ui)


func on_input(event: InputEvent) -> void:	
	var mouse_at_bottom := card_ui.get_global_mouse_position().y > MOUSE_Y_SNAPBACK_THRESHOLD
	
	if (event is InputEventMouseMotion and mouse_at_bottom) or event.is_action_pressed("right_mouse"):
		transition_requested.emit(self, CardState.State.BASE)
	elif event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse"):
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)
