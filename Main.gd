extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (PackedScene) var mob
var score

func _ready():
	randomize()
	
func game_over():
	 $ScoreTimer.stop()
	 $MobTimer.stop()
	 get_tree().call_group("mobs", "queue_free")

func new_game():
	 score = 0
	 $Player.start($StartPosition.position)
	 $StartTimer.start()
	
func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	score += 1
	
func _on_MobTimer_timeout():
	# Choose a random location on Path2D.
	$MobPath/MobSpawnLocation.offset = randi()
	# Create a Mob instance and add it to the scene.
	var Mob = mob.instance()
	add_child(Mob)
	# Set the mob's direction perpendicular to the path direction.
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	# Set the mob's position to a random location.
	#Mob.position = $MobPath/MobSpawnLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	Mob.rotation = direction
	# Set the velocity (speed & direction).
	#Mob.linear_velocity = Vector2(rand_range(Mob.min_speed, Mob.max_speed), 0)
	#Mob.linear_velocity = Mob.linear_velocity.rotated(direction)
	
