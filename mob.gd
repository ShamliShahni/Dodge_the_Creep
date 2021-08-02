extends RigidBody2D

export var min_speed = 50 
export var max_speed = 150 
var current_health = 100
var timer = 0.4
var coin_timer = 2
var enemy_alive = true

func _ready():
	var mob_types = $MobSprite.frames.get_animation_names()
	$MobSprite.animation = mob_types[randi() % mob_types.size()]
	

func _on_VisibilityNotifier2D_screen_exited():
		queue_free()
	

func _on_Area2D_body_entered(body):
	var group = body.get_groups()
	
	if group.has("player"):
		#print("player")
		body.player_health()
	
	if group.has("bullet"):
		current_health -= body.get_damage()
		sleeping = true
	
	if current_health <= 0 && enemy_alive:
		enemy_alive = false
		sleeping = true
		$MobSprite.stop()
		$MobSprite.visible = false
		$MobSprite.queue_free()
		$Area2D.queue_free()
		$explosion.visible = true
		$explosion.animation = "explosion"
		$explosion.play()
		yield(get_tree().create_timer(timer),"timeout")
		$explosion.stop()
		$explosion.visible = false
		$Coin.visible = true
		$Coin/Sprite.animation = "coin_anim"
		$Coin/Sprite.play()
		sleeping = false
		yield(get_tree().create_timer(coin_timer),"timeout")
		$Coin.queue_free()
