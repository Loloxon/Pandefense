class_name WaveManager extends Object

var enemies_number:int = 5
var delay:float = 1.5
var _main:Main
var _map:Map
var wave:Array[Enemy]

func _init(main, map):
	_main = main
	_map = map

func spawn_wave():
	_create_wave()
	_move_wave()
	while true:
		#print(wave)
		#for e in wave:
			#if e.is_alive():
				#print(e.get_info())
		await _main.get_tree().create_timer(1).timeout


func simulate_fights():
	while true:
		for e in wave:
			if e.is_alive():
				e.receive_dmg(0.2)
				if randf() < 0.1 and e.is_alive():
					e.heal_dmg(10)
				if randf() < 0.01 and e.is_alive():
					e.instakill()
		await _main.get_tree().create_timer(0.1).timeout


func kill_enemy(enemy):
	for i in range(len(wave)):
		if wave[i] == enemy:
			wave.pop_at(i)
			break


func _create_wave():
	for i in range(enemies_number):
		wave.append(Panda.new(i, _main, self))


func _move_wave():
	for e in wave:
		await _main.get_tree().create_timer(delay).timeout
		e.move_along(_map.get_path())
