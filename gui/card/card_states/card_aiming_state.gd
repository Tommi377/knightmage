extends CardState

const MOUSE_Y_SNAPBACK_THRESHOLD := 138

func get_state_id() -> State:
	return State.AIMING

func enter() -> void:
	var view_rect := get_viewport().get_visible_rect().size
	if card.init_parent:
		var offset := Vector2(-card.size.x / 2, -card.size.y * 1.5)
		var new_pos := Vector2(view_rect.x / 2, view_rect.y) + offset
		card.animate_to_position(new_pos, 0.2)
	else:
		card.animate_to_position(view_rect * Vector2(0.5, 0.5), 0.2)
	Events.card.aim_start.emit(card)


func exit() -> void:
	Events.card.aim_end.emit(card)


func on_input(event: InputEvent) -> void:	
	var mouse_at_bottom := card.get_global_mouse_position().y > MOUSE_Y_SNAPBACK_THRESHOLD
	
	if (event is InputEventMouseMotion and mouse_at_bottom) or event.is_action_pressed("right_mouse"):
		transition_requested.emit(self, CardState.State.BASE)
	elif event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse"):
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)
