class_name Main extends Node3D

var map:Map = Map.new()
var wave_manager:WaveManager
@export var money = 50
@export var score = 0

func _ready():
	map.display(self)
	
	wave_manager = WaveManager.new(self, map)
	#wave_manager.spawn_wave()
	
	#wave_manager.simulate_fights()

func _process(delta):
	$Control/money_label.text = "Money: %d ¥" % money
	$Control/score_label.text = "Score: %d" % score


func _on_wave_button_pressed():
	$WaveState.send_event("to_active")


func _on_active_state_entered():
	$Control/wave_button.disabled = true
	wave_manager.spawn_wave()


func ready_for_next_wave():
	$WaveState.send_event("to_complete")


func _on_complete_state_entered():
	$Control/wave_button.disabled = false
