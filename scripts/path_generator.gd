extends Object
class_name PathGenerator

var _grid_length
var _grid_height

var _path: Array[Vector2i]

func _init(length: int, height: int):
	_grid_length = length
	_grid_height = height

func valid_cords(x: int, y: int):
	if _path.has(Vector2i(x, y)) or\
		_path.has(Vector2i(x-1, y)) and _path.has(Vector2i(x+1, y)) or\
		_path.has(Vector2i(x-1, y)) and _path.has(Vector2i(x, y-1)) or\
		_path.has(Vector2i(x-1, y)) and _path.has(Vector2i(x, y+1)) or\
		_path.has(Vector2i(x+1, y)) and _path.has(Vector2i(x, y-1)) or\
		_path.has(Vector2i(x+1, y)) and _path.has(Vector2i(x+1, y+1)) or\
		_path.has(Vector2i(x, y-1)) and _path.has(Vector2i(x, y+1)):
		return false
	return true

func generate_path():
	_path.clear()
	
	var x = 0
	var y = 0
	
	var couter = 0
	
	_path.append(Vector2i(0, 0))
	
	while x < _grid_length:
		if couter > 10000:
			x = 0
			y = 0
			_path.clear()
		
		var choice: int = randi_range(0,4)
		var x_old = x
		var y_old = y
		
		if choice == 0 and x < _grid_length:
			x += 1
		elif choice == 1 and x > 0:
			x -= 1
		elif choice == 2 and y < _grid_height:
			y += 1
		elif choice == 3 and y > -_grid_height:
			y -= 1
		
		if valid_cords(x, y):
			_path.append(Vector2i(x, y))
		else:
			x = x_old
			y = y_old
		couter += 1
		
	return _path
