class_name DamageEffect
extends Effect

var amount := 0

func execute(targets: Array[Node]) -> void:
	for target in targets:
		if not target:
			continue
		# TODO: Take damage
		#if target is Enemy or target is Player:
			#target.take_damage(amount, receiver_modifier_type)
			#SFXPlayer.play(sound)
