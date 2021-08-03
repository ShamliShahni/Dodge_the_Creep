extends Area2D

var lifetime = 5

func SelDestruction():
	if visible:
		yield(get_tree().create_timer(lifetime),"timeout")
		queue_free()
	

func _on_Area2D_body_entered(body):
	var group = body.get_groups()
	if group.has("player") && visible:
		print("health")
		if body.health < 100:
			body.health = body.health + 20
			print(body.health)
			var healthDisplay = get_parent().get_node("PlayerHealthBar")
			healthDisplay.update_healthbar(body.health)
		visible = false

