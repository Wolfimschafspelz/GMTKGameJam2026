extends Area2D

var direction: Vector2
var speed := 400.0
var damage := 10.0 # Bspw. Schaden aus Data.Projectile laden

func setup(pos: Vector2, angle: float, projectile_enum: Data.Projectile) -> void:
	position = pos
	rotation = angle
	# Vector2.RIGHT ist die Standard-Blickrichtung (0 Grad) in Godot
	direction = Vector2.RIGHT.rotated(angle)
	# Hier kannst du z.B. spätere Logik für das Enum einbauen

func _process(delta: float) -> void:
	# Richtige Verwendung von delta für eine flüssige Bewegung
	position += direction * speed * delta

# Signal "area_entered" vom Area2D-Node verbinden
func _on_area_entered(area: Area2D) -> void:
	# Prüfen, ob die getroffene Area ein Gegner ist
	if area.has_method("take_damage"):
		area.take_damage(damage)
		queue_free() # Löscht das Projektil bei Treffer
	elif area.owner and area.owner.has_method("take_damage"):
		area.owner.take_damage(damage)
		queue_free() # Löscht das Projektil bei Treffer
