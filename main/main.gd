class_name Main extends Node3D


func _ready():
	var _map:Map = Map.new()
	_map.display(self)
	
	await get_tree().create_timer(2).timeout

	var pan:Panda = Panda.new(self)
	pan._move_along(_map.get_path())
	
