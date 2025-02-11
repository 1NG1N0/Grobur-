extends Sprite2D
@onready var Labelinicial = $"../Inicial"
@onready var Labeldepersonagens = $"../personagens"
@export var button_tipe: String = "Direita"
@onready var botaoesquerdo = $"../Sprite2D"
var clicks = 0
@onready var anim = $"../AnimationPlayer"

func _ready():
	anim.play("button idle")

func _input(event):
	if event is InputEventMouse and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		match Button:
			"Direita":
				clicks += 1
				if get_rect().has_point(to_local(event.position)):
					if clicks == 1:
						botaoesquerdo.show()
						Labelinicial.hide()
						Labeldepersonagens.show()
					elif clicks == 2:
						pass
				
