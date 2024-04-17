class_name Main extends Node3D

var map:Map = Map.new()
var wave_manager:WaveManager

func _ready():
	map.display(self)
	
	wave_manager = WaveManager.new(self, map)
	wave_manager.spawn_wave()
	
	#wave_manager.simulate_fights()
