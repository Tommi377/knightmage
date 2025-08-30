class_name EnemyUnit
extends Area2D

const MY_SCENE = preload("res://content/enemy/enemy_unit/enemy_unit.tscn")

@export var data: EnemyUnitData

@onready var enemy_stats_ui: EnemyStatsUI = $EnemyStatsUI
@onready var main_sprite: Sprite2D = $Visual/MainSprite
@onready var target_sprite: Sprite2D = $TargetSprite

@onready var health := data.max_health

static func create_instance(parent: Node, enemy_unit_data: EnemyUnitData) -> EnemyUnit:
	var instance := MY_SCENE.instantiate() as EnemyUnit
	instance.data = enemy_unit_data.duplicate()
	parent.add_child(instance)
	return instance

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	_ready_enemy()

func take_damage(damage: int) -> void:
	if health <= 0:
		Log.warn("Tried to take_damage while at 0 hp", "EnemyUnit", self)
		return
	
	health -= damage
	_update_ui()
	if health <= 0:
		health = 0
		die()

func die() -> void:
	Events.combat.enemy_died.emit(data)
	var die_tween := create_tween()
	die_tween.tween_property(self, "modulate", Color(1, 1, 1, 0), 0.5)
	die_tween.tween_callback(queue_free)

func _ready_enemy() -> void:
	main_sprite.texture = data.texture
	_update_ui()

func _update_ui() -> void:
	enemy_stats_ui.set_health_ui(health, data.max_health)

func _on_mouse_entered() -> void:
	target_sprite.show()
	pass

func _on_mouse_exited() -> void:
	target_sprite.hide()
	pass
