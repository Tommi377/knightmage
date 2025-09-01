class_name MoveEffect
extends CardEffect

var _move: int

func _init(move: int) -> void:	
	_move = move

func apply() -> void:
	# TODO: Modifiers
	Global.game.player.current_move += _move

func get_description() -> String:
	return "Move %d" % [_move]
