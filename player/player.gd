extends CharacterBody2D

var current_selection = 0
var options = []
var optionsMax = 0
var cursor_texture: Texture2D = preload("res://utilidades/pixil-frame-0 (45)(1).png")
@onready var pause = $GUILayer/GUI/PauseMenu
@export var player_dificulty: String = "Facil"
@onready var timerdedano = $Timerdedano
var spritenormal = preload("res://player/player_darwin.png")
var spritedocoaglo = preload("res://textures/spritesdeboneco/pixil-frame-0 (19).png")
var spritedano = preload("res://textures/spritesdeboneco/spritecientista.png")
var anim_death = preload("res://gripe/gui/explosion.tscn")
@onready var deathanim = $AnimationPlayer
@onready var PauseMenu = $"Camera2D/Pause menu"
var paused = false
var hp = 100
var maxhp = 99
var movement_speed = 50.0
var last_movement = Vector2.UP
var experience = 0
var experience_level = 1
var collected_experience = 0
var enemies_defeated = 0
var total_experience_earned = 0
var time = 0 
@onready var Sprite = $Sprite2D
@onready var WalkTimer = get_node("%WalkTimer")
@onready var expBar = get_node("%ExperienceBar")
@onready var lblLevel = get_node("%Lbl_level")
@onready var LevelPanel = get_node("%LevelUp")
@onready var upgradeOptions = get_node("%UpgradeOptions")
@onready var snd_levelUp = get_node("%snd_levelup")
@onready var itemOptions = preload("res://objects/GUI/item_option.tscn")
@onready var healthBar = get_node("%HealthBar")
@onready var lblTimer = get_node("%lblTimer")
@onready var collectedWeapons = get_node("%CollectedWeapons")
@onready var collectedUpgrades = get_node("%CollectedUpgrades")
@onready var itemConteiner = preload("res://utilidades/item_conteiner.tscn")
@onready var deathPanel = get_node("%DeathPanel")
@onready var snd_Victory = get_node("%snd_victory")
@onready var snd_Lose = get_node("%snd_lose")
@onready var lbl_Result = get_node("%lbl_Result")
@export var player_tipe: String = "gelo"

#attack
var BoneMarrowSpear = preload("res://player/armas/bone_marrow_spear.tscn")
var Blood_Cloot = preload("res://player/armas/blood_clot.tscn")
var javelin = preload("res://player/armas/javelin.tscn")
@onready var javelinBase = get_node("%JavelinBase")
var needle = preload("res://player/armas/neddle.tscn")
# Chicote
var whip = preload("res://player/armas/whip.tscn")
@onready var WhipTimer = get_node("%WhipTimer")  # Timer para o chicote

#attacksnodes
@onready var BoneMarrowSpearTimer = get_node("%BoneMarrowSpearTimer")
@onready var BoneMarrowSpearAttackTimer = get_node("%BoneMarrowSpearAttackTimer")
@onready var BloodClotTimer = get_node("%Blood_Clot_Timer")
@onready var BloodClotTimerattack = get_node("%Blood_Clot_attack_timer")
@onready var NeddleTimer = get_node("%NeddleTimer")
@onready var NeddleTimerAtaack = get_node("%NeddleTimerAttack")

signal playerdeath


#UPGRADES
var collected_upgrades = []
var upgrades_options = []
var armor = 0
var speed = 0
var spell_cooldown = 0
var spell_size = 0
var additional_attacks = 0

#BoneMarrowSpear
var BoneMarrowSpear_ammo = 0
var BoneMarrowSpear_baseammo = 0
var BoneMarrowSpear_attackspeed = 1.5
var BoneMarrowSpear_level = 0

#Neddle
var Neddle_ammo = 0
var Neddle_baseammo = 0
var Neddle_attackspeed = 0.5
var Neddle_level = 0


#BloodClot
var BloodClot_ammo = 0
var BloodClot_baseammo = 0
var BloodClot_attackspeed = 3
var BloodClot_level = 0


#javelin
var javelin_ammo = 0
var javelin_level = 0

