extends Label

const phase_labels := {
	Const.PlayPhase.MOVEMENT: "Movement",
	Const.PlayPhase.INFLUENCE: "Influence",
	Const.PlayPhase.BLOCK: "Block",
	Const.PlayPhase.ATTACK: "Attack",
} 

func _ready() -> void:
	Global.game.phase_start.connect(_on_phase_start)
	_on_phase_start(Global.game.current_phase)

func _on_phase_start(phase: Const.PlayPhase) -> void:
	if phase_labels.has(phase):
		text = "Current Phase: %s" % [phase_labels[phase]]
	else:
		text = "Unknown Phase!"
