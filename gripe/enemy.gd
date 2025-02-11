extends CharacterBody2D

var timergeral = 0
@export var movement_speed = 30.0
var time = 0
@export var hp = 10
@export var knockback_recovery = 3.5
@export var experience = 1
@export var enemy_damage = 1
var knockback = Vector2.ZERO
@onready var Sprite = $Sprite2D
@onready var animation = $AnimationPlayer
@onready var snd_hit = $Enemy_hit
@onready var loot_base = get_tree().get_first_node_in_group("loot")
@onready var hitBox = $HitBox


var anim_death = preload("res://gripe/gui/explosion.tscn")
var exp_gem = preload("res://objects/experience_gem.tscn")

@onready var player = get_tree().get_first_node_in_group("Player")

signal remove_from_array(object)


func _ready():
	animation.play("walk")
	hitBox.damage = enemy_damage

func _physics_process(_delta):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	var direction = global_position.direction_to(player.global_position)
	velocity = direction*movement_speed
	velocity += knockback
	move_and_slide()
	
	if direction.x > 0.1:
		Sprite.flip_h = true
	elif direction.x < -0.1:
		Sprite.flip_h = false

func death():
	emit_signal("remove_from_array", self)
	var enemy_death = anim_death.instantiate()
	enemy_death.scale = Sprite.scale
	enemy_death.global_position = global_position
	get_parent().call_deferred("add_child", enemy_death)
	var new_gem = exp_gem.instantiate()
	new_gem.global_position = global_position
	new_gem.experience = experience
	loot_base.call_deferred("add_child", new_gem)
	queue_free()


func _on_hurtbox_hurt(damage, angle, knockback_amount):
	hp -= damage
	if time > 30:
		death()
	knockback = angle*knockback_amount
	if hp <= 0:
		death()
	else:
		snd_hit.play()


func _on_timer_timeout():
	time += 1


func _on_timergeral_timeout():
	timergeral += 1
