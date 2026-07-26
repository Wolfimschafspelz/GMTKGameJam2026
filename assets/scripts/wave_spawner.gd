extends Node

func spawn_enemy():
	# TODO: integrate enemy
	pass
	
func spawn_wave(size: int):
	for i in range(size):
		spawn_enemy()
		get_tree().create_timer(1).timeout

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
