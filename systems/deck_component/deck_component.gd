class_name DeckComponent
extends RefCounted

var _owner: Node

var hand: Array[CardData] = []
var draw_pile: Array[CardData] = []
var discard_pile: Array[CardData] = []

func _init(owner: Node, cards: Array[CardData]) -> void:
	_owner = owner
	for card in cards:
		draw_pile.append(card.duplicate())

func draw_to_hand_limit() -> void:
	for _i in range(hand.size(), _owner.hand_limit):
		draw_card()

func add_card(card: CardData) -> void:
	discard_pile.append(card)

func shuffle_to_draw_pile() -> void:
	draw_pile.append_array(discard_pile)
	draw_pile.shuffle()
	discard_pile.clear()

func draw_card() -> void:
	var card_data := draw_pile.pop_front() as CardData
	hand.append(card_data)
