class_name BlockEffect
extends CardEffect

var _target: EnemyUnit
var _block: int

func _init(target: EnemyUnit, block: int) -> void:
	assert(target is EnemyUnit, "Tried to instantiate BlockEffect on non-EnemyUnit")
	
	_target = target
	_block = block

func apply() -> void:
	# TODO: Modifiers
	_target.take_block(_block)

func get_description() -> String:
	return "Deal %d block to %s" % [_block, _target]
