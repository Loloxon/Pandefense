class_name Main extends Node3D

var map:Map = Map.new()
var wave_manager:WaveManager
@export var money = 100
@export var score = 0

func _ready():
	map.display(self)
	
	wave_manager = WaveManager.new(self, map)
	wave_manager.spawn_wave()
	
	#wave_manager.simulate_fights()

func _process(delta):
	$Control/money_label.text = "Money: %d ¥" % money
	$Control/score_label.text = "Score: %d" % score
