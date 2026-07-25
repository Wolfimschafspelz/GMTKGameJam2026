class_name Tower extends Node2D

var enemies: Array

@warning_ignore("unused_signal")
signal shoot(pos: Vector2, direction: float, projectile_enum: Data.Projectile)

func _process(delta: float) -> void:
	if enemies.size() > 0:
		print("Gegner im Turm-Radius! Anzahl: ", enemies.size())
	
func _on_enemy_detection_area_area_entered(area: Area2D) -> void:
	if area not in enemies:
		enemies.append(area)
		print(1)
	

func _on_enemy_detection_area_area_exited(area: Area2D) -> void:
	if area in enemies:
		enemies.erase(area)
