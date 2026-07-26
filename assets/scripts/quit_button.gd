extends TextureButton

func _ready():
	pressed.connect(_button_pressed)

# quit game
func _button_pressed():
	get_tree().quit()
