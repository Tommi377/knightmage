class_name Hand
extends HBoxContainer

@export var _example_card: Card

func _ready() -> void:
	add_card(_example_card)

func add_card(card: Card) -> void:
	CardUI.create_instance(self, card)
	
