extends Node2D

export(String, FILE, "*.tscn") var path_to_scene


func _on_RestartButton_pressed():
	get_tree().change_scene(path_to_scene)
	
	
