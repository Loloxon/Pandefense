class_name HoneyProjectile extends "res://projectiles/projectile.gd"


func _ready():
	speed = 3
	rotation_speed_deg = Vector3(10, 0, 15)
	global_position = starting_position

