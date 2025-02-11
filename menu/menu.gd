extends Control

func _on_button_pressed():
	get_tree().change_scene_to_file("res://menu/seleção_de_personagem.tscn")
func _on_quit_pressed():
	get_tree().quit()
func _on_controls_pressed():
	get_tree().change_scene_to_file("res://menu/tipodecontrole.tscn")
func _on_whatisthis_pressed():
	get_tree().change_scene_to_file("res://menu/Explicacao.tscn")
func _on_vply_pressed():
	get_tree().change_scene_to_file("res://menu/menu.tscn")
func _on_joystick_pressed():
	get_tree().change_scene_to_file("res://menu/joystick.tscn")
func _on_teclado_pressed():
	get_tree().change_scene_to_file("res://menu/Controles.tscn")
func _on_reddit_pressed():
	OS.shell_open("https://www.reddit.com/user/InabiltyGameDev/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button")
func _on_discord_pressed():
	OS.shell_open("https://discord.gg/3nXe3ktx")
func _on_itch_pressed():
	OS.shell_open("https://nandoing.itch.io/")
