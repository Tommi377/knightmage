class_name AttackEffect
extends CardEffect

var _target: EnemyUnit
var _damage: int

func _init(target: EnemyUnit, damage: int) -> void:
	assert(target is EnemyUnit, "Tried to instantiate AttackEffect on non-EnemyUnit")
	
	_target = target
	_damage = damage

func apply() -> void:
	# TODO: Modifiers
	_target.take_damage(_damage)

func get_description() -> String:
	return "Deal %d damage to %s" % [_damage, _target]
