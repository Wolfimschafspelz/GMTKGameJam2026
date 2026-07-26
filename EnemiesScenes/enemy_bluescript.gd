extends EnemyChar

func setup(new_path_follow: PathFollow2D):
	char_sprite_walk = load("res://assets/Tiny Swords (Update 010)/Factions/Goblins/Troops/Barrel/Blue/Barrel_BlueDefault.png")
	char_sprite_boom = load("res://assets/Tiny Swords (Update 010)/Factions/Goblins/Troops/Barrel/Blue/Barrel_BlueBoom.png")
	char_path_follow = new_path_follow
	enemy_dmg = 12
	enemy_lp = 10
	enemy_move_speed = 100
	$BarrelSprite2D.texture = char_sprite_walk
