extends Node2D

var enemy_scene = preload("res://Scene/Enemis/enemy.tscn")
var projectile_scene = preload("res://Scene/Projectiles/projectile.tscn")

func _ready() -> void:
	var path_follow = PathFollow2D.new()
	var enemy = enemy_scene.instantiate()
	
	# Erst als Child hinzufügen...
	path_follow.add_child(enemy)
	# ...dann dem Path2D hinzufügen...
	$Path2D.add_child(path_follow)
	# ...UND ERST DANN die Setup-Funktion aufrufen!
	enemy.setup(path_follow)
	
	$Tower_basic.connect("shoot", creat_Projectile)
	
	
func creat_Projectile(pos: Vector2, angle: float, projectile_enum: Data.Projectile):
	var projectile = projectile_scene.instantiate()
	projectile.setup(pos, angle, projectile_enum)
	
	# Fügt das Projektil direkt dem Level hinzu:
	add_child(projectile)
