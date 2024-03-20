extends Node3D


var _map:Map


func _ready():
	_map = Map.new(self)
	
	_map._display_path()
	_map._complete_grid()
	
	await get_tree().create_timer(2).timeout
	
	var pan:Panda = Panda.new(self)
	pan._pop_along_grid(_map)
	
