class_name WaveManager extends Node



var _main:Main
var _map:Map
var wave:Array[Enemy]
var delays_before:Array[float]
var delays_after:Array[float]
var WOMAN_ENEMY_LVL_2_SCENE = preload("res://scenes/enemies/woman_enemy_lvl2_scene.tscn")
var WOMAN_ENEMY_LVL_3_SCENE = preload("res://scenes/enemies/woman_enemy_lvl3_scene.tscn")
var TANK_ENEMY_LVL_5_SCENE = preload("res://scenes/enemies/tank_enemy_lvl5_scene.tscn")

var enemies_remaining = 0
var wave_spawned = false

func _init(main, map):
	_main = main
	_map = map

func spawn_wave():
	_create_wave(4, 3, 2)
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


func _create_wave(woman2, woman3, tank5):
	for i in range(woman2):
		var enemy = WOMAN_ENEMY_LVL_2_SCENE.instantiate()
		wave.append(enemy)
		delays_before.append(1)
		delays_after.append(0.5)
		enemy.connect("enemy_killed", _can_spawn_next_wave)
		enemies_remaining += 1
	for i in range(woman3):
		var enemy = WOMAN_ENEMY_LVL_3_SCENE.instantiate()
		wave.append(enemy)
		delays_before.append(0.5)
		delays_after.append(0.25)
		enemy.connect("enemy_killed", _can_spawn_next_wave)
		enemies_remaining += 1
	for i in range(tank5):
		var enemy = TANK_ENEMY_LVL_5_SCENE.instantiate()
		wave.append(enemy)
		delays_before.append(0)
		delays_after.append(6)
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
	for i in range(len(wave)):
		var enemy = wave[i]
		var delay_before = delays_before[i]
		var delay_after = delays_after[i]
		await _main.get_tree().create_timer(delay_before).timeout
		move_along(enemy, _map.get_path())
		await _main.get_tree().create_timer(delay_after).timeout
		
		
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
		if e._movement_animation != null:
			e._movement_animation.play("mixamo_com")
		await _main.get_tree().create_timer(0.01).timeout
