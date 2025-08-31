extends CardData

@export var base_block: int

func get_description() -> String:
	return description % base_block

func play_block(targets: Array[Node]) -> bool:
	if targets.is_empty():
		return false
	
	var damage_effect := BlockEffect.new(base_block, targets[0])
	ActionManager.add_action(damage_effect)
	return true
