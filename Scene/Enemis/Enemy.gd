extends Node2D # Oder Area2D, je nach Aufbau

var health := 50.0
var path_follow: PathFollow2D

func setup(new_path_follow: PathFollow2D) -> void:
	path_follow = new_path_follow 

func _process(delta: float) -> void:
	if path_follow:
		path_follow.progress += 20 * delta
		
		if path_follow.progress_ratio >= 0.99:
			# Löscht auch den PathFollow2D-Node, nicht nur den Gegner selbst
			path_follow.queue_free()

# Diese Funktion wird vom Projektil aufgerufen
func take_damage(amount: float) -> void:
	health -= amount
	print("Gegner getroffen! Restleben: ", health)
	
	if health <= 0:
		die()

func die() -> void:
	if path_follow:
		path_follow.queue_free()
	else:
		queue_free()
