extends EnemyChar

func setup(new_path_follow: PathFollow2D):
	char_sprite_walk = load("res://assets/Tiny Swords (Update 010)/Factions/Goblins/Troops/Barrel/Red/Barrel_RedDefault.png")
	char_sprite_boom = load("res://assets/Tiny Swords (Update 010)/Factions/Goblins/Troops/Barrel/Red/Barrel_RedBoom.png")
	char_path_follow = new_path_follow
	enemy_dmg = 30
	enemy_lp = 30
	enemy_move_speed = 80
	$BarrelSprite2D.texture = char_sprite_walk
