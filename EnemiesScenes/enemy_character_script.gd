class_name EnemyChar extends Area2D

var char_path_follow: PathFollow2D
var char_sprite_walk: Texture2D
var char_sprite_boom: Texture2D
var enemy_dmg: int
var enemy_move_speed: int
var enemy_lp: int
var dmg_num: int

func setup(new_path_follow: PathFollow2D):
	char_path_follow = new_path_follow
	enemy_move_speed = 100
	enemy_dmg = 10
	enemy_lp = 100

func _process(delta: float) -> void:
	char_path_follow.progress += enemy_move_speed * delta
	
	if char_path_follow.progress_ratio >= 0.99:
		print('boom')
		queue_free()
	elif char_path_follow.progress_ratio >= 0.90:
		$BarrelSprite2D.texture = char_sprite_boom
		
func dmg_enemy(dmg_num):
	enemy_lp = enemy_lp - dmg_num
	
	if enemy_lp <= 0:
		print('aaaahhhh')
		queue_free()
