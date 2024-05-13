class_name Enemy extends Node3D

@onready var _instance:Node3D
@onready var _movement_animation:AnimationPlayer

var _max_hp:float
var _current_hp:float
var _speed:float
var _alive:bool = false
var _kill_reward:int
var _kill_score:int

signal enemy_killed

func _init():
	_current_hp = _max_hp
	_check_validity()
	

func get_info():
	return str("HP ", _current_hp, "/", _max_hp)


func _check_validity():
	assert( _speed > 0, "ERROR: Enemy speed must be greater then 0.");
	assert( _max_hp > 0, "ERROR: Enemy max hp must be greater then 0.");


func _create_model():
	pass


func instakill():
	_kill(false)
	enemy_killed.emit()

func receive_dmg(dmg):
	_current_hp = max(snappedf(_current_hp-dmg, 0.01), 0)
	_check_if_dying()
	_change_health_bar()
	#_resize_model() -> turned off in favour of health bar


func heal_dmg(heal):
	_current_hp = min(snappedf(_current_hp+heal, 0.01), _max_hp)
	_resize_model()


func _resize_model():
	pass

func _change_health_bar():
	pass

func is_alive():
	return _alive


func _check_if_dying():
	if _current_hp<=0:
		_kill(false)
		enemy_killed.emit()

func _kill(by_base:bool):
	pass

func _on_enemy_area_3d_area_entered(area):
	var groups = area.get_groups()
	if len(groups) > 0 and groups[0] == "base":
		_kill(true)
		enemy_killed.emit()
	else:
		receive_dmg(area.get_node("../../..").tower_dmg)
		area.get_node("../..").destroy_projectile()
	
