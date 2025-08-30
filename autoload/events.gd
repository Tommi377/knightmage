#class_name Events
extends Node

var card := CardEvents.new()
var combat := CombatEvents.new()

func _ready() -> void:
	# FOR DEBUGGING
	# combat.enemy_died.connect(func(enemy): Log.debug(enemy.data.id))
	pass

class CardEvents:
	signal play(card: Card)

	signal aim_start(card: Card)
	signal aim_end(card: Card)

class CombatEvents:
	signal enemy_died(enemy: EnemyUnitData)
