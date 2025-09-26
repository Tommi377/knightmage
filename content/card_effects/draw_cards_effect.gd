class_name DrawCardsEffect
extends CardEffect

var _target: PlayerManager
var _amount: int

func _init(target: PlayerManager, amount: int) -> void:
	_target = target
	_amount = amount

func apply() -> void:
	# TODO: Modifiers
	for i in range(0, _amount):
		_target.draw_card()

func get_description() -> String:
	return "Move %d" % [_amount]
