class_name WaveManager extends Node

var enemies_number:int = 5
var delay:float = 2
var _main:Main
var _map:Map
var wave:Array[Enemy]
var woman_walking_scene = preload("res://scenes/enemies/woman_walking_scene.tscn")

var enemies_remaining = 0
var wave_spawned = false

func _init(main, map):
	_main = main
	_map = map

func spawn_wave():
	_create_wave()
	_move_wave()
	#while true:
		#print(wave)
		#for e in wave:
			#if e.is_alive():
				#print(e.get_info())
		#await _main.get_tree().create_timer(1).timeout


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
		var enemy = woman_walking_scene.instantiate()
		wave.append(enemy)
		enemy.connect("enemy_killed", _can_spawn_next_wave)
		enemies_remaining += 1
	wave_spawned = true


func _can_spawn_next_wave():
	enemies_remaining -= 1
	if enemies_remaining <= 0 and wave_spawned:
		wave = []
		_main.ready_for_next_wave()
		wave_spawned = false


func _move_wave():
	for e in wave:
		await _main.get_tree().create_timer(delay).timeout
		move_along(e, _map.get_path())
		
		
func move_along(e, path):
	var c3d:Curve3D = Curve3D.new()
	
	for element in path:
		c3d.add_point(Vector3(element.x, 0.1, element.y))

	var p3d:Path3D = Path3D.new()
	_main.add_child(p3d)
	e._alive = true
	
	p3d.curve = c3d
	
	var pf3d:PathFollow3D = PathFollow3D.new()
	p3d.add_child(pf3d)
	
	pf3d.add_child(e)
	e._create_model()	
	
	var curr_distance:float = 0.0
	
	while is_instance_valid(e) and curr_distance < c3d.point_count-1:
		curr_distance += e._speed
		pf3d.progress = clamp(curr_distance, 0, c3d.point_count-1.00001)
		e._movement_animation.play("mixamo_com")
		await _main.get_tree().create_timer(0.01).timeout
