extends Control

@onready var anim = $AnimationTree

func go_to_title_screen():
	get_tree().change_scene_to_file("res://menu/menu.tscn")
	
func _ready():
	anim.play("intro")


func _on_animation_tree_animation_finished(intro):
	go_to_title_screen()
