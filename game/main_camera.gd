class_name MainCamera
extends Camera2D

func _process(delta: float) -> void:
	await get_tree().process_frame
	center_on_player()

func center_on_player() -> void:
	var player_mini := Global.game.player.player_mini
	if player_mini:
		global_position = player_mini.global_position - get_viewport_rect().size * 0.5
