class_name BananaProjectile extends "res://projectiles/projectile.gd"


func _ready():
	speed = 2
	rotation_speed_deg = Vector3(5, 0, 8)
	global_position = starting_position


