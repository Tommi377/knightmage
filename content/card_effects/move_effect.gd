class_name MoveEffect
extends CardEffect

var _target: PlayerManager
var _move: int

func _init(target: PlayerManager, move: int) -> void:
	_target = target
	_move = move

func apply() -> void:
	# TODO: Modifiers
	_target.current_move += _move

func get_description() -> String:
	return "Move %d" % [_move]
