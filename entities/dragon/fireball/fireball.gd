extends Area2D

var speed = 750
var direction = Vector2()

func _process(delta):
	$Sprite2D.rotate(speed * delta)
	pass

func _physics_process(delta):
	translate(direction.normalized() * speed * delta)
	pass

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	pass

func _on_body_entered(body):
	if body.name == "Arthur":
		Global.game_over()
	queue_free()
	pass
