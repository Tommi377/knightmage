class_name CombatEnemies
extends Node2D

@onready var spawnpoints := get_children()

func spawn_enemy(enemy_unit_data: EnemyUnitData) -> void:
	for spawnpoint in spawnpoints:
		if spawnpoint.get_child_count() == 0:
			EnemyUnit.create_instance(spawnpoint, enemy_unit_data)
			return

func get_enemy_count() -> int:
	return spawnpoints.filter(
		func(spawnpoint: Node) -> bool: return spawnpoint.get_child_count()
	).size()
