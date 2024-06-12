extends CharacterBody2D

@export_subgroup("Nodes")
@export var animation_component: AnimationComponent
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var jump_component: AdvancedJumpComponent

func _physics_process(delta):
	gravity_component.handle_gravity(self, delta)
	movement_component.handle_horizontal_movement(self, input_component.input_horizontal)
	jump_component.handle_jump(self, input_component.get_jump_input(), input_component.get_jump_input_release())
	animation_component.handle_move_animation(input_component.input_horizontal)
	animation_component.handle_jump_animation(jump_component.is_going_up, gravity_component.is_falling)
	
	# UGLY FIX
	if velocity.y < jump_component.jump_velocity:
		velocity.y = jump_component.jump_velocity
	
	move_and_slide()
	
	# Clamp
	global_position = global_position.clamp(Vector2(20, -100), Vector2(1250, 800))
	pass
