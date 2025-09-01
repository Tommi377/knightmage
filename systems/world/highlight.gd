class_name Highlight
extends TileMapLayer

@export var tile: Vector2i
@export var atlas_id: int

func _process(_delta: float) -> void:
	if not enabled:
		return

	var selected_tile := self.local_to_map(self.get_local_mouse_position())

	_update_tile(selected_tile)

func _update_tile(selected_tile: Vector2i) -> void:
	self.clear()
	self.set_cell(selected_tile, atlas_id, tile)
