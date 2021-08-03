extends RigidBody2D

var speed = 1500
var lifetime = 3
var damage = 100

func _ready():
	apply_impulse(Vector2() , Vector2(speed,0).rotated(rotation)) 
	Self_Distruction()

func _on_Bullets_body_entered(body):
	hide()
	pass

func get_damage():
	return damage
	
func Self_Distruction():
	yield(get_tree().create_timer(lifetime),"timeout")
	queue_free()
	
