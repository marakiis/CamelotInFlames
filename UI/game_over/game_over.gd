extends Control

@onready var score_label = $MarginContainer/HBoxContainer/VBoxContainer2/Scores/Score
@onready var high_score_label = $MarginContainer/HBoxContainer/VBoxContainer2/Scores/HighScore
@onready var high_score_easy_mode_label = $MarginContainer/HBoxContainer/VBoxContainer2/Scores/HighScoreEasyMode
@onready var retry_button = $MarginContainer/HBoxContainer/VBoxContainer2/VBoxContainer/Retry
@onready var main_menu_button = $MarginContainer/HBoxContainer/VBoxContainer2/VBoxContainer/ReturnToMainMenu

func _on_music_finished():
	$Music.play()

func _ready():
	retry_button.button_down.connect(on_retry_pressed)
	main_menu_button.button_down.connect(on_main_menu_pressed)
	
	score_label.text = "Your Score: %d" % int(Global.player_score)
	high_score_label.text = "High Score: %d" % int(Global.high_score)
	high_score_easy_mode_label.text = "High Score (Hard Mode): %d" % int(Global.high_score_hard_mode)

func on_retry_pressed():
	Global.switch_to_game()
	return

func on_main_menu_pressed():
	Global.switch_to_main_menu()
	return

