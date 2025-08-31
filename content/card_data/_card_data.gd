class_name CardData
extends Resource

@export_group("Card Attributes")
@export var id: String
@export var type: Const.CardType
@export var rarity: Const.Rarity
@export var target: Const.Target

@export_group("Card Visuals")
@export var icon: Texture
@export_multiline var description: String

# CHILD TODO LIST
# 1. Implement necessary functions
#    a. func play_movement()
#    b. func play_influence()
#    c. func play_block()
#    d. func play_attack()

func is_single_targeted() -> bool:
	return target == Const.Target.SINGLE_ENEMY

func get_targets(node_in_tree: Node) -> Array[Node]:
	if not node_in_tree:
		return []
		
	var tree := node_in_tree.get_tree()
	
	match target:
		Const.Target.SELF:
			return tree.get_nodes_in_group("player")
		Const.Target.ALL_ENEMIES:
			return tree.get_nodes_in_group("enemies")
		Const.Target.EVERYONE:
			return tree.get_nodes_in_group("player") + tree.get_nodes_in_group("enemies")
		Const.Target.SINGLE_ENEMY:
			return tree.get_first_node_in_group("aim_target").get_target()
		_:
			return []

func has_movement() -> bool:
	return 'play_movement' in self
func has_influence() -> bool:
	return 'play_influence' in self
func has_block() -> bool:
	return 'play_block' in self
func has_attack() -> bool:
	return 'play_attack' in self

func play(phase: Const.PlayPhase, targets: Array[Node]) -> bool:
	if targets.is_empty():
		return false
	
	var card_played := false
	match phase:
		Const.PlayPhase.MOVEMENT when has_movement():
			card_played = call("play_movement", targets)
		Const.PlayPhase.INFLUENCE when has_influence():
			card_played = call("play_influence", targets)
		Const.PlayPhase.BLOCK when has_block():
			card_played = call("play_block", targets)
		Const.PlayPhase.ATTACK when has_attack():
			card_played = call("play_attack", targets)
		_:
			# Kinda scuffed to have a different function signature than the rest
			# TODO: Investigate wheter this will be a problem in the future
			card_played = play_default(phase, targets)
	if card_played:
		Events.card.play.emit(self)
	return card_played

func play_default(phase: Const.PlayPhase, targets: Array[Node]) -> bool:
	match phase:
		Const.PlayPhase.BLOCK:
			ActionManager.add_action(BlockEffect.new(1, targets[0]))
		Const.PlayPhase.ATTACK:
			ActionManager.add_action(AttackEffect.new(1, targets[0]))
	return true

func get_description() -> String:
	return description