#whip
var whip_level = 0
var whip_attackspeed = 1.2  # Tempo entre ataques
var whip_damage = 10
var flip_direction = 1



#enemy related
var enemy_close = []
@onready var joystick = $"../CanvasLayer/Joystick"

func _ready():
	Input.set_custom_mouse_cursor(cursor_texture)
	match player_tipe:
		"gelo":
			upgrade_character("whip1")
			spritenormal = preload("res://player/player_darwin.png")
		"agulha":
			upgrade_character("neddle1")
			spritenormal = preload("res://player/player_carson.png")
		"Coaglo":
			upgrade_character("tornado1")
			spritenormal = preload("res://player/player_hooke.png")
		"Macrófago":
			upgrade_character("javelin1")
			spritenormal = preload("res://player/player_pasteur.png")
	attack()
	set_expBar(experience, calculate_experiencecap())
	_on_hurtbox_hurt(0,0,0)
	

func attack():
	if Neddle_level > 0:
		NeddleTimer.wait_time = Neddle_attackspeed * (1-spell_cooldown)
		if NeddleTimer.is_stopped():
			NeddleTimer.start()
	if BoneMarrowSpear_level > 0:
		BoneMarrowSpearTimer.wait_time = BoneMarrowSpear_attackspeed * (1 - spell_cooldown)
		if BoneMarrowSpearTimer.is_stopped():
			BoneMarrowSpearTimer.start()
	if BloodClot_level > 0:
		BloodClotTimer.wait_time = BloodClot_attackspeed * (1 - spell_cooldown)
		if BloodClotTimer.is_stopped():
			BloodClotTimer.start()
	if javelin_level > 0:
		spawn_javelin()
	if whip_level > 0:
		WhipTimer.wait_time = whip_attackspeed * (1 - spell_cooldown)
		if WhipTimer.is_stopped():
			WhipTimer.start()

		
	

func _physics_process(_delta):
	movement()
	if Input.is_action_just_pressed("Pause"):
		pausemenu()
	if paused:
		if Input.is_action_just_pressed("Quit"):
			get_tree().quit()
	
	

func movement():
	if not LevelPanel.visible:
		var x_mov = Input.get_action_strength("rigth") - Input.get_action_strength("left")
		var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up")
		var direction = Vector2(x_mov, y_mov)
		
		# Se houver input do joystick, ele sobrescreve o teclado (ou pode ser somado, mas geralmente sobrescreve)
		if joystick and joystick.posVector != Vector2.ZERO:
			direction = joystick.posVector.normalized()
		
		if direction.length() > 1:
			direction = direction.normalized()
		
		velocity = direction * movement_speed
		
		if direction == Vector2.ZERO:
			velocity = Vector2.ZERO
			
		move_and_slide()
		
		if direction != Vector2.ZERO:
			last_movement = direction
			if direction.x > 0:
				Sprite.flip_h = true
			elif direction.x < 0:
				Sprite.flip_h = false
				
			if WalkTimer.is_stopped():
				if Sprite.frame >= Sprite.hframes - 1:
					Sprite.frame = 0
				else: 
					Sprite.frame = 1
				WalkTimer.start()


func _on_hurtbox_hurt(damage, _angle, _knockback):
	hp -= clamp(damage - armor, 1.0, 999.0)
	Sprite.texture = spritedano
	timerdedano.start()
	print(hp)
	healthBar.max_value = maxhp
	healthBar.value = hp
	if hp < 0:
		deathanim.play("_death")
		movement_speed = 0


func _on_bone_marrow_spear_timer_timeout():
	BoneMarrowSpear_ammo += BoneMarrowSpear_baseammo + additional_attacks
	BoneMarrowSpearAttackTimer.start()


