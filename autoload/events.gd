#class_name Events
extends Node
	

var card := CardEvents.new()

class CardEvents:
	signal play(card: Card)

	signal aim_start(card: Card)
	signal aim_end(card: Card)
