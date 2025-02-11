extends Area2D

var sensitivity = 3.0
var level = 1
var hp = 10
var speed = 800
var damage = 2
var knockback_amount = 100
var attack_size = 1.0

var target = Vector2.ZERO
var angle = Vector2.ZERO

signal remove_from_array(object)


@onready var player = get_tree().get_first_node_in_group("Player")

func _ready():
	angle = global_position.direction_to(target)
	rotation = angle.angle() + deg_to_rad(135)
	match level:
		1:
			hp = 1
			damage = 1
			speed = 800
			knockback_amount = 150
			attack_size = 1.0 * (1 + player.spell_size)
		2:
			hp = 1
			damage = 1
			speed = 1000
			knockback_amount = 150
			attack_size = 1.0 * (1 + player.spell_size)
		3:
			hp = 1
			damage = 3
			speed = 1000
			knockback_amount = 150
			attack_size = 1.0 * (1 + player.spell_size)
		4:
			hp = 1
			damage = 3
			speed = 1500
			knockback_amount = 150
			attack_size = 1.0 * (1 + player.spell_size)
			
			
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1,1)*attack_size, 1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
			
func _physics_process(delta):
	position += angle*speed*delta
	
func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		emit_signal("remove_from_array", self)
		queue_free()

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
