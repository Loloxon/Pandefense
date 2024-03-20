class_name Enemy extends Object

var _main
var _box

func _init(tile, main):
	_main = main
	_create_model(tile)


func _create_model(tile):
	_box = tile.instantiate()
	_box.global_rotation_degrees = Vector3(0, 180, 0)
	_box.scale = Vector3(0.4, 0.4, 0.4)


func _move_along(_path):
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
		curr_distance += 0.02
		pf3d.progress = clamp(curr_distance, 0, c3d.point_count-1.00001)
		await _main.get_tree().create_timer(0.01).timeout
