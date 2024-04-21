class_name WomanEnemy extends "res://enemies/enemy.gd"


func _init():
	_speed = 0.02
	_max_hp = 10
	super._init()

func _create_model():
	$woman_walking.global_rotation_degrees = Vector3(0, 90, 0)
	var scale = 0.4
	$woman_walking.scale = Vector3(scale, scale, scale)
	_movement_animation = $woman_walking/AnimationPlayer

func _resize_model():
	$woman_walking.scale = Vector3(_current_hp/_max_hp*0.6, _current_hp/_max_hp*0.6, _current_hp/_max_hp*0.6)
