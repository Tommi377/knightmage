class_name Combat
extends Node2D

@onready var enemies: Node2D = %Enemies

var enemy_count := 0

func _ready() -> void:
	spawn_enemy(load("res://content/enemy/enemy_unit/enemy_unit_data/goblin/goblin.tres"))
	spawn_enemy(load("res://content/enemy/enemy_unit/enemy_unit_data/goblin/goblin.tres"))

func spawn_enemy(enemy_unit_data: EnemyUnitData) -> void:
	EnemyUnit.create_instance(enemies.get_child(enemy_count), enemy_unit_data)
	enemy_count += 1
