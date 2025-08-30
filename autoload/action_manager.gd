# class_name ActionManager
extends Node

var action_queue: Array[CardEffect] = []

func _process(delta: float) -> void:
	await process_action()

func add_action(effect: CardEffect) -> void:
	action_queue.push_back(effect)

func process_action() -> void:
	if action_queue.is_empty():
		return
	
	var effect := action_queue.pop_front() as CardEffect
	await effect.apply()
