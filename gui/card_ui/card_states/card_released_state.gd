extends CardState

func get_state_id() -> State:
	return State.RELEASED

func enter() -> void:
	if not card_ui.is_over_drop_area():
		return
	
	card_ui.play()

func post_enter() -> void:
	transition_requested.emit(self, CardState.State.BASE)
