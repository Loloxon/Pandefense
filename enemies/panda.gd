extends "res://enemies/enemy.gd"
class_name Panda


func _init(main):
	const BASIC_ENEMIES_TILES_CONFIG = preload("res://resources/basic_enemies_tiles_config.res")
	super._init(BASIC_ENEMIES_TILES_CONFIG.panda_tile, main)
