class_name TankEnemy5 extends "res://enemies/enemy.gd"

@export var dying_sound = load("res://audio/body_fall_short.mp3")
@onready var health_bar = $tank/Area3D/health_bar/ProgressBar

func _init():
	_speed = 0.01
	_max_hp = 100
	_kill_reward = 50
	_kill_score = 5
	dmg = 6
	super._init()

func _create_model():
	$tank.global_rotation_degrees = Vector3(0, 90, 0)
	var scale = 0.3
	$tank.scale = Vector3(scale, scale, scale)
	_movement_animation = $tank/AnimationPlayer

func _resize_model():
	$tank.scale = Vector3(_current_hp/_max_hp*0.4, _current_hp/_max_hp*0.4, _current_hp/_max_hp*0.4)

func _change_health_bar():
	health_bar.value = (_current_hp * 100) / _max_hp

func _kill(by_base:bool):
	_alive = false
	if not by_base:
		AudioManager.play_effect(dying_sound, "enemy")
		GlobalScore.money += _kill_reward
		GlobalScore.score += _kill_score
	queue_free()

