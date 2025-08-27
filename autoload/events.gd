#class_name Events
extends Node


var card = CardEvents.new()

class CardEvents:
	signal played(card: Card)

	signal aim_start(card_ui: CardUI)
	signal aim_end(card_ui: CardUI)
