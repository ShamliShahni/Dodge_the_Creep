extends Node

export (PackedScene) var mob
var score
var player_alive
var boss = preload("res://Boss.tscn")
var screen_size
var timer = 5

func _ready():
	randomize()
	score = 0
	screen_size = OS.get_window_size()
	$Player.start($StartPostion.position)
	$Player.visible = true
	$StartTimer.start()
	$hud.update_score(score)
	$Player.coin = 0
	player_alive = $Player.is_alive
	#$DoubleCoin.visible = false
	$Timer.start()
	$SpawningTimer.start()

func _process(delta):
	if !player_alive:
		game_over()
	

func game_over():
	 $ScoreTimer.stop()
	 $MobTimer.stop()
	 $SpawningTimer.stop()
	 get_tree().call_group("mobs", "queue_free")

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	score += 1
	$hud.update_score(score)

func _on_MobTimer_timeout():
	# Choose a random location on Path2D.
	$MobPath/MobSpawnLocation.offset = randi()
	# Create a Mob instance and add it to the scene.
	var Mob = mob.instance()
	add_child(Mob)
	# Set the mob's direction perpendicular to the path direction.
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	# Set the mob's position to a random location.
	Mob.position = $MobPath/MobSpawnLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	Mob.rotation = direction
	# Set the velocity (speed & direction).
	var moving_Vector = Vector2(rand_range(Mob.min_speed, Mob.max_speed), 0)
	#var velocity = Mob.position.distance_to($Player.position) * moving_Vector
	Mob.linear_velocity = moving_Vector
	Mob.linear_velocity = Mob.linear_velocity.rotated(direction)
	


func _on_Timer_timeout():
	var bossInstance = boss.instance()
	add_child(bossInstance)
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	# Set the mob's position to a random location.
	bossInstance.position = $MobPath/MobSpawnLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	bossInstance.rotation = direction
	# Set the velocity (speed & direction).
	var moving_Vector = Vector2(rand_range(bossInstance.min_speed, bossInstance.max_speed), 0)
	#var velocity = Mob.position.distance_to($Player.position) * moving_Vector
	bossInstance.linear_velocity = moving_Vector
	bossInstance.linear_velocity = bossInstance.linear_velocity.rotated(direction)
	


func _on_SpawningTimer_timeout():
	var random_num = int(rand_range(0,4))
	var randomposx = rand_range(100,screen_size.x - 100)
	var randomposy = rand_range(100,screen_size.y - 100)
	if random_num == 0:
		$DoubleCoin.position = Vector2(randomposx,randomposy)
		DoubleCoinVisible()
	elif random_num == 1:
		$Health.position = Vector2(randomposx,randomposy)
		HealthVisible()
	elif random_num == 2:
		$Shealth.position = Vector2(randomposx,randomposy)
		ShealthVisible()
	elif random_num == 3:
		$Bull.position = Vector2(randomposx,randomposy)
		BullVisible()

func DoubleCoinVisible():
	$DoubleCoin.visible = true
	yield(get_tree().create_timer(timer),"timeout")
	$DoubleCoin.visible = false

func HealthVisible():
	$Health.visible = true
	yield(get_tree().create_timer(timer),"timeout")
	$Health.visible = false

func ShealthVisible():
	$Shealth.visible = true
	yield(get_tree().create_timer(timer),"timeout")
	$Shealth.visible = false
	
func BullVisible():
	$Bull.visible = true
	yield(get_tree().create_timer(timer),"timeout")
	$Bull.visible = false
