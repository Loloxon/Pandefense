extends Node3D

@onready var _instance:Node3D
@onready var health_bar = $base_health/ProgressBar

var _max_hp:float = 10
var _current_hp:float
var _alive:bool = true
var pandas:Array[Node3D]

func _init():
	_current_hp = _max_hp
	_check_validity()

func _check_validity():
	assert( _max_hp > 0, "ERROR: Base max hp must be greater then 0.");


func receive_dmg(dmg):
	_current_hp = max(snappedf(_current_hp-dmg, 0.01), 0)
	_kill_pandas(dmg)
	_check_if_dying()
	_change_health_bar()
	
func _change_health_bar():
	health_bar.value = (_current_hp * 100) / _max_hp

func _kill():
	_alive = false
	get_tree().change_scene_to_file("res://scenes/game_over/game_over.tscn")

func _kill_pandas(dmg):
	var pandas_killed = 0
	while dmg>0:
		var index = 0
		var panda = pandas[index]
		pandas.remove_at(index)
		#panda.fall_animation.play("Cylinder_001_0Action_001")
		panda.queue_free()
		
		dmg -= 1

func _check_if_dying():
	if _current_hp<=0:
		_kill()


func _on_area_entered(area):
	var groups = area.get_groups()
	if len(groups) > 0 and groups[0] == "enemy":
		receive_dmg(area.get_node("../..").dmg)
