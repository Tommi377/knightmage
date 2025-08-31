class_name EnemyManager
extends Node2D

@onready var spawnpoints := get_children()

var enemy_units: Array[EnemyUnit] = []

func turn_start() -> void:
	for enemy in enemy_units:
		enemy.turn_start()

func spawn_enemies(enemies: Array[EnemyUnitData]) -> void:
	for enemy in enemies:
		spawn_enemy(enemy.duplicate())

func spawn_enemy(enemy_unit_data: EnemyUnitData) -> void:
	for spawnpoint in spawnpoints:
		if spawnpoint.get_child_count() == 0:
			var enemy := EnemyUnit.create_instance(spawnpoint, enemy_unit_data)
			enemy.enemy_died.connect(_on_enemy_died.bind(enemy))
			enemy_units.append(enemy)
			return

func get_enemy_count() -> int:
	return enemy_units.size()

func _on_enemy_died(enemy_unit: EnemyUnit) -> void:
	print(enemy_unit)
	enemy_units.erase(enemy_unit)
