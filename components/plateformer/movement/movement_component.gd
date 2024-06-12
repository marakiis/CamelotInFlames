class_name MovementComponent
extends Node

@export_category("Settings")
@export var speed: float = 100
@export var ground_accel_speed = speed
@export var ground_decel_speed = speed
@export var air_accel_speed = speed
@export var air_decel_speed = speed

func handle_horizontal_movement(body: CharacterBody2D, direction: float) -> void:
	var delta_velocity = 0
	if body.is_on_floor():
		delta_velocity = ground_decel_speed
		if direction != 0:
			delta_velocity = ground_accel_speed
	else:
		delta_velocity = air_decel_speed
		if direction != 0:
			delta_velocity = air_accel_speed
	body.velocity.x = move_toward(body.velocity.x, direction * speed, delta_velocity)
	return
