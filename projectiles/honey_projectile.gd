class_name FishProjectile extends "res://projectiles/projectile.gd"


func _ready():
	speed = 0.1
	rotation_speed_deg = Vector3(2, 0, 3)
	global_position = starting_position

