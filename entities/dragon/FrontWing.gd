extends Node2D

@export var flap_speed: float = 0.4

enum {
	UP,
	DOWN
}

var state = UP
var flap_skew_min: float = -60
var flap_skew_max: float = 0
var skew_flapped: float = -40
var flapped = false


func _process(delta):
	var skew_deg = rad_to_deg(skew)
	match state:
		UP:
			skew += flap_speed * delta
			if skew_deg > flap_skew_max:
				state = DOWN
		DOWN:
			skew -= flap_speed * delta
			if not flapped and skew_deg < skew_flapped:
				$FlapSound.play()
				flapped = true
			if skew_deg < flap_skew_min:
				state = UP
				flapped = false
	pass
