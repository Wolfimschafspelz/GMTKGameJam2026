class_name Tower extends Node2D

# Array zur Speicherung aller Gegner-Areas, die sich aktuell im Erkennungsradius befinden
var enemies: Array[EnemyChar]

# Signal, das beim Schießen ausgesendet wird (z. B. an die Hauptszene, um das Projektil zu erstellen)
@warning_ignore("unused_signal")
signal shoot(pos: Vector2, direction: float, projectile_enum: Data.Projectile)

func _process(delta: float) -> void:
	_clean_enemies_array()
	
	if enemies.size() > 0:
		print("Gegner im Turm-Radius! Anzahl: ", enemies.size())
	
	for enemy in enemies:
		enemy.dmg_enemy(1)
	await get_tree().create_timer(1).timeout

# Entfernt gelöschte Gegner-Instanzen rückwärts aus dem Array
func _clean_enemies_array() -> void:
	for i in range(enemies.size() - 1, -1, -1):
		if not is_instance_valid(enemies[i]):
			enemies.remove_at(i)
# Wird aufgerufen, wenn eine andere Area2D den Erkennungsbereich betritt
func _on_enemy_detection_area_area_entered(area: Area2D) -> void:
	# Fügt die Area nur hinzu, wenn sie nicht bereits in der Liste ist
	if area not in enemies:
		enemies.append(area)

# Wird aufgerufen, wenn eine Area2D den Erkennungsbereich verlässt
func _on_enemy_detection_area_area_exited(area: Area2D) -> void:
	# Entfernt die Area aus der Liste, falls sie enthalten ist
	if area in enemies:
		enemies.erase(area)
