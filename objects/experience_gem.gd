extends Area2D


var timer = 0
@export var experience = 1
var spr_green = preload("res://objects/Gem_green.png")
var spr_blue = preload("res://objects/Gem_blue.png")
var spr_red = preload("res://objects/Gem_red.png")

var target = null
var speed = 0
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var sound = $snd_collected


func _ready():
	if experience < 5:
		return
	elif experience < 25:
		sprite.texture = spr_blue
	else:
		sprite.texture = spr_red


func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 2*delta
		
func collect():
	sound.play()
	collision.call_deferred("set", "disabled", true)
	sprite.visible = false
	if timer > 35:
		queue_free()
	return experience

func _on_snd_collected_finished():
	queue_free()
	
func _on_timer_timeout():
	timer += 1
