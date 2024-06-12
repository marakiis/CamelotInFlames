extends Control

@onready var main_menu = $MainMenu
@onready var instructions = $Instructions
@onready var start_button = $MainMenu/HBoxContainer/VBoxContainer/Play
@onready var instructions_button = $MainMenu/HBoxContainer/VBoxContainer/Instructions
@onready var exit_button = $MainMenu/HBoxContainer/VBoxContainer/Quit

func _ready():
	Global.easy_mode = false
	main_menu.visible = true
	instructions.visible = false
	start_button.button_down.connect(on_start_pressed)
	instructions_button.button_down.connect(on_instructions_pressed)
	exit_button.button_down.connect(on_exit_pressed)

func _on_music_finished():
	$Music.play()

func on_start_pressed():
	Global.switch_to_game()
	return

func on_instructions_pressed():
	show_instructions()
	return

func on_exit_pressed():
	get_tree().quit()

func _on_check_button_toggled(toggled_on):
	Global.easy_mode = toggled_on

@onready var scenario_1 = $Instructions/MarginContainer/Scenario1
@onready var scenario_2 = $Instructions/MarginContainer/Scenario2
@onready var how_to_play = $Instructions/MarginContainer/HowToPlay

var state = SCENARIO_1

@onready var left_sprite = $Instructions/MarginContainer/HowToPlay/Left/AnimatedSprite2D
@onready var right_sprite = $Instructions/MarginContainer/HowToPlay/Right/AnimatedSprite2D
@onready var jumping_sprite = $Instructions/MarginContainer/HowToPlay/Jump/AnimatedSprite2D
var jumping: bool = false

enum  {
	SCENARIO_1,
	SCENARIO_2,
	INSTRUCTIONS
}

func show_instructions():
	main_menu.visible = false
	instructions.visible = true
	scenario_1.visible = true
	scenario_2.visible = false
	how_to_play.visible = false
	state = SCENARIO_1

func hide_instructions():
	main_menu.visible = true
	instructions.visible = false
	scenario_1.visible = false
	scenario_2.visible = false
	how_to_play.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if instructions.visible and Input.is_action_just_pressed("jump"):
		inscrution_next()
	if state == INSTRUCTIONS:
		if jumping:
			jumping_sprite.play("jump")
			jumping_sprite.position.y = move_toward(jumping_sprite.position.y, -100, 4)
			if jumping_sprite.position.y <= -100:
				jumping = false
		else:
			jumping_sprite.play("fall")
			jumping_sprite.position.y = move_toward(jumping_sprite.position.y, 0, 2)
			if jumping_sprite.position.y >= 0:
				jumping = true
	pass

func _on_next_pressed():
	inscrution_next()

func inscrution_next(): 
	match state:
		SCENARIO_1:
			scenario_1.visible = false
			scenario_2.visible = true
			state = SCENARIO_2
		SCENARIO_2:
			scenario_2.visible = false
			how_to_play.visible = true
			left_sprite.play("default")
			right_sprite.play("default")
			state = INSTRUCTIONS
		INSTRUCTIONS:
			how_to_play.visible = false
			instructions.visible = false
			main_menu.visible = true


