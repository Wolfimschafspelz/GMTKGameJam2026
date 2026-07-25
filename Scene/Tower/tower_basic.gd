extends Tower

func _process(_delta: float) -> void:
	if enemies.size() > 0:
		$Archer/Bow.look_at(enemies[0].global_position)
		$Archer/Bow.rotation -= PI / 2

func _on_relode_timer_timeout() -> void:
	if enemies:
		var rot = $Archer/Bow.rotation
		var dir = Vector2.DOWN.rotated(rot).normalized()
		
		# Position mit Offset berechnen, Rotation sauber als float übergeben:
		var spawn_pos = position + (dir * 16)
		shoot.emit(spawn_pos, rot, Data.Projectile.SINGLE)
