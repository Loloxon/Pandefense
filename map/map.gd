class_name Map extends Object

const tile_config: MapTilesConfig = preload("res://resources/basic_tiles_config.res")
const path_config: PathGeneratorConfig = preload("res://resources/basic_path_config.res")
var _path_generator: PathGenerator
var _gate

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
		if x == path_config.map_length-1:
			for y in range(path_config.map_height):
				var tile:Node3D  = tile_config.tile_base_fence.instantiate()
				main.add_child(tile)
				tile.global_position = Vector3(x, 0, y)
				tile.global_rotation_degrees = Vector3(0, 180, 0)
				
				if y == 0:
					tile  = tile_config.tile_base_fence.instantiate()
					main.add_child(tile)
					tile.global_position = Vector3(x, 0, y)
					tile.global_rotation_degrees = Vector3(0, -90, 0)
				elif y == path_config.map_height-1:
					tile  = tile_config.tile_base_fence.instantiate()
					main.add_child(tile)
					tile.global_position = Vector3(x, 0, y)
					tile.global_rotation_degrees = Vector3(0, 90, 0)
		elif x < path_config.map_length-5:
			for y in range(path_config.map_height):
				if not _path_generator.get_path().has(Vector2i(x,y)):
					var tile:Node3D = tile_config.tile_empty[0].instantiate()
					
					if not (_path_generator.get_path().has(Vector2i(x-1,y)) 
						or _path_generator.get_path().has(Vector2i(x+1,y)) 
						or _path_generator.get_path().has(Vector2i(x,y-1))
						or _path_generator.get_path().has(Vector2i(x,y+1))
						or _path_generator.get_path().has(Vector2i(x+1,y+1))
						or _path_generator.get_path().has(Vector2i(x-1,y+1))
						or _path_generator.get_path().has(Vector2i(x-1,y-1))
						or _path_generator.get_path().has(Vector2i(x+1,y-1)))\
						and x < path_config.map_length-6:
						tile = tile_config.tile_empty.pick_random().instantiate()
					
					main.add_child(tile)
					tile.global_position = Vector3(x, 0, y)
					tile.global_rotation_degrees = Vector3(0, randi_range(0,3)*90, 0)
		elif x < path_config.map_length-4:
			for y in range(path_config.map_height):
				if y != int(path_config.map_height/2.0):
					var tile:Node3D  = tile_config.tile_base_fence.instantiate()
					main.add_child(tile)
					tile.global_position = Vector3(x, 0, y)
				
				
				if y == 0:
					var tile:Node3D  = tile_config.tile_base_fence.instantiate()
					main.add_child(tile)
					tile.global_position = Vector3(x, 0, y)
					tile.global_rotation_degrees = Vector3(0, -90, 0)
				elif y == path_config.map_height-1:
					var tile:Node3D  = tile_config.tile_base_fence.instantiate()
					main.add_child(tile)
					tile.global_position = Vector3(x, 0, y)
					tile.global_rotation_degrees = Vector3(0, 90, 0)
		else:
			for y in range(path_config.map_height):
				if y == 0:
					var tile:Node3D  = tile_config.tile_base_fence.instantiate()
					main.add_child(tile)
					tile.global_position = Vector3(x, 0, y)
					tile.global_rotation_degrees = Vector3(0, -90, 0)
				elif y == path_config.map_height-1:
					var tile:Node3D  = tile_config.tile_base_fence.instantiate()
					main.add_child(tile)
					tile.global_position = Vector3(x, 0, y)
					tile.global_rotation_degrees = Vector3(0, 90, 0)
				else:
					var tile:Node3D  = tile_config.tile_base.instantiate()
					main.add_child(tile)
					tile.global_position = Vector3(x, 0, y)
					tile.global_rotation_degrees = Vector3(0, randi_range(0,3)*90, 0)
				if y%2 == 1 and x%2 == 0:
					var tile:Node3D  = tile_config.tile_panda_base.pick_random().instantiate()
					_gate.pandas.append(tile)
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
		tile = tile_config.tile_base_gate.instantiate()
		_gate = tile
		#tile_rotation = Vector3(0, 90, 0)
		
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
