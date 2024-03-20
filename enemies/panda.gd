class_name Panda extends "res://enemies/enemy.gd"

func _init(id, main, wave_manager):
	_box = preload("res://resources/basic_enemies_config.res").panda_tile.instantiate()
	_speed = preload("res://resources/basic_enemies_config.res").panda_speed
	_max_hp = preload("res://resources/basic_enemies_config.res").panda_hp
	super._init(id, main, wave_manager)
