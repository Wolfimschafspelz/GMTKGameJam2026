extends Node2D

var enemy_char_scene_blue = preload("res://EnemiesScenes/enemy_blue.tscn")
var enemy_char_scene_purple = preload("res://EnemiesScenes/enemy_purple.tscn")
var enemy_char_scene_yellow = preload("res://EnemiesScenes/enemy_yellow.tscn")
var enemy_char_scene_red = preload("res://EnemiesScenes/enemy_red.tscn")
var enemy_char_scene: Area2D
var spawn_enemy: bool
var enemy_vers_to_spawn: int
var enemyspawntimer: float
var timermemory: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_enemy = false
	enemy_vers_to_spawn = 0
	enemyspawntimer = 0.0
	timermemory = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	enemyspawntimer += 1
	
	if (enemyspawntimer - timermemory) >= 200.0:
		enemyspawntimer = 0
		spawn_enemy = true
		enemy_vers_to_spawn += 1
		
	if enemy_vers_to_spawn > 4:
		enemy_vers_to_spawn = 1
	
	if spawn_enemy:
		spawn_enemy = false
		
		if enemy_vers_to_spawn == 1:
			var path_followblue = PathFollow2D.new()
			var enemyblue = enemy_char_scene_blue.instantiate()
			enemyblue.setup(path_followblue)
			path_followblue.add_child(enemyblue)
			$Path2D.add_child(path_followblue)
		elif enemy_vers_to_spawn == 2:
			var path_followpurple = PathFollow2D.new()
			var enemypurple = enemy_char_scene_purple.instantiate()
			enemypurple.setup(path_followpurple)
			path_followpurple.add_child(enemypurple)
			$Path2D.add_child(path_followpurple)
		elif enemy_vers_to_spawn == 3:
			var path_followyellow = PathFollow2D.new()
			var enemyyellow = enemy_char_scene_yellow.instantiate()
			enemyyellow.setup(path_followyellow)
			path_followyellow.add_child(enemyyellow)
			$Path2D.add_child(path_followyellow)
		elif enemy_vers_to_spawn == 4:
			var path_followred = PathFollow2D.new()
			var enemyred = enemy_char_scene_red.instantiate()
			enemyred.setup(path_followred)
			path_followred.add_child(enemyred)
			$Path2D.add_child(path_followred)
