extends RigidBody2D

export var min_speed = 5  # Minimum speed range.
export var max_speed = 10  # Maximum speed range.
var max_health = 100
var current_health = 100
var timer = 0.4
var timer2 = 1
var coins = preload("res://Coin.tscn")
var pos 
onready var tween = get_node("Tween")
var enemy_alive = true
var col_state = 0
var is_coin = false

func _ready():
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	

func _on_VisibilityNotifier2D_screen_exited():
		queue_free()
	

func _on_Area2D_body_entered(body):
	var group = body.get_groups()
	
	if group.has("bullet"):
		current_health -= body.get_damage()
		#mode = RigidBody2D.MODE_STATIC
		sleeping = true
		
		
	if current_health <= 0:
		#print("enemy")
		pass
	
	if current_health <= 0 && enemy_alive:
		col_state = col_state + 1
		enemy_alive = false
		gravity_scale = 0
		#pos = position
		sleeping = true
		mode = RigidBody2D.MODE_STATIC
		#lin_var.mob.linear_velocity = Vector2(0,0)
		$AnimatedSprite.stop()
		$AnimatedSprite.visible = false
		$AnimatedSprite.queue_free()
		$Area2D.queue_free()
		$CollisionShape2D.queue_free()
		$AnimatedSprite2.visible = true
		$AnimatedSprite2.animation = "explosion"
		$AnimatedSprite2.play()
		yield(get_tree().create_timer(timer),"timeout")
		$AnimatedSprite2.stop()
		$AnimatedSprite2.visible = false
		$Coin.visible = true
		$Coin.sleeping = false
		is_coin = true
		sleeping = false
		
		#pos = position
		yield(get_tree().create_timer(timer2),"timeout")
		
