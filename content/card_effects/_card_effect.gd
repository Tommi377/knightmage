class_name CardEffect
extends RefCounted

var _duration := Const.EffectApplyDuration.ONESHOT

func apply() -> void:
	assert(false, "CardEffect.apply() must be overridden")

func get_description() -> String:
	return 'NO DESCRIPTION FOR EFFECT'
