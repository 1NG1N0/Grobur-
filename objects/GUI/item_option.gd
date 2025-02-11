extends ColorRect
var sensitivity = 3.0

@onready var lblName = $lbl_name
@onready var lblDescription = $lbl_description
@onready var lblLevel = $lbl_level
@onready var itemIcon = $ColorRect/ItemIcon

var mouse_over = false
var item = null
@onready var player = get_tree().get_first_node_in_group("Player")

signal selected_upgrade(upgrade)

func _ready():
	connect("selected_upgrade", Callable(player, "upgrade_character"))
	if item == null:
		item = "food"
	lblName.text = UpgradeDb.UPGRADES[item]["displayname"]
	lblDescription.text = UpgradeDb.UPGRADES[item]["details"]
	lblLevel.text = UpgradeDb.UPGRADES[item]["level"]
	itemIcon.texture = load(UpgradeDb.UPGRADES[item]["icon"])
	
func _input(event):
	if event.is_action("click") or event is InputEventScreenTouch and event.pressed:
		if mouse_over:
			emit_signal("selected_upgrade", item)

func _on_mouse_entered():
	mouse_over = true



func _process(delta):
	# Captura o movimento do analógico esquerdo
	var left_stick_input_x = Input.get_action_strength("rigthpause") - Input.get_action_strength("leftpause")
	var left_stick_input_y = Input.get_action_strength("uppause") - Input.get_action_strength("downpause")
	left_stick_input_y *= -1
	# Pega a posição atual do mouse
	var mouse_pos = get_viewport().get_mouse_position()
	
	# Calcula a nova posição do mouse
	var new_mouse_pos = mouse_pos + Vector2(left_stick_input_x, left_stick_input_y) * sensitivity
	
	# Atualiza a posição do mouse
	get_viewport().warp_mouse(new_mouse_pos)

func _on_mouse_exited():
	mouse_over = false
