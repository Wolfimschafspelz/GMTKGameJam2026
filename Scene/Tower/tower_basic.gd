extends Tower

@export var price: int = 50
var is_active := false

@onready var bow_sprite: AnimatedSprite2D = $Archer/Bow

func _ready() -> void:
	if bow_sprite and not bow_sprite.animation_finished.is_connected(_on_bow_animation_finished):
		bow_sprite.animation_finished.connect(_on_bow_animation_finished)

func _process(_delta: float) -> void:
	super._process(_delta) # Wichtig für _clean_enemies_array() aus Tower
	
	if enemies.size() > 0 and is_instance_valid(enemies[0]):
		bow_sprite.look_at(enemies[0].global_position)
	else:
		# WENN KEIN GEGNER MEHR DA IST: Animation sofort abbrechen!
		_reset_to_idle()

func _on_relode_timer_timeout() -> void:
	# Nur schießen, wenn Turm aktiv IST UND wirklich Gegner da sind
	if not is_active or enemies.size() == 0:
		return
		
	var rot = bow_sprite.rotation
	var dir = Vector2.RIGHT.rotated(rot)
	var spawn_pos = bow_sprite.global_position + (dir * 24)
	
	if bow_sprite:
		bow_sprite.stop()
		bow_sprite.frame = 0
		bow_sprite.play("shoot")
		
	shoot.emit(spawn_pos, rot, Data.Projectile.SINGLE)

func _on_bow_animation_finished() -> void:
	if bow_sprite.animation == "shoot":
		_reset_to_idle()

# Hilfsfunktion zum Zurücksetzen der Animation
func _reset_to_idle() -> void:
	if bow_sprite and bow_sprite.animation == "shoot":
		if bow_sprite.sprite_frames.has_animation("default"):
			bow_sprite.play("default")
		elif bow_sprite.sprite_frames.has_animation("idle"):
			bow_sprite.play("idle")
		else:
			bow_sprite.stop()
			bow_sprite.frame = 0

func _on_enemy_detection_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		activate_tower()
		
func activate_tower() -> void:
	if is_active:
		return 
		
	is_active = true
	print("Turm aktiviert für 5 Sekunden!")

	await get_tree().create_timer(5.0).timeout

	is_active = false
	_reset_to_idle()
	print("Turm wieder inaktiv!")

func _on_active_timer_timeout() -> void:
	is_active = false
	_reset_to_idle()
	print("Turm wieder inaktiv!")
