extends Control
func _on_button_pressed():
	get_tree().change_scene_to_file("res://menu/Personagensexp.tscn")
func _on_botao_pressed():
	get_tree().change_scene_to_file("res://menu/BoneMarrowSpearEXP.tscn")
func _on_passandopra_neddle_pressed():
	get_tree().change_scene_to_file("res://menu/NeddleEXP.tscn")
func _on_passandopra_coaglo_pressed():
	get_tree().change_scene_to_file("res://menu/CoagloEXP.tscn")
func _on_passandopra_macrofago_pressed():
	get_tree().change_scene_to_file("res://menu/MacrofagoEXP.tscn")
func _on_passandopraexplicaçãodeterreno_pressed():
	get_tree().change_scene_to_file("res://menu/explicandooterreno.tscn")
func _on_botaodoterreno_pressed():
	get_tree().change_scene_to_file("res://menu/Resfriadoexp.tscn")
func _on_passarpragripe_pressed():
	get_tree().change_scene_to_file("res://menu/GripeExp.tscn")
func _on_passandoogripe_pressed():
	get_tree().change_scene_to_file("res://menu/h1n1.tscn")
func _on_passandoprapneumonia_pressed():
	get_tree().change_scene_to_file("res://menu/penumoniaEXp.tscn")
func _on_luoldeng_pressed():
	get_tree().change_scene_to_file("res://menu/agradecimentos.tscn")
func _on_forms_pressed():
	OS.shell_open("https://forms.gle/Zn7kGrAk3Rf2Kswm9")
func _on_menuagradecimentos_pressed():
	get_tree().change_scene_to_file("res://menu/menu.tscn")
