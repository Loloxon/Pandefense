extends Object
class_name Map

const tile_config: MapTilesConfig = preload("res://resources/basic_tiles_config.res")

var _grid_length:int
var _grid_height:int
var _loop_count:int

@export var map_length:int = 16
@export var map_height:int = 10

@export var min_path_size = 50
@export var max_path_size = 70
@export var min_loops = 3
@export var max_loops = 5

var _main

var _path_generator: PathGenerator
const path_config: PathGeneratorConfig = preload("res://resources/basic_path_config.res")

func _init(main):
	_main = main
	_grid_length = path_config.map_length
	_grid_height = path_config.map_height
	
	_path_generator = PathGenerator.new()


func _complete_grid():
	for x in range(_grid_length):
		for y in range(_grid_height):
			if not _path_generator.get_path().has(Vector2i(x,y)):
				var tile:Node3D = tile_config.tile_empty.pick_random().instantiate()
				_main.add_child(tile)
				tile.global_position = Vector3(x, 0, y)
				tile.global_rotation_degrees = Vector3(0, randi_range(0,3)*90, 0)
	
func _display_path():
	var iteration_count:int = 1
	_path_generator.generate_path(true)

	while _path_generator.get_path().size() < min_path_size or _path_generator.get_path().size() > max_path_size or\
	 _path_generator.get_loop_count() < min_loops or _path_generator.get_loop_count() > max_loops:
		iteration_count += 1
		_path_generator.generate_path(true)

	print("Generated a path of %d tiles after %d iterations" % [_path_generator.get_path().size(), iteration_count])
	print(_path_generator.get_path())
	
	
	for i in range(_path_generator.get_path().size()):
		var tile_score:int = _path_generator.get_tile_score(i)
		
		var tile:Node3D = tile_config.tile_empty[0].instantiate()
		var tile_rotation: Vector3 = Vector3.ZERO
		
		if tile_score == 2:
			tile = tile_config.tile_start.instantiate()
			tile_rotation = Vector3(0, 270, 0)
		elif tile_score == 8:
			tile = tile_config.tile_end.instantiate()
			tile_rotation = Vector3(0, 90, 0)
			
		elif tile_score == 10:
			tile = tile_config.tile_straight.instantiate()
			tile_rotation = Vector3(0, 90, 0)
		elif tile_score == 5:
			tile = tile_config.tile_straight.instantiate()
			tile_rotation = Vector3(0, 0, 0)
			
		elif tile_score == 3:
			tile = tile_config.tile_corner.instantiate()
			tile_rotation = Vector3(0, 270, 0)
		elif tile_score == 6:
			tile = tile_config.tile_corner.instantiate()
			tile_rotation = Vector3(0, 180, 0)
		elif tile_score == 12:
			tile = tile_config.tile_corner.instantiate()
			tile_rotation = Vector3(0, 90, 0)
		elif tile_score == 9:
			tile = tile_config.tile_corner.instantiate()
			tile_rotation = Vector3(0, 0, 0)
		
		elif tile_score == 15:
			tile = tile_config.tile_crossroads.instantiate()
			tile_rotation = Vector3(0,0,0)
					
		_main.add_child(tile)
		tile.global_position = Vector3(_path_generator.get_path_tile(i).x, 0, _path_generator.get_path_tile(i).y)
		tile.global_rotation_degrees = tile_rotation
	
func get_path_gen():
	return _path_generator
