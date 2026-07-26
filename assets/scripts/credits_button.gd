extends TextureButton

@onready var button_container: VBoxContainer = $"../../Buttons"
@onready var credits_screen: TextureRect = $"../../CreditsScreen" 

func _ready():
	pressed.connect(_button_pressed)

func _button_pressed():
	button_container.visible = false
	credits_screen.visible = true
