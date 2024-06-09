extends CanvasLayer


## Called when the node enters the scene tree for the first time.
func _ready():
	$score_enemies_label.text = "Points for defeated enemies: %d * 100" % GlobalScore.score
	$score_money_label.text = "Points for saved money: %d" % GlobalScore.money
	$score_final_label.text = "Final score: %d" % ((GlobalScore.score * 100) + GlobalScore.money)
	GlobalScore.game_ended = true


func _on_play_again_pressed():
	GlobalScore.money = 0
	GlobalScore.score = 0
	get_tree().change_scene_to_file("res://main/main.tscn")


func _on_quit_pressed():
	get_tree().quit()
