extends CardData

@export var base_block: int

func get_description() -> String:
	return description % base_block

func _play_block(_player: PlayerManager, targets: Array[Node]) -> bool:
	if targets.is_empty():
		return false
	
	var block_effect := BlockEffect.new(targets[0], base_block)
	ActionManager.add_action(block_effect)
	return true
