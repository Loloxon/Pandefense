extends Node3D

@export var attack_speed_rate:int = 500
@export var tower_projectile:PackedScene = null
@export var tower_dmg:int = 4

var _enemies_in_range:Array[Node3D]
var _slerp_progress:float = 0
var _current_enemy_targeted:bool = false
var _current_enemy:Node3D = null
var _latest_projectile_fired:int
var _latest_animation:int
var _waiting_for_projectile:bool = false
@onready var _movement_animation:AnimationPlayer = $monkey/AnimationPlayer


func _on_patrol_zone_area_entered(area):
	var enemy_node = area #.get_node("../..") #considered bad practice -> replace later if possible!
	
	if _current_enemy == null:
		_current_enemy = enemy_node

	_enemies_in_range.append(enemy_node) 


func _on_patrol_zone_area_exited(area):
	_enemies_in_range.erase(area)#.get_node("../..")) #considered bad practice -> replace later if possible!


func set_patrolling(patrolling: bool):
	$PatrolZone.monitoring = patrolling
	
func follow_target(target, delta):
	var target_vector = $monkey.global_position.direction_to(
		Vector3(target.global_position.x, target.global_position.y, target.global_position.z))
	var target_basis:Basis = Basis.looking_at(
		Vector3(target_vector.x, 0, target_vector.z))
	$monkey.basis = $monkey.basis.slerp(target_basis, _slerp_progress)
	_slerp_progress += delta

	if _slerp_progress > 1:
		$StateChart.send_event("to_attacking")


func _on_patrolling_state_processing(_delta):
	if _enemies_in_range.size() > 0:
		_current_enemy = _enemies_in_range[0]
		#print("Enemy spotted")
		$StateChart.send_event("to_targeting")

func _on_targeting_state_entered():
	_current_enemy_targeted = false
	_slerp_progress = 0
	#print("Start of targetting")

func _on_targeting_state_physics_processing(delta):
	if _current_enemy != null and _enemies_in_range.has(_current_enemy):
		follow_target(_current_enemy, delta)
	else:
		$StateChart.send_event("to_patrolling")

func _on_attacking_state_physics_processing(delta):
	if _current_enemy != null and _enemies_in_range.has(_current_enemy):
		
		var target_vector = $monkey.global_position.direction_to(
			Vector3(_current_enemy.global_position.x, _current_enemy.global_position.y, _current_enemy.global_position.z))
		var target_basis:Basis = Basis.looking_at(
			Vector3(target_vector.x, 0, target_vector.z))
		$monkey.basis = $monkey.basis.slerp(target_basis, _slerp_progress)
		_fire_projectile_if_possible()
	else:
		$StateChart.send_event("to_patrolling")
		

func _fire_projectile_if_possible():
	_movement_animation.speed_scale = 4
	if Time.get_ticks_msec() > (_latest_projectile_fired + attack_speed_rate) and not _waiting_for_projectile:
		_waiting_for_projectile = true
		_latest_animation = Time.get_ticks_msec()
		_movement_animation.play("mixamo_com")
	if Time.get_ticks_msec() > (_latest_animation + 200) and _waiting_for_projectile:
		_latest_projectile_fired = Time.get_ticks_msec()
		_waiting_for_projectile = false
		var projectile:Projectile = tower_projectile.instantiate()
		projectile.starting_position = $monkey/projectile_spawn.global_position
		projectile.target = _current_enemy
		add_child(projectile)

func _on_attacking_state_entered():
	_latest_projectile_fired = 0
	_latest_animation = 0
	
