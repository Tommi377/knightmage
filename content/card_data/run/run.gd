extends CardData

@export var base_move: int

func get_description() -> String:
	return description % base_move

func play_move(targets: Array[Node]) -> bool:	
	var move_effect := MoveEffect.new(base_move)
	ActionManager.add_action(move_effect)
	return true
