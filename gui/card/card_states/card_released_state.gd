extends CardState

func get_state_id() -> State:
	return State.RELEASED

func enter() -> void:
	if not card.is_over_drop_area():
		return
	
	card.play()

func post_enter() -> void:
	transition_requested.emit(self, CardState.State.BASE)
