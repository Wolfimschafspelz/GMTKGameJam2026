extends Tower

# Exportierte Variable: Kann direkt im Godot-Inspector angepasst werden
@export var price: int = 50

# Zustand des Turms (ob er aktuell angreifen darf)
var is_active := false

# Referenz auf die Animation des Bogens (wird geladen, sobald der Node bereit ist)
@onready var bow_sprite: AnimatedSprite2D = $Archer/Bow

func _ready() -> void:
	# Verbindet das Signal "animation_finished" mit unserer Funktion, 
	# falls es noch nicht verbunden ist.
	if bow_sprite and not bow_sprite.animation_finished.is_connected(_on_bow_animation_finished):
		bow_sprite.animation_finished.connect(_on_bow_animation_finished)

func _process(_delta: float) -> void:
	# WICHTIG: Ruft die _process()-Methode der Basisklasse (Tower) auf.
	# Bereinigt ungültige/gelöschte Gegner aus dem enemies-Array.
	super._process(_delta) 
	
	# Wenn mindestens ein valider Gegner in Reichweite ist:
	if enemies.size() > 0 and is_instance_valid(enemies[0]):
		# Bogen auf die Position des ersten Gegners ausrichten
		bow_sprite.look_at(enemies[0].global_position)
	else:
		# Wenn kein Gegner da ist: Schuss-Animation sofort abbrechen und auf Idle setzen
		_reset_to_idle()

func _on_relode_timer_timeout() -> void:
	# Sicherstellen, dass nur geschossen wird, wenn der Turm aktiv ist UND Gegner da sind
	if not is_active or enemies.size() == 0:
		return
		
	# Berechne die Position, an der das Projektil gespawnt werden soll (24 Pixel vor dem Bogen)
	var rot = bow_sprite.rotation
	var dir = Vector2.RIGHT.rotated(rot)
	var spawn_pos = bow_sprite.global_position + (dir * 24)
	
	# Schuss-Animation von Frame 0 neu starten
	if bow_sprite:
		bow_sprite.stop()
		bow_sprite.frame = 0
		bow_sprite.play("shoot")
		
	# Signal aussenden, damit die Map/das Spiel das Projektil instanziiert
	shoot.emit(spawn_pos, rot, Data.Projectile.SINGLE)

func _on_bow_animation_finished() -> void:
	# Wenn die Schuss-Animation zu Ende gelaufen ist, zurück zur Ruhe-Animation
	if bow_sprite.animation == "shoot":
		_reset_to_idle()

# Hilfsfunktion zum Zurücksetzen der Animation in den Ruhezustand
func _reset_to_idle() -> void:
	# Nur zurücksetzen, wenn aktuell noch die "shoot"-Animation läuft
	if bow_sprite and bow_sprite.animation == "shoot":
		if bow_sprite.sprite_frames.has_animation("default"):
			bow_sprite.play("default")
		elif bow_sprite.sprite_frames.has_animation("idle"):
			bow_sprite.play("idle")
		else:
			# Falls weder "default" noch "idle" existiert: Animation stoppen
			bow_sprite.stop()
			bow_sprite.frame = 0

func _on_enemy_detection_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	# Turm per Linksklick auf die Detection Area aktivieren
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		activate_tower()
		
func activate_tower() -> void:
	# Verhindert doppelttes Auslösen, wenn der Turm bereits aktiv ist
	if is_active:
		return 
		
	is_active = true
	print("Turm aktiviert für 5 Sekunden!")

	# Wartet 5 Sekunden, ohne den Rest des Spiels zu blockieren (Asynchron)
	await get_tree().create_timer(5.0).timeout

	# Nach Ablauf der 5 Sekunden: Turm deaktivieren
	is_active = false
	_reset_to_idle()
	print("Turm wieder inaktiv!")

func _on_active_timer_timeout() -> void:
	# Falls alternativ ein Timer-Node ("ActiveTimer") verwendet wird
	is_active = false
	_reset_to_idle()
	print("Turm wieder inaktiv!")
