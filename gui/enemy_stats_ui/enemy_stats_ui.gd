class_name EnemyStatsUI
extends HBoxContainer

@onready var health_label: Label = $Health/HealthLabel

func set_health_ui(health: int, max_health: int) -> void:
	health_label.text = "%s/%s" % [health, max_health]
