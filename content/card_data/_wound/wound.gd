extends CardData

func get_target_mode(phase: Const.PlayPhase) -> Const.TargetMode:
	return Const.TargetMode.NONE

func play_default(_phase: Const.PlayPhase, _targets: Array[Node]) -> bool:
	return false
