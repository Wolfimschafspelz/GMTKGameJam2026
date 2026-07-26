extends Node2D

@onready var ui_layer: TileMapLayer = $UILayer
@onready var enemy_path: Path2D = $"EnemyPath"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameMode.path = enemy_path
	enable_selection()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func enable_selection():
	ui_layer.is_active = true

func disable_selection():
	ui_layer.is_active = false
