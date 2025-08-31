extends CardData

@export var base_damage: int

func get_description() -> String:
	return description % base_damage

func play_attack(targets: Array[Node]) -> bool:
	if targets.is_empty():
		return false
	
	var damage_effect := AttackEffect.new(base_damage, targets[0])
	ActionManager.add_action(damage_effect)
	return true
