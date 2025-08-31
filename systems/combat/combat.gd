class_name Combat
extends Node2D

signal combat_end

@export var enemy_datas: Array[EnemyUnitData]

@onready var enemy_manager: EnemyManager = %EnemyManager
@onready var end_phase_button: Button = %EndPhaseButton

const GOBLIN = preload("res://content/enemy/enemy_unit/enemy_unit_data/goblin/goblin.tres")

func _ready() -> void:
	enemy_manager.spawn_enemies(enemy_datas)
	
	end_phase_button.pressed.connect(_on_end_phase_pressed)

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

func _on_end_phase_pressed() -> void:
	if _try_combat_end():
		return
	if Global.game.current_phase == Const.PlayPhase.BLOCK:
		Global.game.set_phase(Const.PlayPhase.ATTACK)
	elif Global.game.current_phase == Const.PlayPhase.ATTACK:
		Global.game.end_turn()
