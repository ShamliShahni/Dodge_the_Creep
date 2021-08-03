extends Area2D

var lifetime = 10

func SelDestruction():
	if visible:
		yield(get_tree().create_timer(lifetime),"timeout")
		queue_free()
	


func _on_Shealth_body_entered(body):
	var group = body.get_groups()
	if group.has("player") && visible:
		body.shealth = true
		print(body.shealth)
		visible = false
		yield(get_tree().create_timer(5),"timeout")
		body.shealth = false
		print(body.shealth)
	
