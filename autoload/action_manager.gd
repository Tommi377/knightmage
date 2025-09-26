# class_name ActionManager
extends Node

var action_queue: Array[CardEffect] = []
var end_of_round_action_queue: Array[CardEffect] = []

func _process(_delta: float) -> void:
	await process_action()

func add_action(effect: CardEffect, timing: Const.EffectTiming = Const.EffectTiming.INSTANT) -> void:
	match (timing):
		Const.EffectTiming.INSTANT:
			action_queue.push_back(effect)
		Const.EffectTiming.TURN_END:
			end_of_round_action_queue.push_back(effect)

func process_action(timing: Const.EffectTiming = Const.EffectTiming.INSTANT) -> void:
	var queue: Array[CardEffect]
	match (timing):
		Const.EffectTiming.INSTANT:
			queue = action_queue
		Const.EffectTiming.TURN_END:
			queue = end_of_round_action_queue
		Const.EffectTiming.TURN_START:
			queue = []
		
	if queue.is_empty():
		return
	
	var effect := queue.pop_front() as CardEffect
	@warning_ignore("redundant_await")
	await effect.apply()
