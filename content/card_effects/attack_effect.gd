class_name AttackEffect
extends CardEffect

var _damage: int
var _target: Object

func _init(damage: int, target: Object) -> void:
	print_debug("Deal %d damge to %s" % [damage, target])
