extends TextureButton

@onready var menu: Control = $"../../../Menu"

func _ready():
	pressed.connect(_button_pressed)

func _button_pressed():
	menu.visible = false
