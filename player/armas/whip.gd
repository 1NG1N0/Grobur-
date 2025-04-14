extends Area2D
@export var damage: int = 10

var knockback_amount = 150
var attack_size = 1.0
var attack_duration = 0.3
var flip_direction = 1 # Alterna entre esquerda (-1) e direita (1)
var angle = Vector2.RIGHT * flip_direction # Define o ângulo para a hurtbox
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var collision = $CollisionShape2D
@onready var timer = $Timer

func _ready():
	#await get_tree().process_frame
	animation_player.play("ataque")
	animation_player.seek(0, true)
	rotation_degrees = 0 
	# Ajusta tamanho do ataque
	scale = Vector2(attack_size, attack_size)
	# Define rotação inicial do chicote (começa inclinado para o lado escolhido)
	position.x += 30 * flip_direction
	if flip_direction == 1:
		sprite_2d.flip_h = true
	else:
		sprite_2d.flip_h = false
	timer.start(attack_duration)
	# Adiciona ao grupo "Attack" para ser reconhecido pela hurtbox
	add_to_group("Attack")
	# Animação de ataque (movimento em arco)
	#tween.tween_property(self, "rotation_degrees", 90 * flip_direction, attack_duration).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	# Inicia o timer para remover o chicote após o ataque
	timer.start(attack_duration)

func enemy_hit(value):
	
	print("Whip atingiu um inimigo!")

func _on_area_entered(body) -> void:
	print("Whip colidiu com:", body.name) # Teste
	if body.is_in_group("Enemies"):
		body.take_damage(damage)
		var knockback_force = Vector2(flip_direction * knockback_amount, 0)

func _on_timer_timeout() -> void:
		queue_free() # Remove o chicote após o tempo de ataque
