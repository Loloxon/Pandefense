class_name WomanEnemy extends "res://enemies/enemy.gd"


func _init():
	_instance = preload("res://scenes/enemies/woman_walking_scene.tscn").instantiate()
	_movement_animation = _instance.get_child(0).get_child(1)
	_speed = 0.02
	_max_hp = 10
	super._init()

func _create_model():
	_instance.global_rotation_degrees = Vector3(0, 90, 0)
	var scale = 0.4
	_instance.scale = Vector3(scale, scale, scale)


