extends CharacterBody2D

@export_subgroup("Settings")
@export var platform_early_movement: bool = false

@export_subgroup("Nodes")
@export var next_position:Node2D
@export var floater_component: FloaterComponent
@export var target_selector: TargetSelectorComponent

enum {
	IDLE,
	WAIT,
	MOVE
}

var state = IDLE
var target_position:Vector2
var move_countdown:float = 1

func _ready():
	target_position = global_position

func _on_test_level_platform_premove(time_before_move:float):
	update_next_position(target_selector.getNextTarget(self))
	state = WAIT
	move_countdown = time_before_move
	return

func _on_next_position_body_entered(body):
	move_platform()
	return
	
func _physics_process(delta):
	$NextPosition.global_position = (target_position)
	match state:
		WAIT:
			$Sprite2D.self_modulate = Color(1, 1, 1, move_countdown)
			move_countdown -= delta
			if move_countdown < 0:
				move_platform()
		MOVE:
			floater_component.handle_movement(self, target_position)
			move_and_slide()
			if floater_component.is_at_destination(self, target_position):
				$Sprite2D.self_modulate = Color(1, 1, 1, 1)
				$CollisionShape2D.disabled = false
				state = IDLE
	pass

######################
## NEXT DESINTATION ##
######################

func update_next_position(next:Vector2) -> void:
	target_position = next
	# Activate NextPosition detection
	if not Global.hard_mode:
		$NextPosition/CollisionShape2D.disabled = false
	return

##############
## MOVEMENT ##
##############

func move_platform() -> void:
	# Deactivate NextPosition detection
	$NextPosition/CollisionShape2D.disabled = true
	# Start to move
	target_position = target_position
	state = MOVE
	$CollisionShape2D.disabled = true
	return



