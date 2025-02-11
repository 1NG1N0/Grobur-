extends Area2D


var sensitivity = 3.0

var level = 1
var hp = 9999
var speed = 100.0
var damage = 7
var attack_size = 1.0
var knockback_amount = 100


var last_movement = Vector2.ZERO
var angle = Vector2.ZERO
var angle_less = Vector2.ZERO
var angle_more = Vector2.ZERO

signal remove_from_array(object)

@onready var player = get_tree().get_first_node_in_group("Player")

func _ready():
	match level:
		1:
			hp = 9999
			speed = 100.0
			damage = 8
			attack_size = 1.0 * (1 + player.spell_size)
			knockback_amount = 105
		2:
			hp = 9999
			speed = 100.0
			damage = 8
			attack_size = 1.0 * (1 + player.spell_size)
			knockback_amount = 105
		3:
			hp = 9999
			speed = 100.0
			damage = 8
			attack_size = 1.0 * (1 + player.spell_size)
			knockback_amount = 105
		4:
			hp = 9999
			speed = 100.0
			damage = 8
			attack_size = 1.0 * (1 + player.spell_size)
			knockback_amount = 145
			
			
	var move_to_less = Vector2.ZERO
	var move_to_more = Vector2.ZERO
	
	match last_movement:
		Vector2.UP, Vector2.DOWN:
			move_to_less = global_position * Vector2(randf_range(-1,-0.25), last_movement.y)*500
			move_to_more = global_position * Vector2(randf_range(0.25, 1), last_movement.x)*500
		Vector2.RIGHT, Vector2.LEFT:
			move_to_less = global_position * Vector2(last_movement.x, randf_range(-1,-0.25))*500
			move_to_more = global_position * Vector2(last_movement.x, randf_range(0.25, 1))*500
		Vector2(1,1), Vector2(-1,-1), Vector2(1,-1), Vector2(-1,1):
			move_to_less = global_position * Vector2(last_movement.x, last_movement.y * randf_range(0,0.75))*500
			move_to_more = global_position * Vector2(last_movement.x * randf_range(0,0.75), last_movement.y)*500
			
	angle_less = global_position.direction_to(move_to_less)
	angle_more = global_position.direction_to(move_to_more)
	
	var initial_tween = create_tween().set_parallel(true)
	initial_tween.tween_property(self, "scale", Vector2(1,1)*attack_size, 3).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	var final_speed = speed
	speed = speed/5.0
	initial_tween.tween_property(self, "speed", final_speed, 6).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	initial_tween.play()
	
	var tween = create_tween()
	var set_angle = randi_range(0,1)
	if set_angle == 1:
		angle = angle_less
		tween.tween_property(self, "angle", angle_more, 2)
		tween.tween_property(self, "angle", angle_less, 2)
		tween.tween_property(self, "angle", angle_more, 2)
		tween.tween_property(self, "angle", angle_less, 2)
		tween.tween_property(self, "angle", angle_more, 2)
		tween.tween_property(self, "angle", angle_less, 2)
	else:
		angle = angle_more
		tween.tween_property(self, "angle", angle_less, 2)
		tween.tween_property(self, "angle", angle_more, 2)
		tween.tween_property(self, "angle", angle_less, 2)
		tween.tween_property(self, "angle", angle_more, 2)
		tween.tween_property(self, "angle", angle_less, 2)
		tween.tween_property(self, "angle", angle_more, 2)
		
	tween.play()
	
	
func _physics_process(delta):
	position += angle*speed*delta



func enemy_hit(_charge):
	pass

func _on_timer_timeout():
	emit_signal("remove_from_array", self)
	queue_free()


func _process(delta):
	# Captura o movimento do analógico esquerdo
	var left_stick_input_x = Input.get_action_strength("analo_esqdir") - Input.get_action_strength("analo_esqesq")
	var left_stick_input_y = Input.get_action_strength("analogico_esqcima") - Input.get_action_strength("analogi_esqbaixo")
	left_stick_input_y *= -1
	# Pega a posição atual do mouse
	var mouse_pos = get_viewport().get_mouse_position()
	
	# Calcula a nova posição do mouse
	var new_mouse_pos = mouse_pos + Vector2(left_stick_input_x, left_stick_input_y) * (sensitivity-2)
	
	# Atualiza a posição do mouse
	get_viewport().warp_mouse(new_mouse_pos)
