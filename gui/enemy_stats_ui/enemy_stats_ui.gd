class_name EnemyStatsUI
extends Control

@onready var health_label: Label = $Health/HealthLabel

@onready var attack: HBoxContainer = $Attack
@onready var attack_label: Label = $Attack/AttackLabel

func set_from_enemy(enemy_unit: EnemyUnit) -> void:
	set_health_ui(enemy_unit.health, enemy_unit.data.max_health)
	set_attack_ui(enemy_unit.damage)

func set_health_ui(health: int, max_health: int) -> void:
	health_label.text = "%s/%s" % [health, max_health]

func set_attack_ui(damage: int) -> void:
	attack_label.text = str(damage)
	attack.visible = damage != 0
