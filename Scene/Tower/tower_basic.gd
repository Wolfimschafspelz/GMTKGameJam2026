extends Tower

@export var price: int = 50
var is_active := false

@onready var bow_sprite: AnimatedSprite2D = $Archer/Bow

func _ready() -> void:
	# Binde das Signal ein, um nach dem Schuss wieder zur Stand-Animation zu wechseln
	if bow_sprite:
		bow_sprite.animation_finished.connect(_on_bow_animation_finished)

func _process(_delta: float) -> void:
	if enemies.size() > 0:
		# Dreht NUR die Bow-Node auf den Gegner
		$Archer/Bow.look_at(enemies[0].global_position)

func _on_relode_timer_timeout() -> void:
	if is_active and enemies.size() > 0:
		var rot = $Archer/Bow.rotation
		var dir = Vector2.RIGHT.rotated(rot)
		var spawn_pos = $Archer/Bow.global_position + (dir * 24)
		
		if bow_sprite:
			bow_sprite.stop()
			bow_sprite.frame = 0
			bow_sprite.play("shoot")
		
		
		shoot.emit(spawn_pos, rot, Data.Projectile.SINGLE)

func _on_bow_animation_finished() -> void:
	# Nach dem Schuss zurück zur Standard-Animation (z. B. "idle" oder "default")
	if bow_sprite.animation == "shoot":
		if bow_sprite.sprite_frames.has_animation("default"):
			bow_sprite.play("default")
		elif bow_sprite.sprite_frames.has_animation("idle"):
			bow_sprite.play("idle")

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
	print("Turm wieder inaktiv!")

func _on_active_timer_timeout() -> void:
	is_active = false
	print("Turm wieder inaktiv!")
