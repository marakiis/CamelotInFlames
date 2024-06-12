extends CharacterBody2D

@export var arthur: Node2D = null

@export_subgroup("Nodes")
@export var floater_component: FloaterComponent
@export var target_selector: TargetSelectorComponent

# Components
@onready var fire_factory = $Head/FireballFactory

enum {
	IDLE,
	MOVE
}

var state = IDLE
var target_position:Vector2
var move_wait_time:float = 0

func _ready():
	$RoarSound.play()

func _on_test_level_dragon_fireball(speed:float):
	fireball(arthur.global_position, speed)
	pass

func _physics_process(delta):
	match state:
		IDLE:
			move_wait_time -= delta
			if move_wait_time < 0:
				target_position = target_selector.getNextTarget(self)
				state = MOVE
		MOVE:
			floater_component.handle_movement(self, target_position)
			move_and_slide()
			
			if floater_component.is_at_destination(self, target_position):
				state = IDLE
				move_wait_time = randf_range(0.2, 1)
	# If arthur is here look at him. Menacingly!
	# TODO # flip dragon head to be upward
	if arthur != null:
		$Head.look_at(arthur.global_position)
	pass

##############
## FIREBALL ##
##############

@export var fireball_scene: PackedScene = null

func fireball(target:Vector2, speed:float): 
	if fireball_scene != null:
		var fireball = fireball_scene.instantiate()
		owner.add_child(fireball)
		fireball.speed = speed
		# TODO # fireball orientation ???
		fireball.global_position = fire_factory.global_position
		fireball.direction = (target - fire_factory.global_position).normalized()
		$Head/FireballSound.play()
	pass

