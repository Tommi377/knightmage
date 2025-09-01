class_name CardData
extends Resource

@export_group("Card Attributes")
@export var id: String
@export var rarity: Const.Rarity
@export var target_modes: Dictionary[Const.PlayPhase, Const.TargetMode]

@export_group("Card Visuals")
@export var icon: Texture
@export_multiline var description: String

# CHILD TODO LIST
# 1. Implement necessary functions
#    a. func play_move()
#    b. func play_influence()
#    c. func play_block()
#    d. func play_attack()

func get_target_mode(phase: Const.PlayPhase) -> Const.TargetMode:
	if not is_phase_compatible(phase):
		match phase:
			Const.PlayPhase.MOVEMENT:
				return Const.TargetMode.NONE
			Const.PlayPhase.INFLUENCE:
				return Const.TargetMode.NONE
			Const.PlayPhase.BLOCK:
				return Const.TargetMode.SINGLE_ENEMY
			Const.PlayPhase.ATTACK:
				return Const.TargetMode.SINGLE_ENEMY
	
	return target_modes.get(phase, Const.TargetMode.NONE)

func is_single_targeted(phase: Const.PlayPhase) -> bool:
	return get_target_mode(phase) == Const.TargetMode.SINGLE_ENEMY

func get_targets(phase: Const.PlayPhase, node_in_tree: Node) -> Array[Node]:
	if not node_in_tree:
		return []

	var tree := node_in_tree.get_tree()
	
	match get_target_mode(phase):
		Const.TargetMode.SINGLE_ENEMY:
			return tree.get_first_node_in_group("aim_target").get_target()
		_:
			return []

func has_move() -> bool:
	return 'play_move' in self
func has_influence() -> bool:
	return 'play_influence' in self
func has_block() -> bool:
	return 'play_block' in self
func has_attack() -> bool:
	return 'play_attack' in self

func is_phase_compatible(phase: Const.PlayPhase) -> bool:
	match phase:
		Const.PlayPhase.MOVEMENT:
			return has_move()
		Const.PlayPhase.INFLUENCE:
			return has_influence()
		Const.PlayPhase.BLOCK:
			return has_block()
		Const.PlayPhase.ATTACK:
			return has_attack()
	return false

func play(phase: Const.PlayPhase, targets: Array[Node]) -> bool:
	var card_played := false
	match phase:
		Const.PlayPhase.MOVEMENT when has_move():
			card_played = call("play_move", targets)
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
		Const.PlayPhase.MOVEMENT:
			ActionManager.add_action(MoveEffect.new(1))
		Const.PlayPhase.BLOCK:
			ActionManager.add_action(BlockEffect.new(1, targets[0]))
		Const.PlayPhase.ATTACK:
			ActionManager.add_action(AttackEffect.new(1, targets[0]))
		_:
			assert(false, "Tried to play default in an unknown play phase")
	return true

func get_description() -> String:
	return description
