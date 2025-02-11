extends Node2D

@onready var PauseMenu = $"Pause menu"
var paused = false


func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		pausemenu()
	if paused:
		if Input.is_action_just_pressed("Menu"):
			get_tree().change_scene_to_file("res://menu/menu.tscn")
		if Input.is_action_just_pressed("Quit"):
			get_tree().quit()
	

func pausemenu():
	if paused:
		PauseMenu.hide()
		Engine.time_scale = 1
	else:
		if Input.is_action_just_pressed("Menu"):
			get_tree().change_scene_to_file("res://menu/menu.tscn")
		if Input.is_action_just_pressed("Quit"):
			get_tree().quit()
		PauseMenu.show()
		Engine.time_scale = 0
		
	paused = !paused
