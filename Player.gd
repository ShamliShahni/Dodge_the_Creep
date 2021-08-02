extends KinematicBody2D

signal hit

export var speed = 300
var screen_size
var stop_dis = 50
var max_speed = 400
var min_speed = 150
var bullet_speed = 100
var fire_rate = 0.1
var can_fire = true
var bullets = preload("res://Bullets.tscn")
var health_max = 100
var player_health = 100
var player_damage = 20
var timer = 0.4
var is_alive = true
onready var tween = get_node("Tween")
var coin = 0

func _ready():
	screen_size = get_viewport_rect().size
	print()
	hide()
	is_alive = true
	coin = 0
	
	
func start(pos):
	position = pos
	show()


func _process(delta):
	look_at_mouse()
	move_player()
	shooting()
	

func shooting():
	if can_fire :
		can_fire = false
		get_node("TurnPoint").rotation = get_angle_to(get_global_mouse_position())
		var bullets_instance = bullets.instance()
		bullets_instance.position =  get_node("TurnPoint/CastPoint").get_global_position()
		bullets_instance.rotation_degrees = rotation_degrees + 90 
		get_parent().add_child(bullets_instance)
		yield(get_tree().create_timer(fire_rate),"timeout")
		can_fire = true
	
func look_at_mouse():
	look_at(get_global_mouse_position())
	rotation_degrees -= 90

func move_player():
	if position.distance_to(get_global_mouse_position()) > stop_dis:
		var direction = get_global_mouse_position() - position
		var direction_nor = direction.normalized()
		var dir_len = direction.length()
		move_and_slide(direction_nor * max(min_speed,min(max_speed,dir_len)))
		$AnimatedSprite.play()
		$AnimatedSprite.animation = "up"
	else:
		$AnimatedSprite.stop()
		 

func _on_Area2D_body_entered(body):
	var group = body.get_groups()
	if group.has("mob"):
		player_health -= player_damage
		var healthDisplay = get_parent().get_node("PlayerHealthBar")
		healthDisplay.update_healthbar(player_health)
		
	if player_health <= 0:
		is_alive = false
		emit_signal("hit")
		$AnimatedSprite.stop()
		tween.start()
		tween.interpolate_property($AnimatedSprite,"modulate:a",1,0,0.2)
		tween.interpolate_property($AnimatedSprite,"modulate:a",0,1,0.2)
		yield(get_tree().create_timer(timer),"timeout")
		queue_free()
	
	
	if group.has("coin"):
		print(body.name)
		var cur_score = get_parent().score
		cur_score += 20
		body.Visibility()
		var coinVal = get_parent().get_node("hud")
		coin += 1
		coinVal.update_coin(coin)
