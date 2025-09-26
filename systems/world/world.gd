class_name World
extends Node2D

const COTTAGE = preload("uid://g0kgyrmupti7")
const GOBLIN_ARMY = preload("uid://yglid8gk46oh")

@export var player: PlayerManager

@onready var hex_map: HexMap = $HexMap
@onready var player_mini: PlayerMini = $PlayerMini
@onready var structures_layer: TileMapLayer = %Structures

var structures: Dictionary[Vector2i, StructureData] = {}

func _ready() -> void:
	add_structure(GOBLIN_ARMY, Vector2i(1, 1))
	add_structure(COTTAGE, Vector2i(1, 0))

func get_structure(coord: Vector2i) -> StructureData:
	if structures.has(coord):
		return structures.get(coord)
	return null

func add_structure(structure_data: StructureData, coord: Vector2i) -> void:
	if structures.has(coord):
		Log.warn('Overwriting strucutre', 'World.gd', JSON.from_native(structures))
	
	var atlas_coord: Vector2i = (structure_data.icon.region.position as Vector2i) / Vector2i(32, 64)
	structures_layer.set_cell(coord, 0, atlas_coord)
	structures.set(coord, structure_data)
