extends Area2D

var direction: Vector2
var speed := 400.0
var damage := 10.0
var has_hit := false

@onready var flying_arrow: AnimatedSprite2D = $AnimatedSprite2D
@onready var broken_arrow: AnimatedSprite2D = $Arrow_broken
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
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
	
	has_hit = true
	if collision_shape:
		collision_shape.set_deferred("disabled", true)
	
	var target = null
	if area.has_method("take_damage"):
		target = area
	elif area.owner and area.owner.has_method("take_damage"):
		target = area.owner
		
	if target:
		target.take_damage(damage)
	
	if flying_arrow:
		flying_arrow.visible = false
	if broken_arrow:
		broken_arrow.visible = true
		broken_arrow.frame = 0
		broken_arrow.play("default")

	await get_tree().create_timer(0.3).timeout
	queue_free()

# Falls das Projektil aus dem Bild fliegt:
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
