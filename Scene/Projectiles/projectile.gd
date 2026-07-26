extends Area2D

# Flugrichtung und Eigenschaften des Projektils
var direction: Vector2
var speed := 400.0
var damage := 10.0
var has_hit := false # Verhindert, dass der Pfeil mehrfach Schaden zufügt

# Referenzen auf die Node-Kinder (Sprites und Kollision)
@onready var flying_arrow: AnimatedSprite2D = $AnimatedSprite2D
@onready var broken_arrow: AnimatedSprite2D = $Arrow_broken
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	# Beim Start: Fliegenden Pfeil anzeigen und abspielen, zerbrochenen Pfeil verstecken
	if flying_arrow:
		flying_arrow.visible = true
		flying_arrow.play("default")
	if broken_arrow:
		broken_arrow.visible = false

# Initialisiert die Startwerte beim Spawnen des Projektils
func setup(pos: Vector2, angle: float, _projectile_enum: Data.Projectile) -> void:
	global_position = pos
	rotation = angle
	direction = Vector2.RIGHT.rotated(angle) # Berechnet den Richtungsvektor aus dem Winkel
	has_hit = false

func _process(delta: float) -> void:
	# Bewegt den Pfeil kontinuierlich in Flugrichtung, solange er nichts getroffen hat
	if not has_hit:
		global_position += direction * speed * delta

# Wird aufgerufen, wenn der Pfeil eine andere Area2D (z. B. eine Gegner-Hbox) trifft
func _on_area_entered(area: Area2D) -> void:
	if has_hit:
		return
	
	has_hit = true
	
	# Kollision verzögert deaktivieren, um Physik-Fehler während des Signals zu vermeiden
	if collision_shape:
		collision_shape.set_deferred("disabled", true)
	
	# Prüft, ob die getroffene Area oder deren Parent (Gegner-Node) Schaden nehmen kann
	var target = null
	if area.has_method("take_damage"):
		target = area
	elif area.owner and area.owner.has_method("take_damage"):
		target = area.owner
		
	if target:
		target.take_damage(damage)
	
	# Grafischer Wechsel: Fliegender Pfeil ausblenden, zerbrochenen Pfeil animieren
	if flying_arrow:
		flying_arrow.visible = false
	if broken_arrow:
		broken_arrow.visible = true
		broken_arrow.frame = 0
		broken_arrow.play("default")

	# Wartet 0,3 Sekunden (für Treffer-Effekt/Animation), bevor das Projektil gelöscht wird
	await get_tree().create_timer(0.3).timeout
	queue_free()

# Löscht den Pfeil automatisch aus dem Speicher, wenn er das Bild verlässt (Performance-Schutz)
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
