class_name AttackEffect
extends CardEffect

var _damage: int
var _target: EnemyUnit

func _init(damage: int, target: EnemyUnit) -> void:
	assert(target is EnemyUnit, "Tried to instantiate AttackEffect on non-EnemyUnit")
	
	_damage = damage
	_target = target

func apply() -> void:
	# TODO: Modifiers
	_target.take_damage(_damage)

func get_description() -> String:
	return "Deal %d damage to %s" % [_damage, _target]
