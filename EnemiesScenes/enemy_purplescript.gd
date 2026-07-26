extends EnemyChar

func setup(new_path_follow: PathFollow2D):
	char_sprite_walk = load("res://assets/Tiny Swords (Update 010)/Factions/Goblins/Troops/Barrel/Purple/Barrel_PurpleDefault.png")
	char_sprite_boom = load("res://assets/Tiny Swords (Update 010)/Factions/Goblins/Troops/Barrel/Purple/Barrel_PurpleBoom.png")
	char_path_follow = new_path_follow
	enemy_dmg = 20
	enemy_lp = 15
	enemy_move_speed = 100
	$BarrelSprite2D.texture = char_sprite_walk
