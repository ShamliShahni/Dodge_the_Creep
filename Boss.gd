extends RigidBody2D

var max_health = 100
var health = 100
var damage = 10
var timer = 0.4
var min_speed = 60
var max_speed = 200

func _on_Area2D_body_entered(body):
	var group = body.get_groups()
	
	if group.has("player"):
		#print("player")
		body.player_health()
		
	if group.has("bullet"):
		health -= damage
		
	if health <= 0:
		$CollisionShape2D.disabled = true
		$Sprite.visible = false
		$explosion.visible = true
		$explosion.animation = "explosion"
		$explosion.play()
		yield(get_tree().create_timer(timer),"timeout")
		$explosion.stop()
		$explosion.visible = false
		queue_free()
		
	
	
