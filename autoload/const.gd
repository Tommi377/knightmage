# class_name Const
extends Node

enum CardType { ATTACK, SKILL, POWER }
enum Rarity { BASIC, COMMON, UNCOMMON, RARE }
enum TargetMode { NONE, SINGLE_ENEMY }

enum PlayPhase { MOVEMENT, INFLUENCE, BLOCK, ATTACK }

enum EffectApplyDuration { ONESHOT, CONSTANT }

enum EffectTiming { INSTANT, TURN_START, TURN_END }

enum StructureCategory {
	BATTLE,
	DUNGEON,
	TRADE,
	BONUS,
	BOSS,
}

const GlobalGroups := {
	"GAME_UI": "game_ui_layer"
}

const RARITY_COLORS := {
	Rarity.COMMON: Color.GRAY,
	Rarity.UNCOMMON: Color.CORNFLOWER_BLUE,
	Rarity.RARE: Color.GOLD,
}
