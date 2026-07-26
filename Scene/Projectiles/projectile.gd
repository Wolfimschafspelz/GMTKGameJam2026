extends Area2D

var direction: Vector2
var speed := 400.0
var damage := 10.0
var has_hit := false

# Beide Nodes als Referenz holen:
@onready var flying_arrow: AnimatedSprite2D = $AnimatedSprite2D
@onready var broken_arrow: AnimatedSprite2D = $Arrow_broken
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	# Beim Start: Fliegender Pfeil sichtbar, gebrochener Pfeil unsichtbar
	if flying_arrow:
		flying_arrow.visible = true
		flying_arrow.play("default")
	if broken_arrow:
		broken_arrow.visible = false

func setup(pos: Vector2, angle: float, _projectile_enum: Data.Projectile) -> void:
	global_position = pos
	rotation = angle
	direction = Vector2.RIGHT.rotated(angle)
	has_hit = false

func _process(delta: float) -> void:
	if not has_hit:
		global_position += direction * speed * delta

func _on_area_entered(area: Area2D) -> void:
	if has_hit:
		return
	
	# 1. Sofort als getroffen markieren & Bewegung/Kollision stoppen
	has_hit = true
	if collision_shape:
		collision_shape.set_deferred("disabled", true)
	
	# 2. Schaden anrichten (falls möglich)
	var target = null
	if area.has_method("take_damage"):
		target = area
	elif area.owner and area.owner.has_method("take_damage"):
		target = area.owner
		
	if target:
		target.take_damage(damage)
	
	# 3. Visueller Wechsel (Fliegender Pfeil aus, kaputter Pfeil an)
	if flying_arrow:
		flying_arrow.visible = false
	if broken_arrow:
		broken_arrow.visible = true

	# 4. Nach 0.3 Sekunden GARANTIERT löschen
	await get_tree().create_timer(0.3).timeout
	queue_free()
