extends Area2D

var direction: Vector2
var speed := 400.0
var damage := 10.0
var has_hit := false

# Beide Nodes als Referenz holen:
@onready var flying_arrow: AnimatedSprite2D = $AnimatedSprite2D
@onready var broken_arrow = $Arrow_broken
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	# Beim Start: Fliegender Pfeil sichtbar, gebrochener Pfeil unsichtbar
	if flying_arrow:
		flying_arrow.visible = true
		flying_arrow.play("default") # Oder deine Flug-Animation
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
	
	var target = null
	if area.has_method("take_damage"):
		target = area
	elif area.owner and area.owner.has_method("take_damage"):
		target = area.owner
		
	if target:
		target.take_damage(damage)
		
		has_hit = true
		collision_shape.set_deferred("disabled", true)
		
		if flying_arrow:
			flying_arrow.visible = false
		
		if broken_arrow:
			broken_arrow.visible = true
			
			if broken_arrow is AnimatedSprite2D and broken_arrow.sprite_frames.has_animation("impact"):
				broken_arrow.play("impact")
				# WICHTIG: await wartet direkt, bis die Animation fertig ist, und löscht dann!
				await broken_arrow.animation_finished
				queue_free()
			else:
				# Falls es ein normales Sprite2D ist: 0.5 Sekunden anzeigen, dann löschen
				await get_tree().create_timer(0.5).timeout
				queue_free()
		else:
			queue_free()
