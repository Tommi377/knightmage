class_name Hand
extends HBoxContainer

@export var _example_card: Card

func _ready() -> void:
	add_card(_example_card)

func add_card(card: Card) -> void:
	var card_ui := CardUI.create_instance(self, card)
	card_ui.card_reparent.connect(_on_card_reparent)
	
func _on_card_reparent(card_ui: CardUI) -> void:
	card_ui.disabled = true
	card_ui.reparent(self)
	move_child.call_deferred(card_ui, -1)
	card_ui.set_deferred("disabled", false)
