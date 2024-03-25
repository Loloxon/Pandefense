extends Node3D

var _enemies_in_range:Array[Node3D]

func _on_patrol_zone_area_entered(area):
	#print(area, " entered")
	_enemies_in_range.append(area.get_node("../..")) #considered bad practice -> replace later if possible!
	#print(_enemies_in_range.size())


func _on_patrol_zone_area_exited(area):
	#print(area, " exited")
	_enemies_in_range.erase(area.get_node("../..")) #considered bad practice -> replace later if possible!
	#print(_enemies_in_range.size())


func set_patrolling(patrolling: bool):
	$PatrolZone.monitoring = patrolling
