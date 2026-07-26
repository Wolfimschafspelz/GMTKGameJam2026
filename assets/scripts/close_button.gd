extends TextureButton

@onready var buttons: VBoxContainer = $"../../Buttons"
@onready var credits_screen: TextureRect = $"../../CreditsScreen"

func _ready() -> void:
	pressed.connect(_button_pressed)

func _button_pressed():
	credits_screen.visible = false
	buttons.visible = true
