class_name FloaterComponent
extends Node

@export_subgroup("Settings")
@export var speed: float = 350
@export var target_tolerance: float = 10
@export var snap_target: bool = true

func _get_target_direction(body: Node2D, target: Vector2) -> Vector2:
	if target != null:
		return target - body.global_position
	return Vector2(0, 0)

func is_at_destination(body: CharacterBody2D, target: Vector2) -> bool:
	return (target - body.global_position).length() < target_tolerance

func handle_movement(body: CharacterBody2D, target: Vector2) -> void:
	if is_at_destination(body, target):
		if snap_target:
			body.global_position = target
		body.velocity = Vector2(0, 0)
	var direction = _get_target_direction(body, target)
	body.velocity = direction.normalized() * speed
	return


