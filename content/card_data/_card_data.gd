class_name CardData
extends Resource

@export_group("Card Attributes")
@export var id: String
@export var rarity: Const.Rarity
@export var supported_phases: Dictionary[Const.PlayPhase, Const.TargetMode]

@export_group("Card Visuals")
@export var icon: Texture
@export_multiline var description: String

# CHILD TODO LIST
# 1. Implement necessary functions
#    a. func _play_move()
#    b. func _play_influence()
#    c. func _play_block()
#    d. func _play_attack()

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
	
	return supported_phases.get(phase, Const.TargetMode.NONE)

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
	return supported_phases.has(Const.PlayPhase.MOVEMENT)
func has_influence() -> bool:
	return supported_phases.has(Const.PlayPhase.INFLUENCE)
func has_block() -> bool:
	return supported_phases.has(Const.PlayPhase.BLOCK)
func has_attack() -> bool:
	return supported_phases.has(Const.PlayPhase.ATTACK)

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

func play(phase: Const.PlayPhase, player: PlayerManager, targets: Array[Node]) -> bool:
	var card_played := false
	match phase:
		Const.PlayPhase.MOVEMENT:
			card_played = _play_move(player, targets)
		Const.PlayPhase.INFLUENCE:
			card_played = _play_influence(player, targets)
		Const.PlayPhase.BLOCK:
			card_played = _play_block(player, targets)
		Const.PlayPhase.ATTACK:
			card_played = _play_attack(player, targets)
	if card_played:
		Events.card.play.emit(self)
	return card_played

func get_description() -> String:
	return description

func _play_move(player: PlayerManager, _targets: Array[Node]) -> bool:
	ActionManager.add_action(MoveEffect.new(player, 1))
	return true

func _play_influence(_player: PlayerManager, targets: Array[Node]) -> bool:
	printerr("Implement _play_influence()")
	return true
	
func _play_block(_player: PlayerManager, targets: Array[Node]) -> bool:
	ActionManager.add_action(BlockEffect.new(targets[0], 1))
	return true

func _play_attack(_player: PlayerManager, targets: Array[Node]) -> bool:
	ActionManager.add_action(AttackEffect.new(targets[0], 1))
	return true