func _on_bone_marrow_spear_attack_timer_timeout():
	if BoneMarrowSpear_ammo > 0:
		var BoneMarrowSpear_attack = BoneMarrowSpear.instantiate()
		BoneMarrowSpear_attack.angle = global_position.direction_to(get_nearest_target())
		BoneMarrowSpear_attack.level = BoneMarrowSpear_level
		add_child(BoneMarrowSpear_attack)
		BoneMarrowSpear_attack.global_position = global_position
		BoneMarrowSpear_ammo -= 1
		if BoneMarrowSpear_ammo > 0:
			BoneMarrowSpearAttackTimer.start()
		else:
			BoneMarrowSpearAttackTimer.stop()
		
func get_nearest_target():
	var nearest = null
	var nearest_dist = INF
	for enemy in get_tree().get_nodes_in_group("enemies"):
		var d = global_position.distance_squared_to(enemy.global_position)
		if d < nearest_dist:
			nearest_dist = d
			nearest = enemy
	if nearest != null:
		return nearest.global_position
	return global_position + Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized()

func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else:
		return Vector2.UP


func _on_enemy_detection_area_body_entered(body):
	if not enemy_close.has(body):
		enemy_close.append(body)


func _on_enemy_detection_area_body_exited(body):
	enemy_close.erase(body)


func _on_blood_clot_timer_timeout():
	BloodClot_ammo += BloodClot_baseammo + additional_attacks
	BloodClotTimerattack.start()


func _on_blood_clot_attack_timer_timeout():
	if BloodClot_ammo > 0:
		var BloodClot_attack = Blood_Cloot.instantiate()
		BloodClot_attack.position = position
		BloodClot_attack.last_movement = last_movement
		BloodClot_attack.level = BloodClot_level
		add_child(BloodClot_attack)
		BloodClot_ammo -= 1
		if BloodClot_ammo > 0:
			BloodClotTimerattack.start()
		else:
			BloodClotTimerattack.stop()


func spawn_javelin():
	var get_javelin_total = javelinBase.get_child_count()
	var calc_spawns = (javelin_ammo + additional_attacks) - get_javelin_total
	while calc_spawns > 0:
		var javelin_spawn = javelin.instantiate()
		javelin_spawn.global_position = global_position
		javelinBase.add_child(javelin_spawn)
		calc_spawns -= 1
	var get_javelins = javelinBase.get_children()
	for i in get_javelins:
		if i.has_method("update_javelin"):
			i.update_javelin()


func _on_grab_area_area_entered(area):
	if area.is_in_group("loot"):
		area.target = self


func _on_collect_area_area_entered(area):
	if area.is_in_group("loot"):
		var gem_exp = area.collect()
		calculate_experience(gem_exp)


func calculate_experience(gem_exp):
	var exp_required = calculate_experiencecap()
	collected_experience += gem_exp
	total_experience_earned += gem_exp
	if experience + collected_experience >= exp_required:
		collected_experience -= exp_required-experience
		experience_level += 1
		if hp < 90:
			hp += 4
			healthBar.value = hp
		else:
			hp += 0
		levelup()
		experience = 0
		exp_required = calculate_experiencecap()
	else:
		experience += collected_experience
		collected_experience = 0 
		
	set_expBar(experience, exp_required)
	
	
func calculate_experiencecap():
	var exp_cap = experience_level
	if experience_level < 20:
		exp_cap = experience_level*5
	elif experience_level < 40:
		exp_cap = 255 + (experience_level-19)*30
	else:
		exp_cap = 255 + (experience_level-39)*50
		
	return exp_cap



func set_expBar(set_value = 1, set_max_value = 100):
	expBar.value = set_value
	expBar.max_value = set_max_value
	
	
func levelup():
	lblLevel.text = str("Level: ", experience_level)
	snd_levelUp.play()
	var tween = LevelPanel.create_tween()
	tween.tween_property(LevelPanel, "position", Vector2(220, 50), 0.2).set_trans(Tween.TRANS_QUINT).set_ease(tween.EASE_IN)
	tween.play()
	LevelPanel.visible = true
	options.clear()
	var optionsMax = 3
	for i in range(optionsMax):
		var option_choice = itemOptions.instantiate()
		option_choice.item = get_random_item()
		upgradeOptions.add_child(option_choice)
		options.append(option_choice)
		print("Option Added: ", option_choice.item)  # Debug
	get_tree().paused = true
	update_selection()
	
	
