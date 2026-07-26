extends Node

const max_health = 100
var health: int
var points: int
var current_wave: int
var wave_size: int
var enemies_remaining: int
@export var path: Path2D

func spawn_wave():
	WaveSpawner.spawn_wave(wave_size)
	enemies_remaining = wave_size

func notify_enemy_killed():
	if enemies_remaining > 0:
		enemies_remaining -= 1

func next_wave_ready():
	return enemies_remaining == 0

func next_wave():
	if next_wave_ready():
		current_wave += 1
		spawn_wave()
		wave_size *= 1.2

func deposit_points(amount: int):
	points += amount

func can_buy(price: int) -> bool:
	return points >= price

func withdraw_points(amount: int):
	if points - amount <= 0:
		pass
	points -= amount

func die():
	# TODO: implement me
	pass

func take_damage(amount: int):
	health -= amount
	if health <= 0:
		die()
# Called when the node enters the scene tree for the first time.
func _ready():
	points = 0
	health = max_health
	wave_size = 10
	current_wave = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
