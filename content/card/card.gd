class_name Card
extends Resource

@export_group("Card Attributes")
@export var id: String
@export var type: Const.CardType
@export var rarity: Const.Rarity
@export var target: Const.Target

@export_group("Card Visuals")
@export var icon: Texture
@export_multiline var tooltip_text: String

func is_single_targeted() -> bool:
	return target == Const.Target.SINGLE_ENEMY

func _get_targets(targets: Array[Node]) -> Array[Node]:
	if not targets:
		return []
		
	var tree := targets[0].get_tree()
	
	match target:
		Const.Target.SELF:
			return tree.get_nodes_in_group("player")
		Const.Target.ALL_ENEMIES:
			return tree.get_nodes_in_group("enemies")
		Const.Target.EVERYONE:
			return tree.get_nodes_in_group("player") + tree.get_nodes_in_group("enemies")
		_:
			return []

func play(targets: Array[Node]) -> void:
	Events.card.played.emit(self)
	
	if is_single_targeted():
		apply_effects(targets)
	else:
		apply_effects(_get_targets(targets))
		

func apply_effects(_targets: Array[Node]) -> void:
	pass

func get_tooltip() -> String:
	return tooltip_text
