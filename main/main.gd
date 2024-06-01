class_name Main extends Node3D

var map:Map = Map.new()
var wave_manager:WaveManager

func _ready():
	map.display(self)
	
	wave_manager = WaveManager.new(self, map)
	
	GlobalScore.money = 100
	GlobalScore.game_ended = false

func _process(delta):
	$Control/money_label.text = "Money: %d ¥" % GlobalScore.money
	$Control/score_label.text = "Score: %d" % GlobalScore.score


func _on_wave_button_pressed():
	$WaveState.send_event("to_active")


func _on_active_state_entered():
	$Control/wave_button.disabled = true
	wave_manager.spawn_wave()


func ready_for_next_wave():
	if wave_manager.wave_idx == 3:
		get_tree().change_scene_to_file("res://scenes/game_over/game_completed.tscn")
		
	$WaveState.send_event("to_complete")


func _on_complete_state_entered():
	$Control/wave_button.disabled = false
