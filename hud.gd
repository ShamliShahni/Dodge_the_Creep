extends CanvasLayer
signal start_game


func show_game_over():
	yield(get_tree().create_timer(1), "timeout")


func update_score(score):
	$ScoreLabel.text = str(score)
	
func update_coin(coin):
	$CoinLabel.text = str(coin)

