extends CardData

@export var base_move: int

func get_description() -> String:
	return description % base_move

func _play_move(player: PlayerManager, _targets: Array[Node]) -> bool:
	var move_effect := MoveEffect.new(player, base_move)
	ActionManager.add_action(move_effect)
	return true
