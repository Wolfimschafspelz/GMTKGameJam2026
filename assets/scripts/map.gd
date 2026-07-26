extends Node2D

@onready var ui_layer = $UILayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enable_selection()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func enable_selection():
	ui_layer.is_active = true

func disable_selection():
	ui_layer.is_active = false
