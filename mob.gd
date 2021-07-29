extends RigidBody2D

export var min_speed = 50  # Minimum speed range.
export var max_speed = 150  # Maximum speed range.
var max_health = 100
var current_health = 100
var timer = 0.4
var timer2 = 1
var coins = preload("res://Coin.tscn")
var pos 
onready var tween = get_node("Tween")
var enemy_alive = true

func _ready():
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	

func _on_VisibilityNotifier2D_screen_exited():
		queue_free()

func _on_Area2D_body_entered(body):
	var group = body.get_groups()
	
	if group.has("bullet"):
		current_health -= body.get_damage()
		
	if current_health <= 0 && enemy_alive:
		enemy_alive = false
		pos = position
		sleeping = true
		#lin_var.mob.linear_velocity = Vector2(0,0)
		
		$AnimatedSprite.stop()
		tween.start()
		tween.interpolate_property($AnimatedSprite,"modulate:a",1,0,0.2)
		tween.interpolate_property($AnimatedSprite,"modulate:a",0,1,0.2)
		yield(get_tree().create_timer(timer),"timeout")
		$AnimatedSprite.visible = false
		$Sprite.visible = true
		#pos = position
		yield(get_tree().create_timer(timer2),"timeout")
		#queue_free()
		#var coins_instance = coins.instance()
		#coins_instance.position = pos
		#coins_instance.rotation = rotation
		#get_parent().add_child(coins_instance)
	
	if group.has("mob"):
		pos = position
		$CollisionShape2D.disabled = true
