extends Node

var current_scene = null

var easy_mode: bool = false
var player_score = 0
var high_score = 0
var high_score_easy_mode = 0

@onready var main_menu_scene = preload("res://UI/main_menu/main_menu.tscn")
@onready var game_scene = preload("res://level/test_level.tscn")
@onready var game_over_scene = preload("res://UI/game_over/game_over.tscn")

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func switch_to_main_menu():
	get_tree().change_scene_to_packed(main_menu_scene)

func switch_to_game():
	get_tree().change_scene_to_packed(game_scene)

func game_over():
	if easy_mode and player_score > high_score_easy_mode:
		high_score_easy_mode = player_score
	if not easy_mode and player_score > high_score:
		high_score = player_score
	get_tree().change_scene_to_packed(game_over_scene)
