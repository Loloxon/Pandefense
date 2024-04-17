class_name Enemy extends Node3D

@onready var _instance:Node3D
@onready var _movement_animation:AnimationPlayer
var _max_hp:float
var _current_hp:float
var _speed:float
var _alive:bool = false

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
	_kill()


func receive_dmg(dmg):
	_current_hp = max(snappedf(_current_hp-dmg, 0.01), 0)
	_check_if_dying()
	_resize_model()


func heal_dmg(heal):
	_current_hp = min(snappedf(_current_hp+heal, 0.01), _max_hp)
	_resize_model()


func _resize_model():
	_instance.scale = Vector3(_current_hp/_max_hp*0.6, _current_hp/_max_hp*0.6, _current_hp/_max_hp*0.6)

func is_alive():
	return _alive


func _check_if_dying():
	if _current_hp<=0:
		_kill()

func _kill():
	_alive = false
	_instance.hide()
