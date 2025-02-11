extends Control
func _on_button_pressed():
	get_tree().change_scene_to_file("res://menu/SelecaodedificuldadedoCharles.tscn")
func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://menu/seleçãocoaglo.tscn")
func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://menu/seleçãomacrofago.tscn")
func _on_button_4_pressed():
	get_tree().change_scene_to_file("res://menu/Seleçãoneedle.tscn")
func _on_button_5_pressed():
	get_tree().change_scene_to_file("res://menu/menu.tscn")
func _on_nivelfacil_pressed():
	get_tree().change_scene_to_file("res://world/Medula ossea/world.tscn")
func _on_nivelmedio_pressed():
	get_tree().change_scene_to_file("res://world/Medula ossea/Nivel_medio.tscn")
func _on_niveldificil_pressed():
	get_tree().change_scene_to_file("res://world/Medula ossea/nivel_dificil_charles.tscn")
func _on_timer_timeout():
	$Label2.hide()
func _on_facilcoaglo_pressed():
	get_tree().change_scene_to_file("res://world/coaglo/world_coaglo.tscn")
func _on_mediocoaglo_pressed():
	get_tree().change_scene_to_file("res://world/coaglo/nivelmediocoaglo.tscn")
func _on_dificilcoaglo_pressed():
	get_tree().change_scene_to_file("res://world/coaglo/realnivel_dificil.tscn")
func _on_timercoaglo_timeout():
	$labeldocoaglo.hide()
func _on_facilneedle_pressed():
	get_tree().change_scene_to_file("res://world/needle/world_needle.tscn")
func _on_medioneedle_pressed():
	get_tree().change_scene_to_file("res://world/needle/nivelmedioagulha.tscn")
func _on_dificilneedle_pressed():
	get_tree().change_scene_to_file("res://world/needle/realnivel_dificil.tscn")
func _on_timerneedle_timeout():
	$labeldocoaglo2.hide()
func _on_facilmacrofago_pressed():
	get_tree().change_scene_to_file("res://world/macrofago/world_Macrófago.tscn")
func _on_mediomacrofago_pressed():
	get_tree().change_scene_to_file("res://world/macrofago/nivelmediomacrofago.tscn")
func _on_dificilmacrofago_pressed():
	get_tree().change_scene_to_file("res://world/macrofago/realnivel_dificil.tscn")
func _on_timermacrofago_timeout():
	$labeldomacrofago.hide()
func _on_voltar_pressed():
	get_tree().change_scene_to_file("res://menu/seleção_de_personagem.tscn")
func _on_voltarneedle_pressed():
	get_tree().change_scene_to_file("res://menu/seleção_de_personagem.tscn")
func _on_voltarcoaglo_pressed():
	get_tree().change_scene_to_file("res://menu/seleção_de_personagem.tscn")
func _on_voltarcharles_pressed():
	get_tree().change_scene_to_file("res://menu/seleção_de_personagem.tscn")
