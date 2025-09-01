class_name PlayerMini
extends Area2D

@export var walk_tween_curve: Curve

var tween: Tween

const WALK_ANIMATION_SEC = 0.6

func move_to(goal: Vector2) -> void:
	if tween:
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN)
	tween.tween_property(self, "global_position", goal, WALK_ANIMATION_SEC).set_custom_interpolator(bouncy_tween_curve)

func bouncy_tween_curve(v):
	return walk_tween_curve.sample_baked(v)
