extends CardData

@export var base_damage: int

func get_description() -> String:
	return description % base_damage

func _play_attack(_player: PlayerManager, targets: Array[Node]) -> bool:
	if targets.is_empty():
		return false
	
	var damage_effect := AttackEffect.new(targets[0], base_damage)
	ActionManager.add_action(damage_effect)
	return true
