class_name Enemy extends Object

var _main:Main
var _wave_manager:WaveManager
var _box:Node3D
var _max_hp:float
var _current_hp:float
var _speed:float
var _id:int
var _alive:bool = false

func _init(id, main, wave_manager):
	_id = id
	_check_validity()
	_main = main
	_wave_manager = wave_manager
	_current_hp = _max_hp
	_create_model()


func get_info():
	return str("ID: ", _id, "; HP ", _current_hp, "/", _max_hp)


func _check_validity():
	assert( _speed > 0, "ERROR: Enemy speed must be greater then 0.");
	assert( _max_hp > 0, "ERROR: Enemy max hp must be greater then 0.");


func _create_model():
	_box.global_rotation_degrees = Vector3(0, 180, 0)
	_box.scale = Vector3(0.4, 0.4, 0.4)


func move_along(_path):
	var c3d:Curve3D = Curve3D.new()
	
	for element in _path:
		c3d.add_point(Vector3(element.x, 0.1, element.y))

	var p3d:Path3D = Path3D.new()
	_main.add_child(p3d)
	_alive = true
	
	p3d.curve = c3d
	
	var pf3d:PathFollow3D = PathFollow3D.new()
	p3d.add_child(pf3d)
	pf3d.add_child(_box)
	
	var curr_distance:float = 0.0
	
	while curr_distance < c3d.point_count-1:
		curr_distance += _speed
		pf3d.progress = clamp(curr_distance, 0, c3d.point_count-1.00001)
		await _main.get_tree().create_timer(0.01).timeout		

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
	_box.scale = Vector3(_current_hp/_max_hp*0.6, _current_hp/_max_hp*0.6, _current_hp/_max_hp*0.6)

func is_alive():
	return _alive


func _check_if_dying():
	if _current_hp<=0:
		_kill()

func _kill():
	_alive = false
	_wave_manager.kill_enemy(self)
	_box.hide()















