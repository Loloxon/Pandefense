class_name Panda extends "res://enemies/enemy.gd"

func _init(main, wave_manager):
	_box = preload("res://resources/basic_enemies_config.res").panda_tile.instantiate()	
	_speed = preload("res://resources/basic_enemies_config.res").panda_speed	
	super._init(main, wave_manager)
