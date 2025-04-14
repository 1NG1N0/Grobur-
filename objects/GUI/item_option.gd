extends ColorRect
var sensitivity = 3.0

@onready var lblName = $lbl_name
@onready var lblDescription = $lbl_description
@onready var lblLevel = $lbl_level
@onready var itemIcon = $ColorRect/ItemIcon

var mouse_over = false
var selected = false
var item = null
@onready var player = get_tree().get_first_node_in_group("Player")

signal selected_upgrade(upgrade)

func _ready():
	connect("selected_upgrade", Callable(player, "upgrade_character"))
	if item == null:
		item = "food"
	update_ui()

func update_ui():
	lblName.text = UpgradeDb.UPGRADES[item]["displayname"]
	lblDescription.text = UpgradeDb.UPGRADES[item]["details"]
	lblLevel.text = UpgradeDb.UPGRADES[item]["level"]
	itemIcon.texture = load(UpgradeDb.UPGRADES[item]["icon"])

func _input(event):
	if (event.is_action("click") or (event is InputEventScreenTouch and event.pressed)) and mouse_over:
		emit_signal("selected_upgrade", item)

	if event.is_action_pressed("ui_accept") and selected:
		emit_signal("selected_upgrade", item)

func _on_mouse_entered():
	mouse_over = true

func set_selected(value: bool):
	selected = value
	#self.modulate = Color(1, 1, 1, 1) if selected else Color(0.7, 0.7, 0.7, 1)

func _on_mouse_exited():
	mouse_over = false
