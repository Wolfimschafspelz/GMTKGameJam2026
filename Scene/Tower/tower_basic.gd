extends Tower

@export var price: int = 50 # Preis des Turms
var is_active := false


func _process(_delta: float) -> void:
	if enemies.size() > 0:
		# Richtet den Bogen exakt auf den Gegner aus (0 Grad = Rechts)
		$Archer/Bow.look_at(enemies[0].global_position)

func _on_relode_timer_timeout() -> void:
	# WICHTIG: Nur schießen, wenn der Turm AKTIV ist UND Gegner da sind!
	if is_active and enemies.size() > 0:
		var rot = $Archer/Bow.rotation
		var dir = Vector2.RIGHT.rotated(rot)
		var spawn_pos = $Archer/Bow.global_position + (dir * 16)
		
		shoot.emit(spawn_pos, rot, Data.Projectile.SINGLE)
		
func _on_enemy_detection_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		activate_tower()
		
func activate_tower() -> void:
	# Verhindert, dass Mehrfach-Klicks den Timer durcheinanderbringen
	if is_active:
		return 
		
	is_active = true
	print("Turm aktiviert für 5 Sekunden!")

	# Wartet exakt 5 Sekunden, ohne das Spiel zu blockieren:
	await get_tree().create_timer(5.0).timeout

	is_active = false
	print("Turm wieder inaktiv!")

# Verbinde das "timeout()"-Signal deines ActiveTimers mit dieser Funktion:
func _on_active_timer_timeout() -> void:
	is_active = false
	print("Turm wieder inaktiv!")
