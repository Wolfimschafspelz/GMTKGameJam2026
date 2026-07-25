extends Node2D

var path_follow: PathFollow2D

func setup(new_path_follow: PathFollow2D) -> void:
	path_follow = new_path_follow 

func _process(delta: float) -> void:
	if path_follow:
		path_follow.progress += 20 * delta
		
		# Erst löschen, wenn er ganz am Ende des Pfades angekommen ist (1.0 = 100%)
		if path_follow.progress_ratio >= 0.99:
			queue_free()
