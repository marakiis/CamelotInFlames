extends Node2D

@export_subgroup("Platform")
@export var platform_premove_cooldown: float = 3
@export var platform_move_cooldown: float = 3

@export_subgroup("Dragon")
@export var dragon_fireball_cooldown: float = 2
@export var dragon_fireball_speed:float = 300

# Components
@onready var score_label = $CanvasLayer/Score

# Platform signals
signal platform_premove(time_before_move)

# Dragon signals
signal dragon_fireball(fireball_speed)
signal dragon_fire

# TODO # Add DragonFire

var score:float = 0
var platform_premove_wait_time:float = platform_premove_cooldown
var dragon_fireball_wait_time:float = dragon_fireball_cooldown

func _on_intro_finished():
	$Music.play()

func _on_music_finished():
	$Music.play()

func _ready():
	Global.player_score = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Global.player_score += delta
	score_label.text = "Score: %d" % int(Global.player_score)
	
	platform_premove_wait_time -= delta
	if platform_premove_wait_time < 0:
		platform_premove.emit(platform_move_cooldown)
		platform_premove_wait_time = platform_premove_cooldown + platform_move_cooldown + randf_range(0, 1)
		
	dragon_fireball_wait_time -= delta
	if dragon_fireball_wait_time < 0: 
		dragon_fireball.emit(dragon_fireball_speed)
		dragon_fireball_wait_time = dragon_fireball_cooldown + randf_range(0, 1)
	pass

func _on_area_2d_body_entered(body):
	game_over()
	return
	
func game_over():
	Global.game_over()
	



