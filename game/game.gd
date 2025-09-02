class_name GameController
extends Node

signal phase_start(phase: Const.PlayPhase)
signal phase_end(phase: Const.PlayPhase)


const COMBAT = preload("res://systems/combat/combat.tscn")

# TEMP
const GOBLIN = preload("res://content/enemy/enemy_unit/enemy_unit_data/goblin/goblin.tres")

@onready var player: PlayerManager = $PlayerManager
@onready var world: World = $World

@onready var message_center: MessageCenter = %MessageCenter
@onready var scene_holder: Node = %SceneHolder

var current_combat: Combat

# Turn info
var current_turn := 0
var current_phase := Const.PlayPhase.MOVEMENT

func _init() -> void:
	Global.game  = self

func _ready() -> void :
	set_physics_process(false)
	# instantiate_combat()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		try_move_player()

func instantiate_combat() -> void:
	current_combat = COMBAT.instantiate() as Combat
	current_combat.enemy_datas = [GOBLIN]
	current_combat.combat_end.connect(_on_combat_end)
	set_phase(Const.PlayPhase.BLOCK)
	scene_holder.add_child(current_combat)

func set_phase(phase: Const.PlayPhase) -> void:
	phase_end.emit(current_phase)
	current_phase = phase
	phase_start.emit(current_phase)

func start_turn() -> void:
	if current_combat:
		current_combat.turn_start()
	
func end_turn() -> void:
	player.turn_end()
	
	if current_combat:
		current_combat.turn_end()
		set_phase(Const.PlayPhase.BLOCK)
	else:
		set_phase(Const.PlayPhase.MOVEMENT)
	
	start_turn()

func end_phase() -> void:
	if current_combat:
		if current_combat._try_combat_end():
			Global.game.end_turn()
		if current_phase == Const.PlayPhase.BLOCK:
			current_combat.enemy_manager.block_end()
			Global.game.set_phase(Const.PlayPhase.ATTACK)
		elif Global.game.current_phase == Const.PlayPhase.ATTACK:
			Global.game.end_turn()
	else:
		Global.game.end_turn()

func try_move_player() -> void:
	# TODO: Make this based on terrain type
	if player.current_move >= 2:
		player.current_move -= 2
		var tile := world.hex_map.get_hovered_tile()
		var goal := world.hex_map.map_to_global(world.hex_map.get_hovered_tile())
		world.player_mini.move_to(goal)
		player.current_coord = tile
		
		if check_encounter():
			instantiate_combat()
	else:
		message_center.send("Not enough movement!")

func check_encounter() -> bool:
	print(player.current_coord)
	if player.current_coord == Vector2i(0, -1):
		return true
	return false


func _on_combat_end() -> void:
	current_combat.queue_free()
	current_combat = null
	message_center.send("Combat Over!")
	end_turn()


func _on_end_phase_button_pressed() -> void:
	end_phase()
