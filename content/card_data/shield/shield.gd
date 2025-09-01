extends CardData

@export var base_block: int

func get_description() -> String:
	return description % base_block

func play_block(targets: Array[Node]) -> bool:
	if targets.is_empty():
		return false
	
	var block_effect := BlockEffect.new(base_block, targets[0])
	ActionManager.add_action(block_effect)
	return true
