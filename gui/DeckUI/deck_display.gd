class_name DeckDisplay
extends Control

@onready var label: Label = $Label

func update_value(value: int) -> void:
	label.text = str(value)
	if value == 0:
		modulate.a = 0.5
	else:
		modulate.a = 1
