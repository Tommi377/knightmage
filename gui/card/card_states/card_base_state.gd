extends CardState

var mouse_over_card := false

func get_state_id() -> State:
	return State.BASE

func enter() -> void:
	if not card.is_node_ready():
		await card.ready

	if card.tween and card.tween.is_running():
		card.tween.kill()

	card.card_reparent.emit(card)
	card.pivot_offset = Vector2.ZERO


func on_gui_input(event: InputEvent) -> void:
	if not card.playable or card.disabled:
		return

	if mouse_over_card and event.is_action_pressed("left_mouse"):
		card.pivot_offset = card.get_global_mouse_position() - card.global_position
		transition_requested.emit(self, CardState.State.DRAGGING)


func on_mouse_entered() -> void:
	mouse_over_card = true
	
	if not card.playable or card.disabled:
		return


func on_mouse_exited() -> void:
	mouse_over_card = false
	
	if not card.playable or card.disabled:
		return
