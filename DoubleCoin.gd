extends Area2D
var lifetime = 5

func SelDestruction():
	if visible:
		yield(get_tree().create_timer(lifetime),"timeout")
		queue_free()
	

func _on_DoubleCoin_body_entered(body):
	var group = body.get_groups()
	if group.has("player") && visible:
		print("double")
		var double = body.coin * 2
		body.coin = double - 1
		print(body.coin)
		body.update_coin_player()
		visible = false
