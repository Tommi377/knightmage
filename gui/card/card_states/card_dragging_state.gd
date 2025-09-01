extends CardState

const DRAG_MINIMUM_THRESHOLD := 0.05

var minimum_drag_time_elapsed := false

func get_state_id() -> State:
	return State.DRAGGING

func enter() -> void:
	var ui_layer := get_tree().get_first_node_in_group(Const.GlobalGroups.GAME_UI)
	if ui_layer:
		card.reparent(ui_layer)
	
	minimum_drag_time_elapsed = false
	var threshold_timer := get_tree().create_timer(DRAG_MINIMUM_THRESHOLD, false)
	threshold_timer.timeout.connect(func() -> void: minimum_drag_time_elapsed = true)


func exit() -> void:
	pass


func on_input(event: InputEvent) -> void:	
	if event is InputEventMouseMotion:
		card.global_position = card.get_global_mouse_position() - card.pivot_offset
		
		if card.card_data.is_single_targeted(Global.game.current_phase) and card.is_over_drop_area():
			transition_requested.emit(self, CardState.State.AIMING)
			return

	if event.is_action_pressed("right_mouse"):
		transition_requested.emit(self, CardState.State.BASE)
	elif minimum_drag_time_elapsed and event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse"):
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)
