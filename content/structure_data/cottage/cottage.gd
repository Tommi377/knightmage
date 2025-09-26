extends StructureData

@export var draw_amount: int = 2

func apply_round_end(player: PlayerManager) -> bool:
	var draw_effect := DrawCardsEffect.new(player, draw_amount)
	ActionManager.add_action(draw_effect, Const.EffectTiming.TURN_END)
	return true
