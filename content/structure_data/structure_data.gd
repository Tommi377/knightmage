class_name StructureData
extends Resource

@export_group("Structure Attributes")
@export var id: String
@export var category: Const.StructureCategory
@export_range(1, 3) var tier: int

@export_group("Card Visuals")
@export var icon: Texture
@export_multiline var description: String
