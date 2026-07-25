extends Tower

func _process(_delta: float) -> void:
	if enemies.size() > 0:
		# Richtet den Bogen exakt auf den Gegner aus (0 Grad = Rechts)
		$Archer/Bow.look_at(enemies[0].global_position)

func _on_relode_timer_timeout() -> void:
	if enemies.size() > 0:
		var rot = $Archer/Bow.rotation
		
		# Vector2.RIGHT ist die Standard-Nullrichtung in Godot!
		var dir = Vector2.RIGHT.rotated(rot)
		
		# Verwende global_position für spawn_pos, damit Offsets stimmen:
		var spawn_pos = $Archer/Bow.global_position + (dir * 16)
		
		# Sendet das Signal mit Position und genauer Rotation
		shoot.emit(spawn_pos, rot, Data.Projectile.SINGLE)