func update_selection():
	print("Updating Selection: ", current_selection)
	for i in range(options.size()):
		options[i].set_selected(i == current_selection)
		print("Setting selected for option: ", options[i].item, " to ", (i == current_selection))

func _input(event):
	if LevelPanel.visible:
		if event.is_action_pressed("up"):
			current_selection = (current_selection - 1 + options.size()) % options.size()
			update_selection()
		elif event.is_action_pressed("down"):
			current_selection = (current_selection + 1) % options.size()
			update_selection()
		elif event.is_action_pressed("ui_accept"):
			if options.size() > 0:
				emit_signal("selected_upgrade", options[current_selection].item)
	elif not get_tree().is_paused():  # Allow movement input only when the game is not paused
		pass



func upgrade_character(upgrade):
	match upgrade:
		"neddle1":
			Neddle_level = 1
			Neddle_baseammo += 1
		"neddle2":
			Neddle_level = 2
			Neddle_baseammo += 1
		"neddle3":
			Neddle_level = 3
			Neddle_attackspeed -= 0.1
		"neddle4":
			Neddle_level = 4
			Neddle_baseammo += 2
			Neddle_attackspeed -= 0.1
		"icespear1":
			BoneMarrowSpear_level = 1
			BoneMarrowSpear_baseammo += 1
		"icespear2":
			BoneMarrowSpear_level = 2
			BoneMarrowSpear_baseammo += 1
		"icespear3":
			BoneMarrowSpear_level = 3
		"icespear4":
			BoneMarrowSpear_level = 4
			BoneMarrowSpear_baseammo += 2
		"tornado1":
			BloodClot_level = 1
			BloodClot_baseammo += 1
		"tornado2":
			BloodClot_level = 2
			BloodClot_baseammo += 1
		"tornado3":
			BloodClot_level = 3
			BloodClot_attackspeed -= 0.5
		"tornado4":
			BloodClot_level = 4
			BloodClot_baseammo += 1
		"javelin1":
			javelin_level = 1
			javelin_ammo = 1
		"javelin2":
			javelin_level = 2
		"javelin3":
			javelin_level = 3
		"javelin4":
			javelin_level = 4
		"whip1":
			whip_level = 1
			whip_damage += 10
		"whip2":
			whip_level = 2
			whip_damage += 5
			whip_attackspeed -= 0.1
		"whip3":
			whip_level = 3
			whip_damage += 10
		"whip4":
			whip_level = 4
			whip_damage += 15
			whip_attackspeed -= 0.1
		"armor1","armor2","armor3","armor4":
			armor += 2
		"speed1","speed2","speed3","speed4":
			movement_speed += 10.0
		"tome1","tome2","tome3","tome4":
			spell_size += 0.10
		"scroll1","scroll2","scroll3","scroll4":
			spell_cooldown += 0.05
		"ring1","ring2":
			if BoneMarrowSpear_baseammo != 0:
				BoneMarrowSpear_baseammo += 1
			if BloodClot_baseammo != 0:
				BloodClot_baseammo += 1
			if javelin_ammo != 0:
				javelin_ammo += 1
		"food":
			hp += 25
			hp = clamp(hp,0,maxhp)
			healthBar.value = hp
			
	adjust_gui_collection(upgrade)
	attack()
	
	var options_children = upgradeOptions.get_children()
	for i in options_children:
		i.queue_free()
	upgrades_options.clear()
	collected_upgrades.append(upgrade)
	LevelPanel.visible = false
	LevelPanel.position = Vector2(800, 50)
	get_tree().paused = false
	calculate_experience(0)
	
func get_random_item():
	var dblist = []
	for i in UpgradeDb.UPGRADES:
		if i in collected_upgrades:
			pass
		elif i in upgrades_options:
			pass
		elif UpgradeDb.UPGRADES[i]["type"] == "item":
			pass
		elif UpgradeDb.UPGRADES[i]["prerequisite"].size() > 0:
			var to_add = true
			for n in UpgradeDb.UPGRADES[i]["prerequisite"]:
				if not n in collected_upgrades:
					to_add = false
			if to_add:
					dblist.append(i)
		else:
			dblist.append(i)
	if dblist.size() > 0:
		var randomitem = dblist.pick_random()
		upgrades_options.append(randomitem)
		return randomitem
	else:
		return null
	print(options)
		
		
		
