class_name WaveManager extends Node


var _main:Main
var _map:Map
var wave:Array[Enemy]
var delays_before_total:Array[float]
var delays_after_total:Array[float]
var WOMAN_ENEMY_LVL_2_SCENE = preload("res://scenes/enemies/woman_enemy_lvl2_scene.tscn")
var WOMAN_ENEMY_LVL_3_SCENE = preload("res://scenes/enemies/woman_enemy_lvl3_scene.tscn")
var TANK_ENEMY_LVL_5_SCENE = preload("res://scenes/enemies/tank_enemy_lvl5_scene.tscn")

var enemies_remaining = 0
var wave_spawned = false

var waves = [[6, 0, 0],
			[6, 3, 0],
			[2, 8, 1],
			[4, 4, 2],
			[0, 0, 4]]
var delays_before = [[1, 1, 0],
					[0.5, 0, 0],
					[0.5, 0, 0],
					[0.5, 0, 0],
					[1, 1, 0]]
var delays_after = [[1, 1, 6],
					[0.5, 0.5, 6],
					[0.5, 0.5, 6],
					[0.5, 0.5, 6],
					[1, 1, 4]]
var wave_idx:int = 2

func _init(main, map):
	_main = main
	_map = map

func spawn_wave():
	var delay_multiplayer = 1.5-round(wave_idx/5)*0.2
	var count_multiplayer = 1+round(wave_idx/5)*0.3
	var valid_wave_idx = wave_idx%5
		
	_create_wave(waves[valid_wave_idx][0], delays_before[valid_wave_idx][0], delays_after[valid_wave_idx][0],
				waves[valid_wave_idx][1], delays_before[valid_wave_idx][1], delays_after[valid_wave_idx][1],
				waves[valid_wave_idx][2], delays_before[valid_wave_idx][2], delays_after[valid_wave_idx][2],
				delay_multiplayer, count_multiplayer)
	wave_idx+=1
	_move_wave()


func kill_enemy(enemy):
	for i in range(len(wave)):
		if wave[i] == enemy:
			wave.pop_at(i)
			break


func _create_wave(woman2, woman2_delays_before, woman2_delays_after,
				woman3, woman3_delays_before, woman3_delays_after,
				tank5, tank5_delays_before, tank5_delays_after,
				delay_multiplayer, count_multiplayer):
	woman2 = round(woman2*count_multiplayer)
	woman3 = round(woman3*count_multiplayer)
	tank5 = round(tank5*count_multiplayer)
	delays_before_total.clear()
	delays_after_total.clear()
		
	for i in range(woman2):
		var enemy = WOMAN_ENEMY_LVL_2_SCENE.instantiate()
		wave.append(enemy)
		delays_before_total.append(woman2_delays_before*delay_multiplayer)
		delays_after_total.append(woman2_delays_after*delay_multiplayer)
		enemy.connect("enemy_killed", _can_spawn_next_wave)
		enemies_remaining += 1
	for i in range(woman3):
		var enemy = WOMAN_ENEMY_LVL_3_SCENE.instantiate()
		wave.append(enemy)
		delays_before_total.append(woman3_delays_before*delay_multiplayer)
		delays_after_total.append(woman3_delays_after*delay_multiplayer)
		enemy.connect("enemy_killed", _can_spawn_next_wave)
		enemies_remaining += 1
	for i in range(tank5):
		var enemy = TANK_ENEMY_LVL_5_SCENE.instantiate()
		wave.append(enemy)
		delays_before_total.append(tank5_delays_before*delay_multiplayer)
		delays_after_total.append(tank5_delays_after*delay_multiplayer)
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
		var delay_before = delays_before_total[i]
		var delay_after = delays_after_total[i]
		if _main:
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
