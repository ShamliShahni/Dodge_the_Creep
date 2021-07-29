extends Node2D

var bar_green = preload("res://dodge_assets/art/barHorizontal_green.png")
var bar_yellow = preload("res://dodge_assets/art/barHorizontal_yellow.png")
var bar_red = preload("res://dodge_assets/art/barHorizontal_red.png")
onready var healthbar = $HealthBar

func _ready():
	if get_parent() and get_parent().get("health_max"):
		healthbar.max_value = get_parent().health_max
		
func _process(delta):
	global_rotation = 0
	
func update_healthbar(value):
	healthbar.texture_progress = bar_green
	if value < healthbar.max_value * 7.0:
		healthbar.texture_progress = bar_yellow
	if value < healthbar.max_value * 3.0:
		healthbar.texture_progress = bar_red
	
	
	healthbar.value = value
