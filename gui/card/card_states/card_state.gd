class_name CardState
extends Node

enum State {BASE, CLICKED, DRAGGING, AIMING, RELEASED}

@warning_ignore("unused_signal")
signal transition_requested(from: CardState, to: State)

var card: Card

func get_state_id() -> State:
	assert(false, "(CardState) Please override `get_state_id()` in the derived script.")
	@warning_ignore("int_as_enum_without_cast", "int_as_enum_without_match")
	return -1

func enter() -> void:
	pass


func exit() -> void:
	pass


func post_enter() -> void:
	pass


func on_input(_event: InputEvent) -> void:
	pass


func on_gui_input(_event: InputEvent) -> void:
	pass


func on_mouse_entered() -> void:
	pass


func on_mouse_exited() -> void:
	pass
