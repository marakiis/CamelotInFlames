class_name TargetSelectorComponent
extends Node

@export_subgroup("Settings")
@export var distance_min: float = 100
@export var distance_max: float = 300
@export var position_min: Vector2 = Vector2(0, 0)
# TODO # Get window settings
@export var position_max: Vector2 = Vector2(0, 0)

func getNextTarget(body: Node2D) -> Vector2:
	var vector = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	vector = vector * randf_range(distance_min, distance_max)
	
	var target = body.global_position + vector
	
	# Mirror vector value if target out of bound
	if target.x < position_min.x or target.x > position_max.x:
		vector.x = -vector.x
	if target.y < position_min.y or target.y > position_max.y:
		vector.y = -vector.y
	
	return body.global_position + vector
