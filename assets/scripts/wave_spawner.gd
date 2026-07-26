extends Node

var enemies = [
	preload("res://EnemiesScenes/enemy_blue.tscn"), 
	preload("res://EnemiesScenes/enemy_purple.tscn"), 
	preload("res://EnemiesScenes/enemy_yellow.tscn"),
	preload("res://EnemiesScenes/enemy_red.tscn")
]

func spawn_enemy(enemy: Resource, path: Path2D):
	var enemy_inst = enemy.instantiate()
	enemy_inst.setup(path)
	path.add_child(enemy_inst)
	$Path2D.add_child(path)
	
func spawn_wave(size: int):
	for i in range(size):
		spawn_enemy(enemies[randi() % len(enemies)], GameMode.path)
		get_tree().create_timer(1).timeout

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
