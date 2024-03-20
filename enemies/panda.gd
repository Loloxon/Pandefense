class_name Panda extends "res://enemies/enemy.gd"

func _init(main):
	const BASIC_ENEMIES_TILES_CONFIG = preload("res://resources/basic_enemies_tiles_config.res")
	super._init(BASIC_ENEMIES_TILES_CONFIG.panda_tile, main)
