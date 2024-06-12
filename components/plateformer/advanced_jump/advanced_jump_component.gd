class_name AdvancedJumpComponent
extends Node

@export_subgroup("Nodes")
@export var jump_buffer_timer: Timer
@export var coyote_timer: Timer
@export var audio_player: AudioStreamPlayer2D

@export_subgroup("Settings")
@export var jump_velocity: float = -350

@export_subgroup("Sounds")
@export var jump_sound: AudioStream
@export var fall_sound: AudioStream

var is_going_up: bool = false
var is_jumping: bool = false
var last_frame_on_floor: bool = false

func handle_jump(body: CharacterBody2D, want_to_jump: bool, jump_release: bool) -> void:
	if has_just_landed(body):
		is_jumping = false
		audio_player.stream = fall_sound
		audio_player.play()
	
	if want_to_jump and is_allowed_to_jump(body):
		jump(body)
		audio_player.stream = jump_sound
		audio_player.play()
	
	handle_coyote_time(body)
	handle_jump_buffer(body, want_to_jump)
	handle_variable_jump_high(body, jump_release)
	is_going_up = body.velocity.y < 0 and not body.is_on_floor()
	last_frame_on_floor = body.is_on_floor()

func is_allowed_to_jump(body: CharacterBody2D) -> bool:
	return body.is_on_floor() or not coyote_timer.is_stopped()

func jump(body: CharacterBody2D):
	body.velocity.y = jump_velocity
	jump_buffer_timer.stop()
	is_jumping = true
	coyote_timer.stop()

func handle_variable_jump_high(body: CharacterBody2D, jump_release: bool) -> void:
	if jump_release and is_going_up:
		body.velocity.y = 0	

func handle_jump_buffer(body: CharacterBody2D, want_to_jump: bool) -> void:
	if want_to_jump and not body.is_on_floor():
		jump_buffer_timer.start()
	
	if body.is_on_floor() and not jump_buffer_timer.is_stopped():
		jump(body)

func has_just_landed(body: CharacterBody2D) -> bool:
	return body.is_on_floor() and not last_frame_on_floor # and is_jumping

func has_just_step_off_ledge(body: CharacterBody2D) -> bool:
	return not body.is_on_floor() and last_frame_on_floor and not is_jumping

func handle_coyote_time(body: CharacterBody2D) -> void:
	if has_just_step_off_ledge(body):
		coyote_timer.start()

	if not coyote_timer.is_stopped() and not is_jumping:
		body.velocity.y = 0
