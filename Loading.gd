extends Node2D

var nextScene = preload("res://Main.tscn")




func _on_StartButton_pressed():
	get_tree().change_scene_to(nextScene)
