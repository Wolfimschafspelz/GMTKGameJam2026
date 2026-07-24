extends Node

const max_health = 100
var health: int
var points: int

# TODO: Wave management

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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
