class_name Hand
extends HBoxContainer

@export var _example_card: CardData

func _ready() -> void:
	add_card(_example_card)
	add_card(_example_card)

func add_card(card_data: CardData) -> void:
	var card := Card.create_instance(self, card_data)
	card.card_reparent.connect(_on_card_reparent)
	
func _on_card_reparent(card: Card) -> void:
	card.disabled = true
	card.reparent(self)
	move_child.call_deferred(card, -1)
	card.set_deferred("disabled", false)
