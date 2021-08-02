extends Area2D


var coin = 0

func Visibility():
	visible = false
	


func _on_Coin_body_entered(body):
	var group = body.get_groups()
	if group.has("player"):
		#print("coin player")
		Visibility()
		body.update_coin_player()
		
	if group.has("bullet"):
		#print("bullet")
		body.hide()

