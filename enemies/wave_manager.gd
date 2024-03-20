class_name WaveManager extends Object

var enemies_number:int = 5
var delay:float = 1.5
var _main:Main
var _map:Map
var wave:Array

func _init(main, map):
	_main = main
	_map = map

func spawn_wave():
	_create_wave()
	_move_wave()


func kill_enemy(id):
	wave.pop_at(id)


func _create_wave():
	for i in range(enemies_number):
		wave.append(Panda.new(_main, self))


func _move_wave():
	for e in wave:
		print(e)
		e.move_along(_map.get_path())
		await _main.get_tree().create_timer(delay).timeout
