class_name Hand
extends HBoxContainer

var _play_handler: Callable

func update_ui(hand_cards: Array[CardData]) -> void:
	for child in get_children():
		child.queue_free()
	for card in hand_cards:
		_add_card(card)

func _add_card(card_data: CardData) -> void:
	var card := Card.create_instance(self, card_data)
	card.card_reparent.connect(_on_card_reparent)
	if _play_handler.is_valid():
		card.card_play_request.connect(_play_handler)

func _on_card_reparent(card: Card) -> void:
	card.disabled = true
	card.reparent(self)
	move_child.call_deferred(card, Global.game.player.hand.find(card.card_data))
	card.set_deferred("disabled", false)
