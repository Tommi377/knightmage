#class_name Events
extends Node

var card := CardEvents.new()

func _ready() -> void:
	# FOR DEBUGGING
	# card.draw.connect(func(c): Log.debug("EVENT"))
	pass

class CardEvents:
	signal play(card: Card)

	signal aim_start(card: Card)
	signal aim_end(card: Card)
