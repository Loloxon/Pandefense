class_name Enemy extends Object

var _main:Main
var _wave_manager:WaveManager
var _box:Node3D
var _hp:float = 10
var _speed:float

func _init(main, wave_manager):
	_check_validity()
	_main = main
	_wave_manager = wave_manager
	_create_model()


func _create_model():
	_box.global_rotation_degrees = Vector3(0, 180, 0)
	_box.scale = Vector3(0.4, 0.4, 0.4)

func _check_validity():
	assert( _speed > 0, "ERROR: Enemy speed must be greater then 0.");

func move_along(_path):
	var c3d:Curve3D = Curve3D.new()
	
	for element in _path:
		c3d.add_point(Vector3(element.x, 0.1, element.y))

	var p3d:Path3D = Path3D.new()
	_main.add_child(p3d)
	p3d.curve = c3d
	
	var pf3d:PathFollow3D = PathFollow3D.new()
	p3d.add_child(pf3d)
	pf3d.add_child(_box)
	
	var curr_distance:float = 0.0
	
	while curr_distance < c3d.point_count-1:
		curr_distance += _speed
		pf3d.progress = clamp(curr_distance, 0, c3d.point_count-1.00001)
		await _main.get_tree().create_timer(0.01).timeout
		receive_dmg(0.02)


func receive_dmg(dmg):
	_hp -= dmg
	_check_if_dying()


func _check_if_dying():
	if _hp<=0:
		_kill_enemy()

func _kill_enemy():
	#_wave_manager.kill_enemy(0)
	_box.hide()















