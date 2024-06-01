extends CanvasLayer


## Called when the node enters the scene tree for the first time.
func _ready():
	$score_label.text = "Your score was: %d" % GlobalScore.score
	GlobalScore.money = 0
	GlobalScore.game_ended = true


func _on_play_again_pressed():
	GlobalScore.score = 0
	get_tree().change_scene_to_file("res://main/main.tscn")


func _on_quit_pressed():
	get_tree().quit()
