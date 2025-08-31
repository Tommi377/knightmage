class_name BlockEffect
extends CardEffect

var _block: int
var _target: EnemyUnit

func _init(block: int, target: EnemyUnit) -> void:
	assert(target is EnemyUnit, "Tried to instantiate BlockEffect on non-EnemyUnit")
	
	_block = block
	_target = target

func apply() -> void:
	# TODO: Modifiers
	_target.take_block(_block)

func get_description() -> String:
	return "Deal %d block to %s" % [_block, _target]
