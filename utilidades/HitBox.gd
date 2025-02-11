extends Area2D

@export var damage = 1
@onready var distimer = $DisableHitboxtimer
@onready var collision = $CollisionShape2D

func tempdisable():
	collision.call_deferred("set", "disabled", true)
	distimer.start()


func _on_disable_hitboxtimer_timeout():
	collision.call_deferred("set", "disabled", false)
