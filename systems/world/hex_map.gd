class_name HexMap
extends TileMapLayer

func map_to_global(map_coord: Vector2i) -> Vector2:
	return to_global(map_to_local(map_coord))

func global_to_map(global_pos: Vector2) -> Vector2i:
	return local_to_map(to_local(global_pos))

func get_hovered_tile() -> Vector2i:
	return local_to_map(get_local_mouse_position())
