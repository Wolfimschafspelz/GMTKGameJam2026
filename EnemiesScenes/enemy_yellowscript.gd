extends EnemyChar

func setup(new_path_follow: PathFollow2D):
	char_sprite_walk = load("res://assets/Tiny Swords (Update 010)/Factions/Goblins/Troops/Barrel/Yellow/Barrel_YellowDefault.png")
	char_sprite_boom = load("res://assets/Tiny Swords (Update 010)/Factions/Goblins/Troops/Barrel/Yellow/Barrel_YellowBoom.png")
	char_path_follow = new_path_follow
	enemy_dmg = 10
	enemy_lp = 8
	enemy_move_speed = 200
	$BarrelSprite2D.texture = char_sprite_walk
