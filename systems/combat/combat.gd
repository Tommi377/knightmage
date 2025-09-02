class_name Combat
extends Node2D

signal combat_end

@export var enemy_datas: Array[EnemyUnitData]

@onready var enemy_manager: EnemyManager = %EnemyManager

const GOBLIN = preload("res://content/enemy/enemy_unit/enemy_unit_data/goblin/goblin.tres")

func _ready() -> void:
	enemy_manager.spawn_enemies(enemy_datas)
	

func turn_start() -> void:
	enemy_manager.turn_start()

func turn_end() -> void:
	pass

func _try_combat_end() -> bool:
	if enemy_manager.get_enemy_count() == 0:
		# Combat end logic
		Log.info("Combat end!!!")
		combat_end.emit()
		return true
	return false
