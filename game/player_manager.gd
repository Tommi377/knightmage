class_name PlayerManager
extends Node

const WOUND = preload("res://content/card_data/_wound/wound.tres")
const SHIELD = preload("res://content/card_data/shield/shield.tres")
const SLASH = preload("res://content/card_data/slash/slash.tres")
const RUN = preload("res://content/card_data/run/run.tres")

var hand_limit := 5
var armor := 3

var current_move := 0
var current_coord := Vector2i(0, 0)

var draw_pile: Array[CardData] = []
var discard_pile: Array[CardData] = []
var hand: Array[CardData] = []

@onready var player_mini: Node = get_tree().get_first_node_in_group("player_mini")

@onready var hand_display: Hand = %HandDisplay
@onready var draw_display: DeckDisplay = %DrawPile
@onready var discard_display: DeckDisplay = %DiscardPile

func _ready() -> void:
	hand_display._play_handler = Callable(self, "play_card")
	
	_load_deck([RUN, RUN, RUN, RUN, SHIELD, SHIELD, SHIELD, SHIELD, SLASH, SLASH, SLASH, SLASH])
	shuffle_to_draw_pile()
	draw_to_hand_limit()
	_update_deck_ui()

func turn_end() -> void:
	current_move = 0
	draw_to_hand_limit()

func play_card(card_data: CardData) -> void:
	if not card_data:
		return
	
	var targets := card_data.get_targets(Global.game.current_phase, self)
	var success := card_data.play(Global.game.current_phase, self, targets)
	if success:
		hand.erase(card_data)
		discard_pile.append(card_data)
	
	_update_deck_ui()

func take_damage(damage: int) -> void:
	var wounds_received: float = ceil(damage as float / armor)
	for _i in range(0, wounds_received):
		hand.append(WOUND.duplicate())
	_update_deck_ui()

func shuffle_to_draw_pile() -> void:
	draw_pile.append_array(discard_pile)
	draw_pile.shuffle()
	discard_pile.clear()

func draw_to_hand_limit() -> void:
	for _i in range(hand.size(), hand_limit):
		draw_card()
	_update_deck_ui()

func draw_card() -> void:
	if draw_pile.is_empty():
		shuffle_to_draw_pile()
	
	var card_data := draw_pile.pop_front() as CardData
	hand.append(card_data)

func _update_deck_ui() -> void:
	hand_display.update_ui(hand)
	draw_display.update_value(draw_pile.size())
	discard_display.update_value(discard_pile.size())


func _load_deck(card_datas: Array[CardData]) -> void:
	for card_data in card_datas:
		draw_pile.append(card_data.duplicate())
