extends "res://turrets/turret.gd"

func _ready():
	attack_speed_rate = 2000
	tower_dmg = 20
	_movement_animation = $bear/AnimationPlayer


	
func follow_target(target, delta):
	var target_vector = $bear.global_position.direction_to(
		Vector3(target.global_position.x, target.global_position.y, target.global_position.z))
	var target_basis:Basis = Basis.looking_at(
		Vector3(target_vector.x, 0, target_vector.z))
	$bear.basis = $bear.basis.slerp(target_basis, _slerp_progress)
	_slerp_progress += delta

	if _slerp_progress > 1:
		$StateChart.send_event("to_attacking")



func _on_attacking_state_physics_processing(delta):
	if _current_enemy != null and _enemies_in_range.has(_current_enemy):
		
		var target_vector = $bear.global_position.direction_to(
			Vector3(_current_enemy.global_position.x, _current_enemy.global_position.y, _current_enemy.global_position.z))
		var target_basis:Basis = Basis.looking_at(
			Vector3(target_vector.x, 0, target_vector.z))
		$bear.basis = $bear.basis.slerp(target_basis, _slerp_progress)
		_fire_projectile_if_possible()
	else:
		$StateChart.send_event("to_patrolling")
		

func _fire_projectile_if_possible():
	_movement_animation.speed_scale = 16
	if Time.get_ticks_msec() > (_latest_projectile_fired + attack_speed_rate) and not _waiting_for_projectile:
		_waiting_for_projectile = true
		_latest_animation = Time.get_ticks_msec()
		_movement_animation.play("metarig|metarigAction")
	if Time.get_ticks_msec() > (_latest_animation + 200) and _waiting_for_projectile:
		_latest_projectile_fired = Time.get_ticks_msec()
		_waiting_for_projectile = false
		var projectile:Projectile = tower_projectile.instantiate()
		projectile.starting_position = $bear/projectile_spawn.global_position
		projectile.target = _current_enemy
		add_child(projectile)
	
