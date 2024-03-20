class_name Map extends Object

const tile_config: MapTilesConfig = preload("res://resources/basic_tiles_config.res")
const path_config: PathGeneratorConfig = preload("res://resources/basic_path_config.res")
var _path_generator: PathGenerator

func _init():
	_path_generator = PathGenerator.new()
	_path_generator.generate_path()


func get_path():
	return _path_generator.get_path()


func display(main):
	_display_path(main)
	_display_complete_grid(main)


func _display_path(main):
	for i in range(_path_generator.get_path().size()):
		var tile_score:int = _path_generator.get_tile_score(i)
		
		var tile_information:Array = _score_to_tile(tile_score)
		var tile:Node3D = tile_information[0]
		var tile_rotation:Vector3 = tile_information[1]

		main.add_child(tile)
		tile.global_position = Vector3(_path_generator.get_path_tile(i).x, 0, _path_generator.get_path_tile(i).y)
		tile.global_rotation_degrees = tile_rotation


func _display_complete_grid(main):
	for x in range(path_config.map_length):
		for y in range(path_config.map_height):
			if not _path_generator.get_path().has(Vector2i(x,y)):
				var tile:Node3D = tile_config.tile_empty.pick_random().instantiate()
				main.add_child(tile)
				tile.global_position = Vector3(x, 0, y)
				tile.global_rotation_degrees = Vector3(0, randi_range(0,3)*90, 0)


func _score_to_tile(tile_score):
	var tile:Node3D = tile_config.tile_empty[0].instantiate()
	var tile_rotation:Vector3 = Vector3.ZERO
	
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
		
	return [tile, tile_rotation]
