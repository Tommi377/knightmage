extends Label

@onready var player_manager: PlayerManager = $"../../PlayerManager"

var cached := 0

func _process(delta: float) -> void:
	if player_manager.current_move != cached:
		cached = player_manager.current_move
		text = "Move: %d" % [cached]
