extends Area2D

@export_enum("Cooldown", "HitOnce", "DisableHitBox") var HurtboxType = 0

@onready var collision = $CollisionShape2D
@onready var Disable = $DisableTimer

signal Hurt(damage, angle, knockback)

var hit_once_Arrray = []


func _on_area_entered(area):
	if area.is_in_group("Attack"):
		if not area.get("damage") == null:
			match HurtboxType:
				0:
					collision.call_deferred("set", "disabled", true)
					Disable.start()
				1:
					if hit_once_Arrray.has(area) == false:
						hit_once_Arrray.append(area)
						if area.has_signal("remove_from_array"):
							if not area.is_connected("remove_from_array", Callable(self, "remove_from_list")):
								area.connect("remove_from_array", Callable(self, "remove_from_list"))
					else:
						return
						
				2:
					if area.has_method("tempdisable"):
						area.tempdisable()
				
			var damage = area.damage
			var angle = Vector2.ZERO
			var knockback = 1
			if not area.get("angle") == null:
				angle = area.angle
			if not area.get("knockback_amount") == null:
				knockback = area.knockback_amount
			
			emit_signal("Hurt", damage, angle, knockback)
			if area.has_method("enemy_hit"):
				area.enemy_hit(1)


func remove_from_list(object):
	if hit_once_Arrray.has(object):
		hit_once_Arrray.erase(object)

func _on_disable_timer_timeout():
	collision.call_deferred("set", "disabled", false)