func change_timer(argtime = 0):
	time = argtime
	var get_m = int(time/60.0)
	var get_s = time % 60
	if get_m < 10:
		get_m = str(0, get_m)
	if get_s < 10:
		get_s = str(0, get_s)
	lblTimer.text = str(get_m,":",get_s)
	
	
	
	
func adjust_gui_collection(upgrade):
	var get_upgraded_displayname = UpgradeDb.UPGRADES[upgrade]["displayname"]
	var get_type = UpgradeDb.UPGRADES[upgrade]["type"]
	if get_type != "item":
		var get_collected_displaynames = []
		for i in collected_upgrades:
			get_collected_displaynames.append(UpgradeDb.UPGRADES[i]["displayname"])
		if not get_upgraded_displayname in get_collected_displaynames:
			var new_item = itemConteiner.instantiate()
			new_item.upgrade = upgrade
			match get_type:
				"weapon":
					collectedWeapons.add_child(new_item)
				"upgrade":
					collectedUpgrades.add_child(new_item)
		


func death():
	deathPanel.visible = true
	emit_signal("playerdeath")
	get_tree().paused = true
	var tween = deathPanel.create_tween()
	tween.tween_property(deathPanel, "position", Vector2(220,50), 3.0).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	
	var result_text = ""
	match player_dificulty:
		"Facil":
			if time >= 600:
				result_text = "YOU WIN!!!!!!!!"
				snd_Victory.play()
			else:
				result_text = "you lose"
				snd_Lose.play()
		"Mid":
			if time >= 1200:
				result_text = "YOU WIN!!!!!!!!"
				snd_Victory.play()
			else:
				result_text = "you lose"
				snd_Lose.play()
		"Extreme":
			if time >= 1800:
				result_text = "YOU WIN!!!!!!!!"
				snd_Victory.play()
			else:
				result_text = "you lose"
				snd_Lose.play()
	
	lbl_Result.text = str(result_text, "\nKills: ", enemies_defeated, "\nXP: ", total_experience_earned)
func _on_button_click_end():
	get_tree().paused = false
	var _level = get_tree().change_scene_to_file("res://menu.tscn")


func _on_neddle_timer_timeout():
	Neddle_ammo += Neddle_baseammo + additional_attacks
	NeddleTimerAtaack.start()


func _on_neddle_timer_attack_timeout():
	if Neddle_ammo > 0:
		var Neddle_attack = needle.instantiate()
		Neddle_attack.position = position
		Neddle_attack.angle = global_position.direction_to(get_nearest_target())
		Neddle_attack.level = Neddle_level
		add_child(Neddle_attack)
		Neddle_ammo -= 1
		if Neddle_ammo > 0:
			NeddleTimerAtaack.start()
		else:
			NeddleTimerAtaack.stop()
		

func pausemenu():
	if paused:
		pause.hide()
		Engine.time_scale = 1
	else:
		pause.show()
		Engine.time_scale = 0
		
	paused = !paused

func _on_animation_player_animation_finished(_death):
	anim_death.instantiate()
	#movement_speed = 40.0
	death()
func _on_timerdedano_timeout():
	Sprite.texture = spritenormal
func _on_button_pressed():
	paused = false
	Engine.time_scale = 1
	pause.hide()
func _on_button_2_pressed():
	get_tree().quit()


func attack_whip():
	var whip = preload("res://player/armas/whip.tscn").instantiate()
	var direction = 1 if Sprite.flip_h else -1 
	whip.flip_direction = direction
	whip.global_position = global_position + Vector2(whip.flip_direction * 5, 0)
	get_parent().add_child(whip)


func _on_whip_timer_timeout() -> void:
	if whip_level > 0:
		attack_whip()
