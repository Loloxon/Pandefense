extends Object
class_name Enemy

var _tile:PackedScene
var _main

func _init(tile, main):
	_tile = tile
	_main = main

func _pop_along_grid(map):
	var _path_generator = map.get_path_gen()
	var box = _tile.instantiate()
	
	box.global_rotation_degrees = Vector3(0, 180, 0)
	box.scale = Vector3(0.4, 0.4, 0.4)
	
	var c3d:Curve3D = Curve3D.new()
	
	for element in _path_generator.get_path():
		c3d.add_point(Vector3(element.x, 0.1, element.y))

	var p3d:Path3D = Path3D.new()
	_main.add_child(p3d)
	p3d.curve = c3d
	
	var pf3d:PathFollow3D = PathFollow3D.new()
	p3d.add_child(pf3d)
	pf3d.add_child(box)
	
	var curr_distance:float = 0.0
	
	while curr_distance < c3d.point_count-1:
		curr_distance += 0.02
		pf3d.progress = clamp(curr_distance, 0, c3d.point_count-1.00001)
		await _main.get_tree().create_timer(0.01).timeout
