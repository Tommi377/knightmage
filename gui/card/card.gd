class_name Card
extends Control

signal card_reparent(card: Card)

const MY_SCENE = preload("res://gui/card/card.tscn")

@export var card_data: CardData

@onready var icon: TextureRect = %Icon
@onready var card_drop: Area2D = %CardDropAreaDetector
@onready var card_state_machine: CardStateMachine = %CardStateMachine

var init_parent: Node
var drop_area: Area2D
var tween: Tween

var targets: Array[Node] = []
var playable := true
var disabled := false

static func create_instance(parent: Node, _card_data: CardData) -> Card:
	var instance := MY_SCENE.instantiate() as Card
	instance.card_data = _card_data.duplicate()
	instance.init_parent = parent
	parent.add_child(instance)
	return instance

func _ready() -> void:
	update_ui()
	init_state_machine()
	
	card_drop.area_entered.connect(_on_card_drop_area_entered)
	card_drop.area_exited.connect(_on_card_drop_area_exited)

func play() -> void:
	if not card_data:
		return
	
	var success := card_data.play(Const.PlayPhase.ATTACK, targets)
	if success:
		queue_free()

func is_over_drop_area() -> bool:
	return drop_area != null

func update_ui() -> void:
	icon.texture = card_data.icon

func init_state_machine() -> void:
	card_state_machine.init(self)
	mouse_entered.connect(card_state_machine.on_mouse_entered)
	mouse_exited.connect(card_state_machine.on_mouse_exited)
	gui_input.connect(card_state_machine.on_gui_input)

func animate_to_position(new_position: Vector2, duration: float) -> void:
	tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", new_position, duration)

func _on_card_drop_area_entered(area: Area2D) -> void:
	drop_area = area

func _on_card_drop_area_exited(_area: Area2D) -> void:
	drop_area = null
