extends Object
class_name PathGenerator

var _grid_length
var _grid_height

var _path: Array[Vector2i]

func _init(length: int, height: int):
	_grid_length = length
	_grid_height = height

func is_valid_coords(x: int, y: int) -> bool:
	if x <= 0 or x > _grid_length or y <= -_grid_height or y >= _grid_height:
		return false
	
	var sides = [Vector2i(x-1, y), Vector2i(x+1, y), Vector2i(x, y-1), Vector2i(x, y+1)]
	for s1 in sides:
		for s2 in sides:
			if s1!=s2 and _path.has(s1) and _path.has(s2):
				return false
	return true

func generate_path():
	_path.clear()
	
	var x = 0
	var y = 0
	
	while x <= _grid_length:
		if not _path.has(Vector2i(x, y)):
			_path.append(Vector2i(x, y))
		
		var choice: int = randi_range(0, 2)
		
		if choice == 0 or x % 2 == 0 or x == _grid_length-1:
			x += 1
		elif choice == 1 and y < _grid_height-1 and not _path.has(Vector2i(x, y+1)):
			y += 1
		elif choice == 2 and y > -_grid_height+1 and not _path.has(Vector2i(x, y-1)):
			y -= 1
			
		
	return _path

func get_tile_score(tile: Vector2i):
	var score: int = 0
	var x = tile.x
	var y = tile.y
	
	score += 1 if _path.has(Vector2i(x, y-1)) else 0
	score += 2 if _path.has(Vector2i(x+1, y)) else 0
	score += 4 if _path.has(Vector2i(x, y+1)) else 0
	score += 8 if _path.has(Vector2i(x-1, y)) else 0
	
	return score



