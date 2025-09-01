class_name World
extends Node2D

@export var player: PlayerManager

@onready var hex_map: HexMap = $HexMap
@onready var player_mini: PlayerMini = $PlayerMini
