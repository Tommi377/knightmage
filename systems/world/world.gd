class_name World
extends Node2D

@export var player: PlayerManager

@onready var hex_map: HexMap = $HexMap
@onready var player_mini: PlayerMini = $PlayerMini
@onready var structures_layer: TileMapLayer = %Structures

var structures: Array[Node]

func _ready() -> void:
	for coord in structures_layer.get_used_cells():
		var structure_id = structures_layer.get_cell_atlas_coords(coord)
		print(str(structure_id) + ' at ' + str(coord))
	pass
