extends CardData

func get_target_mode(phase: Const.PlayPhase) -> Const.TargetMode:
	return Const.TargetMode.NONE

func play(_phase: Const.PlayPhase, _player: PlayerManager, _targets: Array[Node]) -> bool:
	return false
