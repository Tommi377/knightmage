class_name GameController
extends Node

signal phase_start(phase: Const.PlayPhase)
signal phase_end(phase: Const.PlayPhase)

const COMBAT = preload("res://systems/combat/combat.tscn")

# TEMP
const GOBLIN = preload("res://content/enemy/enemy_unit/enemy_unit_data/goblin/goblin.tres")

@onready var player: PlayerManager = $PlayerManager
@onready var message_center: MessageCenter = $MessageCenter

var current_combat: Combat

# Turn info
var current_turn := 0
var current_phase := Const.PlayPhase.BLOCK

func _init() -> void:
	Global.game  = self

func _ready() -> void :
	set_physics_process(false)
	instantiate_combat()

func instantiate_combat() -> void:
	current_combat = COMBAT.instantiate() as Combat
	current_combat.enemy_datas = [GOBLIN, GOBLIN]
	current_combat.combat_end.connect(_on_combat_end)
	add_child(current_combat)
	move_child(current_combat, 0)

func set_phase(phase: Const.PlayPhase) -> void:
	phase_end.emit(current_phase)
	current_phase = phase
	phase_start.emit(current_phase)

func start_turn() -> void:
	if current_combat:
		current_combat.turn_start()
	
func end_turn() -> void:
	player.draw_to_hand_limit()
	
	if current_combat:
		current_combat.turn_end()
		set_phase(Const.PlayPhase.BLOCK)
	else:
		set_phase(Const.PlayPhase.MOVEMENT)
	
	start_turn()


func _on_combat_end() -> void:
	current_combat = null
	message_center.display_message("Combat Over!")
	end_turn()
