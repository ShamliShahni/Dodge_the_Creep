extends KinematicBody2D

var velocity = Vector2(10,3)
var collision

func _physics_process(delta):
	collision = move_and_collide(velocity * delta)
	if collision:
		print("collision")
