extends StructureData

@export var units: Array[EnemyUnitData] = []

func apply_enter(_player: PlayerManager) -> bool:
	Global.game.instantiate_combat(units)
	return true
