extends RigidBody2D


func _ready():
	sleeping = true
	mode = RigidBody2D.MODE_STATIC
	
	
	
#func _on_Coin_body_entered(body):
#	print(body)
func Visibility():
	visible = false
	

func _on_Area2D_body_entered(body):
	#print(body.name)
	var group = body.get_groups()
	#print(group)
	if group.has("coin"):
		visible = false
	
