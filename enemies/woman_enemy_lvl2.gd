class_name WomanEnemy2 extends "res://enemies/enemy.gd"

@export var dying_sound = load("res://audio/body_fall_short.mp3")
@onready var health_bar = $woman_walking/Area3D/health_bar/ProgressBar

func _init():
	_speed = 0.02
	_max_hp = 10
	_kill_reward = 15
	_kill_score = 1
	super._init()

func _create_model():
	$woman_walking.global_rotation_degrees = Vector3(0, 90, 0)
	var scale = 0.3
	$woman_walking.scale = Vector3(scale, scale, scale)
	_movement_animation = $woman_walking/AnimationPlayer

func _resize_model():
	$woman_walking.scale = Vector3(_current_hp/_max_hp*0.4, _current_hp/_max_hp*0.4, _current_hp/_max_hp*0.4)

func _change_health_bar():
	health_bar.value = (_current_hp * 100) / _max_hp

func _kill(by_base:bool):
	_alive = false
	if not by_base:
		AudioManager.play_effect(dying_sound, "enemy")
		$"../../..".money += _kill_reward
		$"../../..".score += _kill_score
	queue_free()
