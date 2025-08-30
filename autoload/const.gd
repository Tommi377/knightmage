# class_name Const
extends Node

enum CardType { ATTACK, SKILL, POWER }
enum Rarity { COMMON, UNCOMMON, RARE }
enum Target { SELF, SINGLE_ENEMY, ALL_ENEMIES, EVERYONE }

enum PlayPhase { MOVEMENT, INFLUENCE, BLOCK, ATTACK }

const RARITY_COLORS := {
	Rarity.COMMON: Color.GRAY,
	Rarity.UNCOMMON: Color.CORNFLOWER_BLUE,
	Rarity.RARE: Color.GOLD,
}
