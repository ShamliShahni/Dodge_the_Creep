extends Area2D

var lifetime = 5

func SelDestruction():
	if visible:
		yield(get_tree().create_timer(lifetime),"timeout")
		queue_free()

func _on_Bull_body_entered(body):
	var group = body.get_groups()
	if group.has("player") && visible:
		print("bullet")
		visible = false
		body.bullets = body.bullet2
		yield(get_tree().create_timer(3),"timeout")
		body.bullets = body.bullet1
		visible = false
