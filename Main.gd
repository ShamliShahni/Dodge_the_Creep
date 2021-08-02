extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (PackedScene) var mob
var score
var player_alive


func _ready():
	randomize()
	score = 0
	$Player.start($StartPostion.position)
	$Player.visible = true
	$StartTimer.start()
	$hud.update_score(score)
	$Player.coin = 0
	player_alive = $Player.is_alive

func _process(delta):
	if !player_alive:
		game_over()

func game_over():
	 $ScoreTimer.stop()
	 $MobTimer.stop()
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
	Mob.linear_velocity = Vector2(rand_range(Mob.min_speed/2, Mob.max_speed/2), 0)
	Mob.linear_velocity = Mob.linear_velocity.rotated(direction)
	
