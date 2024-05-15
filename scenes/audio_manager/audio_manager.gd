extends Node3D


func play_music(music):
	$Music_player.stream = music
	$Music_player.play()


func play_effect(clip, type):
	var effect_player
	var effect_slot
	
	if type == "projectile":
		effect_player = $projectile_effect_player
	else:
		effect_player = $enemy_effect_player
		
	for i in range(effect_player.get_child_count()):
		effect_slot = effect_player.get_child(i)
		if !effect_slot.playing:
			effect_slot.stream = clip
			effect_slot.play()
			return
			
